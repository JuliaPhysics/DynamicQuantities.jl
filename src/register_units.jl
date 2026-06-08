import .Units: UNIT_MAPPING, UNIT_SYMBOLS, UNIT_VALUES
import .SymbolicUnits: update_external_symbolic_unit_value

# Update the unit collections
const UNIT_UPDATE_LOCK = Threads.SpinLock()

function update_all_values_unlocked(name_symbol, unit)
    push!(UNIT_SYMBOLS, name_symbol)
    push!(UNIT_VALUES, unit)
    push!(ALL_SYMBOLS, name_symbol)
    push!(ALL_VALUES, unit)
    i = lastindex(ALL_VALUES)
    ALL_MAPPING[name_symbol] = i
    UNIT_MAPPING[name_symbol] = i
    update_external_symbolic_unit_value(name_symbol)
end

function update_all_values(name_symbol, unit)
    lock(UNIT_UPDATE_LOCK) do
        index = get(ALL_MAPPING, name_symbol, INDEX_TYPE(0))
        if iszero(index)
            update_all_values_unlocked(name_symbol, unit)
        elseif ALL_VALUES[index] != unit
            error("Unit `$name_symbol` is already defined as `$(ALL_VALUES[index])`")
        end
    end
end

function define_unit_binding(mod::Module, name::Symbol, unit)
    if !isdefined(mod, name)
        Core.eval(mod, Expr(:const, Expr(:(=), name, QuoteNode(unit))))
    end
    return unit
end

"""
    @register_unit symbol value

Register a new unit under the given symbol to have
a particular value.

# Example

```jldoctest register-unit
julia> @register_unit MyVolt 1.5u"V"
```

This will register a new unit `MyVolt` with a value of `1.5u"V"`.
You can then use this unit in your calculations:

```jldoctest register-unit
julia> x = 20us"MyVolt^2"
20.0 MyVolt²

julia> y = 2.5us"A"
2.5 A

julia> x * y^2 |> us"W^2"
281.25 W²

julia> x * y^2 |> us"W^2" |> sqrt |> uexpand
16.77050983124842 m² kg s⁻³
```

"""
macro register_unit(symbol, value)
    declare_external_unit(__module__, symbol)
    return esc(_register_unit(__module__, symbol, value))
end

function _register_unit(mod::Module, name::Symbol, value)
    name_symbol = Meta.quot(name)
    index = get(ALL_MAPPING, name, INDEX_TYPE(0))
    if !iszero(index)
        unit = ALL_VALUES[index]
        # When a utility function to expand `value` to its final form becomes
        # available, enable the following check. This will avoid throwing an error
        # if user is trying to register an existing unit with matching values.
        # unit.value != value && throw("Unit $name is already defined as $unit")
        error("Unit `$name` is already defined as `$unit`")
    end
    return quote
        local unit = $value
        $define_unit_binding($(QuoteNode(mod)), $name_symbol, unit)
        $update_all_values($name_symbol, unit)
        nothing
    end
end
