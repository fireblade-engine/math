//
//  copysign.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//
#if canImport(Darwin)
import Darwin.C.math
#elseif canImport(Glibc)
import Glibc
#else
#error("unsupported platform")
#endif

/// Composes a floating point value with the magnitude of x and the sign of y.
///
/// - Parameters:
///   - x:     floating point value
///   - y:     floating point value
/// - Returns: If no errors occur, the floating point value with the magnitude of x and the sign of y is returned.
///            If x is NaN, then NaN with the sign of y is returned.
///            If y is -0, the result is only negative if the implementation supports the signed zero consistently in
///            arithmetic operations.
public func copysign(_ x: Double, _ y: Double) -> Double {
    #if canImport(Darwin)
    return Darwin.copysign(x, y)
    #elseif canImport(Glibc)
    return Glibc.copysign(x, y)
    #endif
}

/// Composes a floating point value with the magnitude of x and the sign of y.
///
/// - Parameters:
///   - x:     floating point value
///   - y:     floating point value
/// - Returns: If no errors occur, the floating point value with the magnitude of x and the sign of y is returned.
///            If x is NaN, then NaN with the sign of y is returned.
///            If y is -0, the result is only negative if the implementation supports the signed zero consistently in
///            arithmetic operations.
public func copysign(_ x: Float, _ y: Float) -> Float {
    #if canImport(Darwin)
    return Darwin.copysignf(x, y)
    #elseif canImport(Glibc)
    return Glibc.copysignf(x, y)
    #endif
}
