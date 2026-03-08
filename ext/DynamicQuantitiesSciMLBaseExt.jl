module DynamicQuantitiesSciMLBaseExt

using DynamicQuantities
import SciMLBase: unitfulvalue, value

for (_Q, _, _) in DynamicQuantities.ABSTRACT_QUANTITY_TYPES
    @eval begin
        value(::Type{<:$_Q{T}}) where {T} = T
        value(x::$_Q) = ustrip(x)

        unitfulvalue(::Type{T}) where {T<:$_Q} = T
        unitfulvalue(x::$_Q) = x
    end
end

end
