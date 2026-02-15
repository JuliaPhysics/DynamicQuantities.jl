import DynamicQuantities
using Test

q = 3.0u"m"

# (no `dimensions` alias; keep only `dimension`)
@test DynamicQuantities.isunitless(1.0)
@test DynamicQuantities.isdimensionless(1.0)
@test !DynamicQuantities.isunitless(q)
@test !DynamicQuantities.isdimensionless(q)

@test DynamicQuantities.unit(q) == 1.0u"m"
@test DynamicQuantities.isunitless(DynamicQuantities.unit(1))
@test DynamicQuantities.isunitless(DynamicQuantities.unit(Float64))
@test DynamicQuantities.ustrip(DynamicQuantities.unit(1)) == 1.0
@test DynamicQuantities.ustrip(DynamicQuantities.unit(Float64)) == 1.0

@test DynamicQuantities.upreferred(q) === q
@test DynamicQuantities.upreferred(2.0) == 2.0

@test DynamicQuantities.ustrip(Float32, u"m", 3.0u"m") === Float32(3.0)
@test DynamicQuantities.ustrip(Float64, u"km", 2500.0u"m") === 2.5

@test DynamicQuantities.uparse(u"m", "3.0") == 3.0u"m"
@test DynamicQuantities.uparse(u"km", "3.0") == 3.0u"km"
@test DynamicQuantities.uparse(u"m", 2) == 2.0u"m"
@test_throws ArgumentError DynamicQuantities.uparse(u"m", "x")

@test DynamicQuantities.NoUnits == DynamicQuantities.dimensionless
@test DynamicQuantities.dimensionless == DynamicQuantities.NoDims()
