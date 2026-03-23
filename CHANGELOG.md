# Changelog

## [1.12.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.11.0...v1.12.0) (2026-03-08)


### Bug Fixes

* SciMLBase/RecursiveArrayTools extensions for SciML compatibility ([#201](https://github.com/JuliaPhysics/DynamicQuantities.jl/issues/201)) ([fa630f1](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/fa630f102f528b27a286c863f332e1138c4775fa))

## [1.11.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.10.0...v1.11.0) (2026-01-06)


### Features

* add some more astro units ([#196](https://github.com/JuliaPhysics/DynamicQuantities.jl/issues/196)) ([33d2b7d](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/33d2b7ddda7f688f6645a7b3ae8b2ad9a8442a75))

## [1.10.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.9.0...v1.10.0) (2025-09-13)


### Features

* create alias for default FixedRational type ([650fa0f](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/650fa0fe318caae44b992cd844c27ca866a0db48))

## [1.9.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.8.1...v1.9.0) (2025-09-13)

## [1.8.1](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.8.0...v1.8.1) (2025-09-13)

## [1.8.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.7.0...v1.8.0) (2025-03-29)


### Features

* 2-arg `ustrip` for affine units ([284586f](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/284586ffceb1c2a97d217db0ca767bd10ba50e09))
* add micro pascal ([1111759](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/111175945bff5421ddf3afa365321a575e841361))
* add micro pascal ([6d839bd](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/6d839bd4dc799e4dec2944f8c94599d5d0c3c70a))
* two-arg `ustrip` ([850e1e9](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/850e1e9f54bf3217e5424982817ff5e4005fad2b))


### Bug Fixes

* affine unit promotion in ustrip ([a4df72b](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/a4df72b0e28f40cc6c4dfd992b91a6a44c2c6cef))
* affine unit promotion in ustrip ([61c90cc](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/61c90cc7c96c5c2451163a74e0c046b61c5e154c))
* promotion of mixed dimensions ([3064294](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/3064294216768ba5cec844206a3b07d01d28e164))
* promotion of two-arg ustrip in arrays ([16defb0](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/16defb0d2d9ad37cb4f1bd0e40eb107e799e428b))

## [1.7.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.6.0...v1.7.0) (2025-03-16)


### Features

* experimental affine units implementation ([#168](https://github.com/JuliaPhysics/DynamicQuantities.jl/issues/168)) ([742caab](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/742caabee8aec0be148a2dfb0d2d4861bd1609b2))

## [1.6.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.5.1...v1.6.0) (2025-03-15)


### Features

* precompilation with PrecompileTools ([#167](https://github.com/JuliaPhysics/DynamicQuantities.jl/issues/167)) ([5028738](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/50287380da9ffaab21576b6ae6f79fde56d7bb6f))

## [1.5.1](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.5.0...v1.5.1) (2025-03-08)


### Bug Fixes

* unqualified imports on 1.12 ([280922f](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/280922fa9ad77b19cb866a50ca3ad2f57f6eb253))
* unqualified imports on 1.12 ([a05d377](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/a05d377b854a9315fd508e68e587807ce657d48a))

## [1.5.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.4.0...v1.5.0) (2025-03-08)


### Features

* add `ustripexpand` ([#162](https://github.com/JuliaPhysics/DynamicQuantities.jl/issues/162)) ([bb8b379](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/bb8b379b8e9beccd10d92c3555ee4ee256a05ba9))

## [1.4.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.3.0...v1.4.0) (2024-11-21)


### Features

* add explicit handling of ranges ([9ed7911](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/9ed79114ed891becdd75375b3a8cf37304306f96))
* add explicit handling of ranges ([a2d73a3](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/a2d73a35f1a280b41551bcf90ce19e549e3bef92))
* always default to range ([230f931](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/230f931d1456c2fa991774ee31b9006358cbe396))


### Bug Fixes

* applying units to range ([b981064](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/b981064bbfa9e8418a05a86d850b5675717ed4b0)), closes [#157](https://github.com/JuliaPhysics/DynamicQuantities.jl/issues/157)
* backwards compatible dimensionless ranges ([8d7b2c5](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/8d7b2c517945f83490018d39baef4ea72e03c753))
* skip type test of unit range ([4d16a6f](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/4d16a6f983b8bc99b3f8ce7482c810463967335d))
* skip UnitRange definition ([119b7b7](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/119b7b7490c57d890a2ce2f7278dad691fab4700))

## [1.3.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.2.0...v1.3.0) (2024-11-09)


### Features

* add Torr and mmHg ([#154](https://github.com/JuliaPhysics/DynamicQuantities.jl/issues/154)) ([a412ab1](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/a412ab18b1c185585ea4bf7ab5a0bef28025295a))

## [1.2.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.1.0...v1.2.0) (2024-11-01)


### Features

* add additional Newton prefixes ([74c75bd](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/74c75bd44af39d157dd4f146bb95b60b3c31b8eb))

## [1.1.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v1.0.0...v1.1.0) (2024-09-23)

## [1.0.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.14.3...v1.0.0) (2024-08-26)

## [0.14.3](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.14.2...v0.14.3) (2024-06-10)


### Bug Fixes

* convert to unitful for dimensionless ([2350068](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/23500689ae321e5c6d9be485f85ee12b10e5f13d))

## [0.14.2](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.14.1...v0.14.2) (2024-06-10)

## [0.14.1](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.14.0...v0.14.1) (2024-06-07)


### Bug Fixes

* reflection by using `dimension_names` ([b1ae402](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/b1ae402e89a8315752ffac9da1fffd2325f76d71))

## [0.14.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.13.2...v0.14.0) (2024-05-10)


### ⚠ BREAKING CHANGES

* add `ustrip` for all AbstractArray's

### Features

* add missing isapprox for (Array, QuantityArray) ([8e67510](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/8e67510d385537c754e452c7da037210ca39ea8c))
* export FixedRational ([#132](https://github.com/JuliaPhysics/DynamicQuantities.jl/issues/132)) ([9ea8610](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/9ea861056acc77a49cc9b8c6fa93cfa933a12374))


### Bug Fixes

* add adjoint for dimensions ([33897fb](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/33897fb97d02466118d8314648f8a91da581f9d0))
* add `ustrip` for all AbstractArray's ([a7acc5a](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/a7acc5a341e7cab68794c39a66862ea303b5a60f))
* ambiguous linear algebra operations ([77f80dc](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/77f80dc62a5b4718952ce799c9c84c1126fa2b63))
* isapprox for regular arrays ([49ad304](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/49ad304136dc878bd049799ecf9f41531409f0d7))


### Reverts

* disable `eigen` until better testing ([b5c29cd](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/b5c29cd8fa7a2cef39717e6db431b3da0cf5b57d))

## [0.13.2](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.13.1...v0.13.2) (2024-03-31)

## [0.13.1](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.13.0...v0.13.1) (2024-03-20)

## [0.13.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.12.3...v0.13.0) (2024-03-11)

## [0.12.3](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.12.2...v0.12.3) (2024-03-05)

## [0.12.2](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.12.1...v0.12.2) (2024-03-04)

## [0.12.1](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.12.0...v0.12.1) (2024-02-13)


### Features

* add `Wb` (webers) ([91931e3](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/91931e37c3e7f248965155b95199f8894db62a51))
* add `H` (henry) ([f54ee93](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/f54ee93fbdc2f6a6297667f13d488ba7f092df4e))
* add `S` (siemens) ([7c39fee](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/7c39feeb6fa2c9ca00258162a89889dbf767ed95))

## [0.12.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.11.3...v0.12.0) (2024-02-12)


### Features

* add `WriteOnceReadMany` and utils ([5c00b03](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/5c00b031ee32ae1820d094404a7277ac13a0b9b0))
* allow registering units externally ([04d2b14](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/04d2b14a9bf4b290dbfb076334e8c1e56a93b700))


### Bug Fixes

* import of vars into SymbolicUnits sybmodule ([2c869e3](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/2c869e303ac46e5db6692ab198b8a39f507e564d))

## [0.11.3](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.11.2...v0.11.3) (2024-01-19)

## [0.11.2](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.11.1...v0.11.2) (2024-01-12)

## [0.11.1](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.11.0...v0.11.1) (2024-01-10)

## [0.11.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.10.3...v0.11.0) (2024-01-10)

## [0.10.3](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.10.2...v0.10.3) (2023-12-03)


### Features

* add unit `mbar` ([068a95c](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/068a95ccec60083659e6b54de9557295fbaa46df))
* add unit `cL` ([df86e36](https://github.com/JuliaPhysics/DynamicQuantities.jl/commit/df86e36ac4c17a73f14c6f518f1ef944a98c93b7))

## [0.10.2](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.10.1...v0.10.2) (2023-12-02)

## [0.10.1](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.10.0...v0.10.1) (2023-12-02)

## [0.10.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.9.0...v0.10.0) (2023-11-23)

## [0.9.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.8.2...v0.9.0) (2023-11-12)

## [0.8.2](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.8.1...v0.8.2) (2023-11-09)

## [0.8.1](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.8.0...v0.8.1) (2023-11-08)

## [0.8.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.7.5...v0.8.0) (2023-11-02)

## [0.7.5](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.7.4...v0.7.5) (2023-10-22)

## [0.7.4](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.7.3...v0.7.4) (2023-10-15)

## [0.7.3](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.7.2...v0.7.3) (2023-10-12)

## [0.7.2](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.7.1...v0.7.2) (2023-10-10)

## [0.7.1](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.7.0...v0.7.1) (2023-10-01)

## [0.7.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.6.3...v0.7.0) (2023-09-09)

## [0.6.3](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.6.2...v0.6.3) (2023-08-07)

## [0.6.2](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.6.1...v0.6.2) (2023-07-11)

## [0.6.1](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.6.0...v0.6.1) (2023-07-10)

## [0.6.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.5.0...v0.6.0) (2023-07-09)

## [0.5.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.4.0...v0.5.0) (2023-06-28)

## [0.4.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.3.0...v0.4.0) (2023-06-14)

## [0.3.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.2.0...v0.3.0) (2023-06-10)

## [0.2.0](https://github.com/JuliaPhysics/DynamicQuantities.jl/compare/v0.1.0...v0.2.0) (2023-06-09)

## 0.1.0 (2023-06-09)
