module Constants

import ..Quantity
import ..Units as U
import ..Units: _add_prefixes, DEFAULT_UNIT_TYPE

const _CONSTANT_SYMBOLS = Symbol[]
const _CONSTANT_VALUES = DEFAULT_UNIT_TYPE[]

macro register_constant(name, value)
    return esc(_register_constant(name, value))
end

macro add_prefixes(base_unit, prefixes)
    @assert prefixes.head == :tuple
    return esc(_add_prefixes(base_unit, prefixes.args, _register_constant))
end

function _register_constant(name::Symbol, value)
    s = string(name)
    return quote
        const $name = convert(DEFAULT_UNIT_TYPE, $value)
        push!(_CONSTANT_SYMBOLS, Symbol($s))
        push!(_CONSTANT_VALUES, $name)
    end
end

# Source: http://physics.nist.gov/constants (2018)

# Exact, base:
@register_constant c 299792458 * U.m/U.s
@register_constant h 6.62607015e-34 * U.J/U.Hz
@register_constant hbar h / (2π)
@register_constant e 1.602176634e-19 * U.C
@register_constant k_B 1.380649e-23 * U.J/U.K
@register_constant N_A 6.02214076e+23 / U.mol

@doc(
    "Speed of light in a vacuum. Standard.",
    c,
)
@doc(
    "Planck constant. Standard.",
    h,
)
@doc(
    "Reduced Planck constant (h/2π). Standard.",
    hbar,
)
@doc(
    "Elementary charge. Standard.",
    e,
)
@doc(
    "Boltzmann constant. Standard.",
    k_B,
)
@doc(
    "Avogadro constant. Standard.",
    N_A,
)

# Exact, derived:
@register_constant eV e * U.J/U.C
@register_constant R N_A * k_B
@register_constant F N_A * e
@register_constant sigma_sb (π^2/60) * k_B^4/(hbar^3 * c^2)

@add_prefixes eV (m, k, M, G, T)

@doc(
    "Electron volt. Standard.",
    eV,
)
@doc(
    "Molar gas constant. Standard.",
    R,
)
@doc(
    "Faraday constant. Standard.",
    F,
)
@doc(
    "Stefan-Boltzmann constant. Standard.",
    sigma_sb,
)

# Measured
@register_constant alpha DEFAULT_UNIT_TYPE(7.2973525693e-3)
@register_constant u 1.66053906660e-27 * U.kg
@register_constant G 6.67430e-11 * U.m^3 / (U.kg * U.s^2)
@register_constant mu_0 4π * alpha * hbar / (e^2 * c)
@register_constant eps_0 8.8541878128e-12 * U.F/U.m
@register_constant m_e 9.1093837015e-31 * U.kg
@register_constant m_p 1.67262192369e-27 * U.kg
@register_constant m_n 1.67492749804e-27 * U.kg
@register_constant a_0 hbar/(m_e * c * alpha)
@register_constant k_e 1/(4π * eps_0)
@register_constant Ryd alpha^2 * m_e * c^2 / (2 * h)

@doc(
    "Fine-structure constant. Measured.",
    alpha,
)
@doc(
    "Atomic mass unit (1/12th the mass of Carbon-12). Measured.",
    u,
)
@doc(
    "Newtonian constant of gravitation. Measured.",
    G,
)
@doc(
    "Vacuum magnetic permeability. Measured.",
    mu_0,
)
@doc(
    "Vacuum electric permittivity. Measured.",
    eps_0,
)
@doc(
    "Electron mass. Measured.",
    m_e,
)
@doc(
    "Proton mass. Measured.",
    m_p,
)
@doc(
    "Neutron mass. Measured.",
    m_n,
)
@doc(
    "Bohr radius. Measured.",
    a_0,
)
@doc(
    "Coulomb constant (Note: SI units only!). Measured.",
    k_e,
)
@doc(
    "Rydberg frequency. Measured.",
    Ryd,
)

# Astro constants.
# Source: https://arxiv.org/abs/1510.07674

@register_constant M_earth 5.97216787e+24 * U.kg
@register_constant M_sun 1.98840987e+30 * U.kg
@register_constant M_jup 1.8981246e+27 * U.kg
@register_constant R_earth 6.3781e+6 * U.m
@register_constant R_jup 7.1492e+7 * U.m
@register_constant R_sun 6.957e+8 * U.m
@register_constant L_sun 3.828e+26 * U.W
@register_constant L_bol0 3.0128e+28 * U.W
@register_constant sigma_T 6.6524587321e-29 * U.m^2
@register_constant au 149597870700 * U.m
@register_constant pc (648000/π) * au
@register_constant ly c * U.yr
@register_constant atm 101325 * U.Pa

@add_prefixes pc (k, M, G)

@doc(
    "Earth mass. Measured.",
    M_earth,
)
@doc(
    "Solar mass. Measured.",
    M_sun,
)
@doc(
    "Jupiter mass. Measured.",
    M_jup,
)
@doc(
    "Nominal Earth equatorial radius. Standard.",
    R_earth,
)
@doc(
    "Nominal Jupiter equatorial radius. Standard.",
    R_jup,
)
@doc(
    "Nominal solar radius. Standard.",
    R_sun,
)
@doc(
    "Nominal solar luminosity. Standard.",
    L_sun,
)
@doc(
    "Standard luminosity at absolute bolometric magnitude 0. Standard.",
    L_bol0,
)
@doc(
    "Thomson scattering cross-section. Measured.",
    sigma_T,
)
@doc(
    "Astronomical unit. Standard.",
    au,
)
@doc(
    "Parsec. Standard.",
    pc,
)
@doc(
    "Light year. Standard.",
    ly,
)
@doc(
    "Standard atmosphere. Standard.",
    atm,
)

"""A tuple of all possible constants."""
const CONSTANT_SYMBOLS = Tuple(_CONSTANT_SYMBOLS)
const CONSTANT_VALUES = Tuple(_CONSTANT_VALUES)
const CONSTANT_MAPPING = NamedTuple([s => i for (i, s) in enumerate(CONSTANT_SYMBOLS)])

end
