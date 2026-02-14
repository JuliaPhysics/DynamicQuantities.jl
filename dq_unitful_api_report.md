# DynamicQuantities Unitful API Compatibility Report

## Scope

Targeted high-usage Unitful-style symbols:

- `u"..."/@u_str`
- `unit`
- `dimension`
- `ustrip`
- `uconvert`
- `upreferred`
- `isunitless`
- `uparse`

## Implemented

- `u"..."/@u_str`: supported.
- `dimension(q)`: supported.
- `dimensions(x)`: added as an alias to `dimension(x)`.
- `unit(q)`: added; returns `oneunit(q)` for quantities.
- `unit(::Number)` and `unit(::Type{<:Number})`: added; return a dimensionless multiplicative identity quantity.
- `ustrip(unit, q)`: already supported.
- `ustrip(::Type{T}, unit, q)`: added compatibility overload.
- `isunitless(x)`: added (`iszero(dimension(x))`).
- `isdimensionless(x)`: added alias to `isunitless`.
- `upreferred(x)`: added as no-op compatibility shim.
- `uparse(s::AbstractString)`: already supported for unit expressions.
- `uparse(unit, s::AbstractString)`: added compatibility overload for parsing numeric text in a provided unit context.
- `uparse(unit, x::Number)`: added convenience overload.
- `NoUnits`: added exported alias of `dimensionless`.
- `dimensionless`: added exported alias for `NoDims()`.

## Intentional Differences vs Unitful

- DynamicQuantities does not store preferred-unit metadata, so `upreferred(x)` is intentionally identity.
- `uconvert` semantics remain DynamicQuantities-native; this work intentionally does not force full Unitful-style behavior for all unit-context conversions (for example, code that assumes Unitful’s preferred/display-unit model).
- `NoUnits`/`dimensionless` are compatibility aliases to dimension objects (`NoDims()`), not Unitful internal unit-set types.

## Validation

- Added `test/test_unitful_api_compat.jl` covering compatibility shims and `uparse(unit, value)` overloads.
- Full package test suite run is required to confirm no regressions.
