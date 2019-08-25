//
//  Functions.swift
//  
//
//  Created by Christian Treffs on 25.08.19.
//

#if canImport(simd)
// types
import struct simd.simd_double2
import struct simd.simd_float2
import struct simd.simd_double3
import struct simd.simd_float3
import struct simd.simd_double4
import struct simd.simd_float4

// functions
import func simd.rsqrt
import func simd.sign
import func simd.simd_clamp
import func simd.simd_dot
import func simd.simd_fract
import func simd.simd_length
import func simd.simd_mix
import func simd.simd_normalize
import func simd.simd_smoothstep
import func simd.sqrt
import func simd.step
#endif

// MARK: - clamp
/// x clamped to the range [min, max].
/// Note that if you want to clamp all lanes to the same range, you can use a scalar value for min and max.
/// - Parameters:
///   - x: value to be clamped
///   - min: min range bound
///   - max: max range bound
/// - Returns: x clamped to the range [min, max]
public func clamp<Scalar>(_ x: Scalar, _ min: Scalar, _ max: Scalar) -> Scalar where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        let x: Double = unsafeBitCast(x, to: Double.self)
        let min: Double = unsafeBitCast(min, to: Double.self)
        let max: Double = unsafeBitCast(max, to: Double.self)
        return unsafeBitCast(simd.simd_clamp(x, min, max), to: Scalar.self)

    case is Float.Type:
        let x: Float = unsafeBitCast(x, to: Float.self)
        let min: Float = unsafeBitCast(min, to: Float.self)
        let max: Float = unsafeBitCast(max, to: Float.self)
        return unsafeBitCast(simd.simd_clamp(x, min, max), to: Scalar.self)

    default:
        break
    }
    #endif
    fatalError()
}

// MARK: - fraction

/// The "fractional part" of x, lying in the range [0, 1).
/// floor(x) + fract(x) is *approximately* equal to x.
/// If x is positive and finite, then the two values are exactly equal.
///
/// - Parameters:
///     - v: floating point value
/// - Returns: The "fractional part" of x
public func fract<Scalar>(_ v: Scalar) -> Scalar {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        return unsafeBitCast(simd.simd_fract(unsafeBitCast(v, to: Double.self)), to: Scalar.self)

    case is Float.Type:
        return unsafeBitCast(simd.simd_fract(unsafeBitCast(v, to: Float.self)), to: Scalar.self)

    default:
        break
    }
    #endif

    fatalError()
}

// MARK: - mix
/// Linearly interpolates between x and y, taking the value x when t=0 and y when t=1
public func mix<Scalar>(interpolate x: Scalar, y: Scalar, t: Scalar) -> Scalar where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        let x = unsafeBitCast(x, to: Double.self)
        let y = unsafeBitCast(y, to: Double.self)
        let t = unsafeBitCast(t, to: Double.self)
        return unsafeBitCast(simd.simd_mix(x, y, t), to: Scalar.self)

    case is Float.Type:
        let x = unsafeBitCast(x, to: Float.self)
        let y = unsafeBitCast(y, to: Float.self)
        let t = unsafeBitCast(t, to: Float.self)
        return unsafeBitCast(simd.simd_mix(x, y, t), to: Scalar.self)

    default:
        break
    }
    #endif

    fatalError()
}

// MARK: - normalize
@inlinable public func normalize<Scalar>(_ x: SIMD2<Scalar>) -> SIMD2<Scalar> where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        return unsafeBitCast(simd_normalize(unsafeBitCast(x, to: simd_double2.self)), to: SIMD2<Scalar>.self)

    case is Float.Type:
        return unsafeBitCast(simd_normalize(unsafeBitCast(x, to: simd_float2.self)), to: SIMD2<Scalar>.self)

    default:
        break
    }
    #endif

    fatalError()
}

