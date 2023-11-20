for (type, base_type, _) in ABSTRACT_QUANTITY_TYPES
    @eval begin
        function Base.:*(l::$type, r::$type)
            l, r = promote_except_value(l, r)
            new_quantity(typeof(l), ustrip(l) * ustrip(r), dimension(l) * dimension(r))
        end
        function Base.:/(l::$type, r::$type)
            l, r = promote_except_value(l, r)
            new_quantity(typeof(l), ustrip(l) / ustrip(r), dimension(l) / dimension(r))
        end
        function Base.div(x::$type, y::$type, r::RoundingMode=RoundToZero)
            x, y = promote_except_value(x, y)
            new_quantity(typeof(x), div(ustrip(x), ustrip(y), r), dimension(x) / dimension(y))
        end

        # The rest of the functions are unchanged because they do not operate on two variables of the custom type
        function Base.:*(l::$type, r::$base_type)
            new_quantity(typeof(l), ustrip(l) * r, dimension(l))
        end
        function Base.:/(l::$type, r::$base_type)
            new_quantity(typeof(l), ustrip(l) / r, dimension(l))
        end
        function Base.div(x::$type, y::Number, r::RoundingMode=RoundToZero)
            new_quantity(typeof(x), div(ustrip(x), y, r), dimension(x))
        end

        function Base.:*(l::$base_type, r::$type)
            new_quantity(typeof(r), l * ustrip(r), dimension(r))
        end
        function Base.:/(l::$base_type, r::$type)
            new_quantity(typeof(r), l / ustrip(r), inv(dimension(r)))
        end
        function Base.div(x::Number, y::$type, r::RoundingMode=RoundToZero)
            new_quantity(typeof(y), div(x, ustrip(y), r), inv(dimension(y)))
        end

        function Base.:*(l::$type, r::AbstractDimensions)
            new_quantity(typeof(l), ustrip(l), dimension(l) * r)
        end
        function Base.:/(l::$type, r::AbstractDimensions)
            new_quantity(typeof(l), ustrip(l), dimension(l) / r)
        end

        function Base.:*(l::AbstractDimensions, r::$type)
            new_quantity(typeof(r), ustrip(r), l * dimension(r))
        end
        function Base.:/(l::AbstractDimensions, r::$type)
            new_quantity(typeof(r), inv(ustrip(r)), l / dimension(r))
        end
    end
end

Base.:*(l::AbstractDimensions, r::AbstractDimensions) = map_dimensions(+, l, r)
Base.:/(l::AbstractDimensions, r::AbstractDimensions) = map_dimensions(-, l, r)

# Defines + and -
for (type, base_type, _) in ABSTRACT_QUANTITY_TYPES, op in (:+, :-)
    @eval begin
        function Base.$op(l::$type, r::$type)
            l, r = promote_except_value(l, r)
            dimension(l) == dimension(r) || throw(DimensionError(l, r))
            return new_quantity(typeof(l), $op(ustrip(l), ustrip(r)), dimension(l))
        end
        function Base.$op(l::$type, r::$base_type)
            dimension(l) == dimension(NoDims()) || throw(DimensionError(l, r))
            return new_quantity(typeof(l), $op(ustrip(l), r), dimension(l))
        end
        function Base.$op(l::$base_type, r::$type)
            dimension(r) == dimension(NoDims()) || throw(DimensionError(l, r))
            return new_quantity(typeof(r), $op(l, ustrip(r)), dimension(r))
        end
    end
end

Base.:-(l::UnionAbstractQuantity) = new_quantity(typeof(l), -ustrip(l), dimension(l))

# Combining different abstract types
for op in (:*, :/, :+, :-, :div, :atan, :atand, :copysign, :flipsign, :mod),
    (t1, _, _) in ABSTRACT_QUANTITY_TYPES,
    (t2, _, _) in ABSTRACT_QUANTITY_TYPES

    t1 == t2 && continue

    @eval Base.$op(l::$t1, r::$t2) = $op(promote_except_value(l, r)...)
end

# We don't promote on the dimension types:
function Base.:^(l::AbstractDimensions{R}, r::Integer) where {R}
    return map_dimensions(Base.Fix1(*, r), l)
end
function Base.:^(l::AbstractDimensions{R}, r::Number) where {R}
    return map_dimensions(Base.Fix1(*, tryrationalize(R, r)), l)
end
# Special forms for small integer powers (will unroll dimension multiplication into repeated additions)
# https://github.com/JuliaLang/julia/blob/b99f251e86c7c09b957a1b362b6408dbba106ff0/base/intfuncs.jl#L332
for (p, ex) in [
    (0, :(one(l))),
    (1, :(l)),
    (2, :(l * l)),
    (3, :(l * l * l)),
    (-1, :(inv(l))),
    (-2, :((i=inv(l); i*i)))
]
    @eval @inline Base.literal_pow(::typeof(^), l::AbstractDimensions, ::Val{$p}) = $ex
end

function _pow_int(l::UnionAbstractQuantity{T,D}, r) where {T,R,D<:AbstractDimensions{R}}
    return new_quantity(typeof(l), ustrip(l)^r, dimension(l)^r)
end
function _pow(l::UnionAbstractQuantity{T,D}, r) where {T,R,D<:AbstractDimensions{R}}
    dim_pow = tryrationalize(R, r)
    val_pow = convert(T, dim_pow)
    # Need to ensure we take the numerical power by the rationalized quantity:
    return new_quantity(typeof(l), ustrip(l)^val_pow, dimension(l)^dim_pow)
