module DynamicQuantities

export Units, Constants
export AbstractQuantity, AbstractDimensions
export Quantity, Dimensions, SymbolicDimensions, QuantityArray, DimensionError
export ustrip, dimension
export ulength, umass, utime, ucurrent, utemperature, uluminosity, uamount
export uparse, @u_str, sym_uparse, @us_str, uexpand, uconvert

include("fixed_rational.jl")
include("lazy_float.jl")

include("types.jl")
include("utils.jl")
include("math.jl")
include("arrays.jl")
include("units.jl")
include("constants.jl")
include("uparse.jl")
include("symbolic_dimensions.jl")

include("deprecated.jl")
export expand_units

import PackageExtensionCompat: @require_extensions
import .Units
import .Units: DEFAULT_UNIT_TYPE
import .Constants
import .UnitsParse: uparse, @u_str

function __init__()
    @require_extensions
end

end