@inlinable public func normalize<Scalar>(_ x: SIMD3<Scalar>) -> SIMD3<Scalar> where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        return unsafeBitCast(simd_normalize(unsafeBitCast(x, to: simd_double3.self)), to: SIMD3<Scalar>.self)

    case is Float.Type:
        return unsafeBitCast(simd_normalize(unsafeBitCast(x, to: simd_float3.self)), to: SIMD3<Scalar>.self)

    default:
        break
    }
    #endif

    fatalError()
}

@inlinable public func normalize<Scalar>(_ x: SIMD4<Scalar>) -> SIMD4<Scalar> where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        return unsafeBitCast(simd_normalize(unsafeBitCast(x, to: simd_double4.self)), to: SIMD4<Scalar>.self)

    case is Float.Type:
        return unsafeBitCast(simd_normalize(unsafeBitCast(x, to: simd_float4.self)), to: SIMD4<Scalar>.self)

    default:
        break
    }
    #endif

    fatalError()
}

// MARK: - length

/// Computes the length of the argument.
/// For scalar components `length(x)` is equivalent to `abs(x)`.
/// - Parameter float: a float argument
/// - Returns: the distance between the argument and the origin.
@inlinable public func length<Scalar>(_ x: SIMD2<Scalar>) -> Scalar where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        return unsafeBitCast(simd_length(unsafeBitCast(x, to: simd_double2.self)), to: Scalar.self)

    case is Float.Type:
        return unsafeBitCast(simd_length(unsafeBitCast(x, to: simd_float2.self)), to: Scalar.self)

    default:
        break
    }
    #endif

    let value: Scalar = dot(x, x)
    fatalError()
}

@inlinable public func length<Scalar>(_ x: SIMD3<Scalar>) -> Scalar where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        return unsafeBitCast(simd_length(unsafeBitCast(x, to: simd_double3.self)), to: Scalar.self)

    case is Float.Type:
        return unsafeBitCast(simd_length(unsafeBitCast(x, to: simd_float3.self)), to: Scalar.self)

    default:
        break
    }
    #endif
    fatalError()
}

@inlinable public func length<Scalar>(_ x: SIMD4<Scalar>) -> Scalar where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        return unsafeBitCast(simd_length(unsafeBitCast(x, to: simd_double4.self)), to: Scalar.self)

    case is Float.Type:
        return unsafeBitCast(simd_length(unsafeBitCast(x, to: simd_float4.self)), to: Scalar.self)

    default:
        break
    }
    #endif
    fatalError()
}

// MARK: - dot
/// Computes the dot product of the arguments.
/// For scalar components `dot(x, y)` is equivalent to `x*y`.
/// - Parameters:
///   - x: a float argument.
///   - y: a float argument.
/// - Returns: the dot product of the arguments.
@inlinable public func dot<Scalar>(_ x: SIMD2<Scalar>, _ y: SIMD2<Scalar>) -> Scalar where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        return unsafeBitCast(simd_dot(unsafeBitCast(x, to: simd_double2.self),
                                      unsafeBitCast(y, to: simd_double2.self)),
                             to: Scalar.self)

    case is Float.Type:
        return unsafeBitCast(simd_dot(unsafeBitCast(x, to: simd_float2.self),
                                      unsafeBitCast(y, to: simd_float2.self)),
                             to: Scalar.self)

    default:
        break
    }
    #endif
    let xx = x
    let yy = y
    return xx.x * yy.x + xx.y * yy.y
}

@inlinable public func dot<Scalar>(_ x: SIMD3<Scalar>, _ y: SIMD3<Scalar>) -> Scalar where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        return unsafeBitCast(simd_dot(unsafeBitCast(x, to: simd_double3.self),
                                      unsafeBitCast(y, to: simd_double3.self)),
                             to: Scalar.self)

    case is Float.Type:
        return unsafeBitCast(simd_dot(unsafeBitCast(x, to: simd_float3.self),
                                      unsafeBitCast(y, to: simd_float3.self)),
                             to: Scalar.self)

    default:
        break
    }
    #endif
    let xx = x
    let yy = y
    let z = xx.x * yy.x + xx.y * yy.y
    return z + xx.z * yy.z
}