end
for (type, _, _) in ABSTRACT_QUANTITY_TYPES
    @eval begin
        Base.:^(l::$type, r::Integer) = _pow_int(l, r)
        Base.:^(l::$type, r::Number) = _pow(l, r)
        Base.:^(l::$type, r::Rational) = _pow(l, r)
    end
end
@inline Base.literal_pow(::typeof(^), l::AbstractDimensions, ::Val{p}) where {p} = map_dimensions(Base.Fix1(*, p), l)
@inline Base.literal_pow(::typeof(^), l::UnionAbstractQuantity, ::Val{p}) where {p} = new_quantity(typeof(l), Base.literal_pow(^, ustrip(l), Val(p)), Base.literal_pow(^, dimension(l), Val(p)))

Base.inv(d::AbstractDimensions) = map_dimensions(-, d)
Base.inv(q::UnionAbstractQuantity) = new_quantity(typeof(q), inv(ustrip(q)), inv(dimension(q)))

Base.sqrt(d::AbstractDimensions{R}) where {R} = d^inv(convert(R, 2))
Base.sqrt(q::UnionAbstractQuantity) = new_quantity(typeof(q), sqrt(ustrip(q)), sqrt(dimension(q)))
Base.cbrt(d::AbstractDimensions{R}) where {R} = d^inv(convert(R, 3))
Base.cbrt(q::UnionAbstractQuantity) = new_quantity(typeof(q), cbrt(ustrip(q)), cbrt(dimension(q)))

Base.abs2(q::UnionAbstractQuantity) = new_quantity(typeof(q), abs2(ustrip(q)), dimension(q)^2)
Base.angle(q::UnionAbstractQuantity{T}) where {T<:Complex} = angle(ustrip(q))

############################## Require dimensionless input ##############################
# Note that :clamp, :cmp, :sign already work
# We skip :rad2deg, :deg2rad in case the user defines a rad or deg unit
for f in (
    :sin, :cos, :tan, :sinh, :cosh, :tanh, :asin, :acos,
    :asinh, :acosh, :atanh, :sec, :csc, :cot, :asec, :acsc, :acot, :sech, :csch,
    :coth, :asech, :acsch, :acoth, :sinc, :cosc, :cosd, :cotd, :cscd, :secd,
    :sinpi, :cospi, :sind, :tand, :acosd, :acotd, :acscd, :asecd, :asind,
    :log, :log2, :log10, :log1p, :exp, :exp2, :exp10, :expm1, :frexp, :exponent,
)
    @eval function Base.$f(q::UnionAbstractQuantity)
        dimension(q) == dimension(NoDims()) || throw(DimensionError(q))
        return $f(ustrip(q))
    end
end
for (type, base_type, _) in ABSTRACT_QUANTITY_TYPES, f in (:atan, :atand)
    @eval begin
        function Base.$f(x::$type)
            iszero(dimension(x)) || throw(DimensionError(x))
            return $f(ustrip(x))
        end
        function Base.$f(y::$type, x::$type)
            y, x = promote_except_value(y, x)
            dimension(y) == dimension(x) || throw(DimensionError(y, x))
            return $f(ustrip(y), ustrip(x))
        end
        function Base.$f(y::$type, x::$base_type)
            iszero(dimension(y)) || throw(DimensionError(y))
            return $f(ustrip(y), x)
        end
        function Base.$f(y::$base_type, x::$type)
            iszero(dimension(x)) || throw(DimensionError(x))
            return $f(y, ustrip(x))
        end
    end
end
#########################################################################################

############################## Same dimension as input ##################################
for f in (
    :float, :abs, :real, :imag, :conj, :adjoint, :unsigned,
    :nextfloat, :prevfloat, :identity, :transpose, :significand
)
    @eval function Base.$f(q::UnionAbstractQuantity)
        return new_quantity(typeof(q), $f(ustrip(q)), dimension(q))
    end
end
for (type, base_type, _) in ABSTRACT_QUANTITY_TYPES, f in (:copysign, :flipsign, :mod)
    # These treat the x as the magnitude, so we take the dimensions from there,
    # and ignore any dimensions on y, since those will cancel out.
    @eval begin
        function Base.$f(x::$type, y::$type)
            x, y = promote_except_value(x, y)
            return new_quantity(typeof(x), $f(ustrip(x), ustrip(y)), dimension(x))
        end
        function Base.$f(x::$type, y::$base_type)
            return new_quantity(typeof(x), $f(ustrip(x), y), dimension(x))
        end
        function Base.$f(x::$base_type, y::$type)
            return $f(x, ustrip(y))
        end
    end
end
function Base.ldexp(x::UnionAbstractQuantity, n::Integer)
    return new_quantity(typeof(x), ldexp(ustrip(x), n), dimension(x))
end
function Base.round(q::UnionAbstractQuantity, r::RoundingMode=RoundNearest)
    return new_quantity(typeof(q), round(ustrip(q), r), dimension(q))
end
function Base.round(::Type{Ti}, q::UnionAbstractQuantity, r::RoundingMode=RoundNearest) where {Ti<:Integer}
    return new_quantity(typeof(q), round(Ti, ustrip(q), r), dimension(q))
end
for f in (:floor, :trunc, :ceil)
    @eval begin
        function Base.$f(q::UnionAbstractQuantity)
            return new_quantity(typeof(q), $f(ustrip(q)), dimension(q))
        end
        function Base.$f(::Type{Ti}, q::UnionAbstractQuantity) where {Ti<:Integer}
            return new_quantity(typeof(q), $f(Ti, ustrip(q)), dimension(q))
        end
    end
end
function Base.modf(q::UnionAbstractQuantity)
    output = modf(ustrip(q))
    return ntuple(i -> new_quantity(typeof(q), output[i], dimension(q)), Val(2))
end
#########################################################################################
