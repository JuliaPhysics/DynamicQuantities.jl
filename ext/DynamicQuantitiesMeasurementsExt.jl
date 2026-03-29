module DynamicQuantitiesMeasurementsExt

using DynamicQuantities: UnionAbstractQuantity, new_quantity, dimension, ustrip, DimensionError, ABSTRACT_QUANTITY_TYPES
using Measurements: Measurements, Measurement, measurement, value, uncertainty
import Base.FastMath: div_fast

function Measurements.measurement(a::Q, b::Q) where {Q <: UnionAbstractQuantity}
    dimension(a) == dimension(b) || throw(DimensionError(a, b))
    raw_measurement = measurement(ustrip(a), ustrip(b))
    return new_quantity(Q, raw_measurement, dimension(a))
end
function Measurements.measurement(a::UnionAbstractQuantity, b::UnionAbstractQuantity)
    return measurement(promote(a, b)...)
end

Measurements.value(q::Q) where {Q <: UnionAbstractQuantity} = new_quantity(Q, value(ustrip(q)), dimension(q))
Measurements.uncertainty(q::Q) where {Q <: UnionAbstractQuantity} = new_quantity(Q, uncertainty(ustrip(q)), dimension(q))

for (Q, _, _) in ABSTRACT_QUANTITY_TYPES
    @eval begin
        Base.:/(a::$Q, b::Measurement) = new_quantity(typeof(a), ustrip(a) / b, dimension(a))
        Base.:/(a::Measurement, b::$Q) = new_quantity(typeof(b), a / ustrip(b), inv(dimension(b)))

        # `@fastmath` rewrites `/` to `div_fast`; keep mixed Quantity/Measurement arithmetic on
        # the normal promotion path instead of erroring inside SciML residual calculations.
        div_fast(a::$Q, b::Measurement) = a / b
        div_fast(a::Measurement, b::$Q) = a / b
    end
end

end