@inlinable public func dot<Scalar>(_ x: SIMD4<Scalar>, _ y: SIMD4<Scalar>) -> Scalar where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        return unsafeBitCast(simd.simd_dot(unsafeBitCast(x, to: simd_double4.self),
                                           unsafeBitCast(y, to: simd_double4.self)),
                             to: Scalar.self)

    case is Float.Type:
        return unsafeBitCast(simd.simd_dot(unsafeBitCast(x, to: simd_float4.self),
                                           unsafeBitCast(y, to: simd_float4.self)),
                             to: Scalar.self)

    default:
        break
    }
    #endif
    let xx = x
    let yy = y
    let z = xx.x * yy.x + xx.y * yy.y
    return z + xx.z * yy.z + xx.w * yy.w
}

// MARK: - sign

/// Returns -1 if `x < 0`, +1 if `x > 0`, and 0 otherwise (`sign(NaN)` is 0).
public func sign<Scalar>(_ x: Scalar) -> Scalar where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        return unsafeBitCast(simd.sign(unsafeBitCast(x, to: Double.self)),
                             to: Scalar.self)

    case is Float.Type:
        return unsafeBitCast(simd.sign(unsafeBitCast(x, to: Float.self)),
                             to: Scalar.self)

    default:
        break
    }
    #endif

    fatalError()
}

// MARK: - smoothstep

/// Interpolates smoothly between 0 at edge0 and 1 at edge1
/// You can use a scalar value for edge0 and edge1 if you want to clamp all lanes at the same points.
public func smoothstep<Scalar>(interpolate edge0: Scalar, edge1: Scalar, x: Scalar) -> Scalar where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        let edge0 = unsafeBitCast(edge0, to: Double.self)
        let edge1 = unsafeBitCast(edge1, to: Double.self)
        let x = unsafeBitCast(x, to: Double.self)
        return unsafeBitCast(simd.simd_smoothstep(edge0, edge1, x), to: Scalar.self)

    case is Float.Type:
        let edge0 = unsafeBitCast(edge0, to: Float.self)
        let edge1 = unsafeBitCast(edge1, to: Float.self)
        let x = unsafeBitCast(x, to: Float.self)
        return unsafeBitCast(simd.simd_smoothstep(edge0, edge1, x), to: Scalar.self)

    default:
        break
    }
    #endif

    fatalError()
}

// MARK: - rsqrt

/// Reciprocal square root.
///
/// - Parameter float: floating point value
/// - Returns: 1 / sqrt(arg)
public func rsqrt<Scalar>(_ x: Scalar) -> Scalar where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        return unsafeBitCast(simd.rsqrt(unsafeBitCast(x, to: Double.self)),
                             to: Scalar.self)

    case is Float.Type:
        return unsafeBitCast(simd.rsqrt(unsafeBitCast(x, to: Float.self)),
                             to: Scalar.self)

    default:
        break
    }
    #endif

    fatalError()
}

// MARK: - step

/// Returns 0.0 if x < edge, and 1.0 otherwise.
public func step<Scalar>(_ x: Scalar, edge: Scalar) -> Scalar where Scalar: SIMDScalar & Numeric {
    #if canImport(simd)
    switch Scalar.self {
    case is Double.Type:
        return unsafeBitCast(simd.step(unsafeBitCast(x, to: Double.self),
                                       edge: unsafeBitCast(edge, to: Double.self)),
                             to: Scalar.self)

    case is Float.Type:
        return unsafeBitCast(simd.step(unsafeBitCast(x, to: Float.self),
                                       edge: unsafeBitCast(edge, to: Float.self)),
                             to: Scalar.self)

    default:
        break
    }
    #endif

    fatalError()
}
