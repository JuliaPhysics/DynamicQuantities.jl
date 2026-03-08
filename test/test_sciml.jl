using Test
using DynamicQuantities

@testset "SciMLBase extension" begin
    using SciMLBase

    for Q in (Quantity, RealQuantity, GenericQuantity)
        q = Q(1.5, length=1)

        @test SciMLBase.value(q) == 1.5
        @test SciMLBase.value(typeof(q)) == Float64

        @test SciMLBase.unitfulvalue(q) == q
        @test SciMLBase.unitfulvalue(typeof(q)) == typeof(q)
    end
end

@testset "RecursiveArrayTools extension" begin
    using RecursiveArrayTools

    for Q in (Quantity, RealQuantity, GenericQuantity)
        q = Q(1.5, length=1)

        @test RecursiveArrayTools.recursive_unitless_eltype(typeof(q)) == Float64
        @test RecursiveArrayTools.recursive_unitless_bottom_eltype(typeof(q)) == Float64
    end

    qmat = GenericQuantity(ones(2, 2), length=1)
    @test RecursiveArrayTools.recursive_unitless_eltype(typeof(qmat)) ==
          RecursiveArrayTools.recursive_unitless_eltype(Matrix{Float64})
    @test RecursiveArrayTools.recursive_unitless_bottom_eltype(typeof(qmat)) ==
          RecursiveArrayTools.recursive_unitless_bottom_eltype(Matrix{Float64})
end
