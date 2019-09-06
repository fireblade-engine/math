//
//  length.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)
import func simd.simd_length
import struct simd.simd_quatf
import struct simd.simd_quatd
#endif

/// Computes the length of the argument.
/// For scalar components `length(x)` is equivalent to `abs(x)`.
/// - Parameter float: a float argument
/// - Returns: the distance between the argument and the origin.
@inlinable public func length(_ x: SIMD2<Double>) -> Double {
    #if USE_SIMD
    return simd_length(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

/// Computes the length of the argument.
/// For scalar components `length(x)` is equivalent to `abs(x)`.
/// - Parameter float: a float argument
/// - Returns: the distance between the argument and the origin.
@inlinable public func length(_ x: SIMD2<Float>) -> Float {
    #if USE_SIMD
    return simd_length(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

/// Computes the length of the argument.
/// For scalar components `length(x)` is equivalent to `abs(x)`.
/// - Parameter float: a float argument
/// - Returns: the distance between the argument and the origin.
@inlinable public func length(_ x: SIMD3<Double>) -> Double {
    #if USE_SIMD
    return simd_length(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

/// Computes the length of the argument.
/// For scalar components `length(x)` is equivalent to `abs(x)`.
/// - Parameter float: a float argument
/// - Returns: the distance between the argument and the origin.
@inlinable public func length(_ x: SIMD3<Float>) -> Float {
    #if USE_SIMD
    return simd_length(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

/// Computes the length of the argument.
/// For scalar components `length(x)` is equivalent to `abs(x)`.
/// - Parameter float: a float argument
/// - Returns: the distance between the argument and the origin.
@inlinable public func length(_ x: SIMD4<Double>) -> Double {
    #if USE_SIMD
    return simd_length(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

/// Computes the length of the argument.
/// For scalar components `length(x)` is equivalent to `abs(x)`.
/// - Parameter float: a float argument
/// - Returns: the distance between the argument and the origin.
@inlinable public func length(_ x: SIMD4<Float>) -> Float {
    #if USE_SIMD
    return simd_length(x)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

/// Computes the length of the argument.
/// For scalar components `length(x)` is equivalent to `abs(x)`.
/// - Parameter float: a float argument
/// - Returns: the distance between the argument and the origin.
@inlinable public func length(_ x: Quat4f) -> Float {
    #if USE_SIMD
    return simd_length(x.storage)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}

/// Computes the length of the argument.
/// For scalar components `length(x)` is equivalent to `abs(x)`.
/// - Parameter float: a float argument
/// - Returns: the distance between the argument and the origin.
@inlinable public func length(_ x: Quat4d) -> Double {
    #if USE_SIMD
    return simd_length(x.storage)
    #else
    fatalError("implementation missing \(#function) \(#file):\(#line)")
    #endif
}
