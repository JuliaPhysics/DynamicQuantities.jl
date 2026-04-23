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
