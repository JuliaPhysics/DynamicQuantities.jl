module DynamicQuantitiesDatesExt

using DynamicQuantities: DynamicQuantities as DQ, AbstractRealQuantity, QuantityArray
using Dates: Dates, Period

Base.:*(A::StridedArray{P}, q::AbstractRealQuantity) where P<:Dates.Period = QuantityArray(A, q)
Base.:*(q::AbstractRealQuantity, A::StridedArray{P}) where P<:Dates.Period = A * q
Base.:/(A::StridedArray{P}, q::AbstractRealQuantity) where P<:Dates.Period = A * inv(q)

end
