function external_quantity_binding(mod::Module, sym::Symbol)
    return isdefined(mod, sym) && getfield(mod, sym) isa UnionAbstractQuantity
end

function ensure_registered_external_unit(sym::Symbol, unit::UnionAbstractQuantity)
    lock(UNIT_UPDATE_LOCK) do
        if iszero(get(UNIT_MAPPING, sym, 0))
            update_all_values_unlocked(sym, unit)
        end
    end
    return nothing
end

function lookup_registered_unit(sym::Symbol)
    i = get(UNIT_MAPPING, sym, 0)
    iszero(i) && throw(ArgumentError("Symbol $sym not found in `Units`."))
    return ALL_VALUES[i]
end

module UnitsParse

using DispatchDoctor: @unstable

import ..constructorof
import ..DEFAULT_QUANTITY_TYPE
import ..DEFAULT_DIM_TYPE
import ..DEFAULT_VALUE_TYPE
import ..external_quantity_binding
import ..ensure_registered_external_unit
import ..lookup_registered_unit
import ..Units: UNIT_SYMBOLS
import ..Constants: CONSTANT_SYMBOLS, CONSTANT_VALUES
import ..Constants

function _generate_units_import()
    import_expr = :(import ..Units: _)
    deleteat!(first(import_expr.args).args, 2)
    for symb in UNIT_SYMBOLS
        push!(first(import_expr.args).args, Expr(:., symb))
    end
    return import_expr
end
macro generate_units_import()
    return _generate_units_import()
end

@generate_units_import

"""
    uparse(s::AbstractString)

Parse a string containing an expression of units and return the
corresponding `Quantity` object with `Float64` value. For example,
`uparse("m/s")` would be parsed to `Quantity(1.0, length=1, time=-1)`.

Note that inside this expression, you also have access to the `Constants`
module. So, for example, `uparse("Constants.c^2 * Hz^2")` would evaluate to
the quantity corresponding to the speed of light multiplied by Hertz,
squared.
"""
function uparse(s::AbstractString)
    ex = map_to_scope(Meta.parse(s))
    ex = :($as_quantity($ex))
    return eval(ex)::DEFAULT_QUANTITY_TYPE
end

as_quantity(q::DEFAULT_QUANTITY_TYPE) = q
as_quantity(x::Number) = convert(DEFAULT_QUANTITY_TYPE, x)
as_quantity(x) = error("Unexpected type evaluated: $(typeof(x))")

"""
    u"[unit expression]"

Parse a string containing an expression of units and return the
corresponding `Quantity` object with `Float64` value. For example,
`u"km/s^2"` would be parsed to `Quantity(1000.0, length=1, time=-2)`.

Note that inside this expression, you also have access to the `Constants`
module. So, for example, `u"Constants.c^2 * Hz^2"` would evaluate to
the quantity corresponding to the speed of light multiplied by Hertz,
squared.
"""
macro u_str(s)
    ex = map_to_scope(__module__, Meta.parse(s))
    ex = :($as_quantity($ex))
    return esc(ex)
end

@unstable map_to_scope(ex::Expr) = map_to_scope(@__MODULE__, ex)
@unstable function map_to_scope(mod::Module, ex::Expr)
    if !(ex.head == :call) && !(ex.head == :. && ex.args[1] == :Constants)
        throw(ArgumentError("Unexpected expression: $ex. Only `:call` and `:.` (for `Constants`) are expected."))
    end
    if ex.head == :call
        ex.args[2:end] = map(arg -> map_to_scope(mod, arg), ex.args[2:end])
        return ex
    else # if ex.head == :. && ex.args[1] == :Constants
        @assert ex.args[2] isa QuoteNode
        return Expr(:call, GlobalRef(@__MODULE__, :lookup_constant), QuoteNode(ex.args[2].value))
    end
end
map_to_scope(sym::Symbol) = map_to_scope(@__MODULE__, sym)
function map_to_scope(mod::Module, sym::Symbol)
    has_registered_binding = sym in UNIT_SYMBOLS
    has_external_binding = !(mod === @__MODULE__) && external_quantity_binding(mod, sym)

    if !has_registered_binding && sym in CONSTANT_SYMBOLS
        throw(ArgumentError("Symbol $sym found in `Constants` but not `Units`. Please use `u\"Constants.$sym\"` instead."))
    elseif !has_registered_binding && !has_external_binding
        throw(ArgumentError("Symbol $sym not found in `Units` or `Constants`."))
    elseif has_external_binding
        return Expr(:call, GlobalRef(@__MODULE__, :lookup_external_unit), QuoteNode(mod), QuoteNode(sym))
    end

    return Expr(:call, GlobalRef(@__MODULE__, :lookup_unit), QuoteNode(sym))
end
function map_to_scope(ex)
    return ex
end
map_to_scope(::Module, ex) = ex

@unstable lookup_unit(ex::Symbol) = lookup_registered_unit(ex)
@unstable function lookup_external_unit(mod::Module, sym::Symbol)
    ensure_registered_external_unit(sym, getfield(mod, sym))
    return lookup_registered_unit(sym)
end
function lookup_constant(ex::Symbol)
    i = findfirst(==(ex), CONSTANT_SYMBOLS)::Int
    return CONSTANT_VALUES[i]
end

end
