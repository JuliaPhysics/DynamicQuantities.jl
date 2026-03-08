module DynamicQuantitiesRecursiveArrayToolsExt

using DynamicQuantities
using RecursiveArrayTools

for (Qabs, _, _) in DynamicQuantities.ABSTRACT_QUANTITY_TYPES
    @eval begin
        RecursiveArrayTools.recursive_unitless_bottom_eltype(::Type{<:$Qabs{T,D}}) where {T,D} =
            RecursiveArrayTools.recursive_unitless_bottom_eltype(T)
        RecursiveArrayTools.recursive_unitless_eltype(::Type{<:$Qabs{T,D}}) where {T,D} =
            RecursiveArrayTools.recursive_unitless_eltype(T)
    end
end

end
