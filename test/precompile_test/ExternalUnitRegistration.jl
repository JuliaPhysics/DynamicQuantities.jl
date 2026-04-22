module ExternalUnitRegistration

using DynamicQuantities: @register_unit, @u_str, @us_str
using DynamicQuantities: ALL_MAPPING, ALL_SYMBOLS,  DEFAULT_QUANTITY_TYPE
using DynamicQuantities: DEFAULT_SYMBOLIC_QUANTITY_OUTPUT_TYPE, UNIT_SYMBOLS, UNIT_MAPPING
using Test

@register_unit MyWb u"m^2*kg*s^-2*A^-1"

expanded_mywb() = 1u"MyWb"
symbolic_mywb() = 1us"MyWb"

@testset "Register Unit Inside a Module" begin
    for collection in (UNIT_SYMBOLS, ALL_SYMBOLS, keys(ALL_MAPPING._raw_data), keys(UNIT_MAPPING._raw_data))
        @test :MyWb ∈ collection
    end

    w = expanded_mywb()
    ws = symbolic_mywb()
    @test w isa DEFAULT_QUANTITY_TYPE
    @test ws isa DEFAULT_SYMBOLIC_QUANTITY_OUTPUT_TYPE
    @test w == u"MyWb"
    @test ws == us"MyWb"
    @test string(ws) == "1.0 MyWb"
end

end
