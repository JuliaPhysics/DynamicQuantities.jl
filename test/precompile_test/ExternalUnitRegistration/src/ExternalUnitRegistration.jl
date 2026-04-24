module ExternalUnitRegistration

using DynamicQuantities: @register_unit, @u_str, @us_str
using DynamicQuantities: DEFAULT_QUANTITY_TYPE, DEFAULT_SYMBOLIC_QUANTITY_OUTPUT_TYPE

@register_unit MyWb u"m^2*kg*s^-2*A^-1"

const MYWB_EXPANDED = u"MyWb"

expanded_mywb() = 1u"MyWb"
symbolic_mywb() = 1us"MyWb"
expanded_mywb_from_helper() = one(expanded_mywb()) * u"MyWb"
symbolic_mywb_from_helper() = one(symbolic_mywb()) * us"MyWb"
expanded_constant_mywb() = MYWB_EXPANDED

export MyWb
export MYWB_EXPANDED
export expanded_constant_mywb, expanded_mywb, expanded_mywb_from_helper
export symbolic_mywb, symbolic_mywb_from_helper

end
