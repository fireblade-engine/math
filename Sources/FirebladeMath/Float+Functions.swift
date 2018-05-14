//
//  Float+Functions.swift
//  FirebladeEngine
//
//  Created by Christian Treffs on 03.10.17.
//
import simd

/// Computes the absolute value of a floating point value arg.
///
/// - Parameter float: 	floating point value
/// - Returns: If successful, returns the absolute value of arg (|arg|). The value returned is exact and does not depend on any rounding modes.
public func abs(_ float: Float32) -> Float32 { return simd.fabsf(float) }

/// Computes the principal value of the arc cosine of arg.
///
/// - Parameter float: floating point value
/// - Returns: If no errors occur, the arc cosine of arg (arccos(arg)) in the range [0 ; π], is returned.
///			   If a domain error occurs, an implementation-defined value is returned (NaN where supported).
///				If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func acos(_ float: Float32) -> Float32 { return simd.acosf(float) }

///  Computes the inverse hyperbolic cosine of arg.
///
/// - Parameter float: 	floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic cosine of arg (cosh-1
///	(arg), or arcosh(arg)) on the interval [0, +∞], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
public func acosh(_ float: Float32) -> Float32 { return simd.acoshf(float) }

/// Computes the principal values of the arc sine of arg.
///
/// - Parameter float: 	floating point value
/// - Returns: If no errors occur, the arc sine of arg (arcsin(arg)) in the range [-π/2;+π/2], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asin(_ float: Float32) -> Float32 { return simd.asinf(float) }

/// Computes the inverse hyperbolic sine of arg.
///
/// - Parameter float: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic sine of arg (sinh^-1(arg), or arsinh(arg)), is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func asinh(_ float: Float32) -> Float32 { return simd.asinhf(float) }

/// Computes the principal value of the arc tangent of arg.
///
/// - Parameter float: floating point value
/// - Returns: If no errors occur, the arc tangent of arg (arctan(arg)) in the range [-π/2;+π/2] radians, is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func atan(_ float: Float32) -> Float32 { return simd.atanf(float) }

/// Computes the inverse hyperbolic tangent of arg.
///
/// - Parameter float: floating point value representing the area of a hyperbolic sector
/// - Returns: If no errors occur, the inverse hyperbolic tangent of arg (tanh^-1(arg), or artanh(arg)), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned (with the correct sign).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func atanh(_ float: Float32) -> Float32 { return simd.atanhf(float) }

/// Computes the smallest integer value not less than arg.
///
/// - Parameter float: 	floating point value
/// - Returns: If no errors occur, the smallest integer value not less than arg, that is ⌈arg⌉, is returned.
public func ceil(_ float: Float32) -> Float32 { return simd.ceilf(float) }

/// x clamped to the range [min, max].
/// Note that if you want to clamp all lanes to the same range, you can use a scalar value for min and max.
/// - Parameters:
///   - x: value to be clamped
///   - min: min range bound
///   - max: max range bound
/// - Returns: x clamped to the range [min, max]
public func clamp(_ x: Float32, _ min: Float32, _ max: Float32) -> Float32 { return simd.simd_clamp(x, min, max) }

/// Computes the cosine of arg (measured in radians).
///
/// - Parameter float: floating point value representing angle in radians
/// - Returns: If no errors occur, the cosine of arg (cos(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func cos(_ floatAngleRadians: Float32) -> Float32 { return simd.cosf(floatAngleRadians) }

/// Computes the hyperbolic cosine of arg.
///
/// - Parameter float: floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic cosine of arg (cosh(arg), or (e^arg+e^-arg)/2) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
public func cosh(_ float: Float32) -> Float32 { return simd.coshf(float) }

/// Converts radians to degrees.
///
/// - Parameter radians: an angle in radians.
/// - Returns:  the argument converted to degrees.
public func degrees(_ radians: Float32) -> Float32 { return radians * kRadiansToDegree32 }

/// Computes the distance between the arguments.
///
/// - Parameters:
///   - x: a float argument.
///   - y: a float argument.
/// - Returns: the distance between the arguments.
public func distance(_ x: Float32, _ y: Float32) -> Float32 { return abs(x - y) }

/// Computes the dot product of the arguments.
/// For scalar components `dot(x, y)` is equivalent to `x*y`.
/// - Parameters:
///   - x: a float argument.
///   - y: a float argument.
/// - Returns: the dot product of the arguments.
public func dot(_ x: Float32, _ y: Float32) -> Float32 { return x * y }

///  Computes the e (Euler's number, 2.7182818) raised to the given power arg.
///
/// - Parameter float: floating point value
/// - Returns: If no errors occur, the base-e exponential of arg (e^arg) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func exp(_ power: Float32) -> Float32 { return simd.expf(power) }

/// Computes 2 raised to the given power n.
///
/// - Parameter float: 	floating point value
/// - Returns: If no errors occur, the base-2 exponential of n (2^n) is returned.
/// If a range error due to overflow occurs, +HUGE_VAL, +HUGE_VALF, or +HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func exp2(_ power: Float32) -> Float32 { return simd.exp2f(power) }

/// Flips the normal vector ''n'' to face the direction opposite to the incident vector ''i''
///
/// - Parameters:
///   - n: the normal
///   - i: the incident vector
///   - nref: the reference normal
/// - Returns: one of the following:
///  ''n'' if dot(''i'', ''nref'') < 0.
///  ''-n'' otherwise.
public func faceforward(n: Float32, i: Float32, nref: Float32) -> Float32 {
	let dot: Float32 = i * nref
	if dot < 0.0 {
		return n
	} else if isNaN(dot) {
		return Float32.nan
	} else {
		return -n
	}
}

/// Computes the largest integer value not greater than arg.
///
/// - Parameter float: floating point value
/// - Returns: If no errors occur, the largest integer value not greater than arg, that is ⌊arg⌋, is returned.
public func floor(_ float: Float32) -> Float32 { return simd.floorf(float) }

/// The "fractional part" of x, lying in the range [0, 1).
/// floor(x) + fract(x) is *approximately* equal to x.
/// If x is positive and finite, then the two values are exactly equal.
///
/// - Parameter float: floating point value
/// - Returns: The "fractional part" of x
public func fract(_ float: Float32) -> Float32 { return simd.simd_fract(float) }

/// Returns true if Float32.infinity == arg.
///
/// - Parameter float: floating point value
/// - Returns: true if Float32.infinity == arg, false otherwise
public func isInfinite(_ float: Float32) -> Bool { return Float32.infinity == float }

/// Checks if arg is Not a Number (NaN).
///
/// - Parameter float: floating point value
/// - Returns: true/false
public func isNaN(_ float: Float32) -> Bool { return Float32.nan == float }

public func isNegativeInfinity(_ float: Float32) -> Bool { return float.floatingPointClass == .negativeInfinity }
public func isNegativeZero(_ float: Float32) -> Bool { return float.floatingPointClass == .negativeZero }
public func isPositiveInfinity(_ float: Float32) -> Bool { return float.floatingPointClass == .positiveInfinity }
public func isPositiveZero(_ float: Float32) -> Bool { return float.floatingPointClass == .positiveZero }

/// Computes the length of the argument.
/// For scalar components `length(x)` is equivalent to `abs(x)`.
/// - Parameter float: a float argument
/// - Returns: the distance between the argument and the origin.
public func length(_ float: Float32) -> Float32 { return abs(float) }

/// Computes the natural (base e) logarithm of arg.
///
/// - Parameter float: 	floating point value
/// - Returns: If no errors occur, the natural (base-e) logarithm of arg (ln(arg) or log_e(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log(_ float: Float32) -> Float32 { return simd.logf(float) }

///  Computes the base 2 logarithm of arg.
///
/// - Parameter float: 	floating point value
/// - Returns: If no errors occur, the base-2 logarithm of arg (log_2(arg) or lb(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log2(_ float: Float32) -> Float32 { return simd.log2f(float) }

/// Computes the common (base-10) logarithm of arg.
///
/// - Parameter float: 	floating point value
/// - Returns: If no errors occur, the common (base-10) logarithm of arg (log_10(arg) or lg(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error occurs, -HUGE_VAL, -HUGE_VALF, or -HUGE_VALL is returned.
public func log10(_ float: Float32) -> Float32 { return simd.log10f(float) }

/// Returns the larger of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the larger of two floating point values. The value returned is exact and does not depend on any rounding modes.
public func max(_ x: Float32, _ y: Float32) -> Float32 { return simd.fmaxf(x, y) }

/// Returns the smaller of two floating point arguments, treating NaNs as missing data (between a NaN and a numeric value, the numeric value is chosen).
///
/// - Parameters:
///   - x: floating point value
///   - y: floating point value
/// - Returns: If successful, returns the smaller of two floating point values. The value returned is exact and does not depend on any rounding modes.
public func min(_ x: Float32, _ y: Float32) -> Float32 { return simd.fminf(x, y) }

/// Linearly interpolates between x and y, taking the value x when t=0 and y when t=1
public func mix(interpolate x: Float32, y: Float32, t: Float32) -> Float32 { return simd.simd_mix(x, y, t) }

/// Computes the floating-point remainder of the division operation x/y.
/// The floating-point remainder of the division operation x/y calculated by this function is exactly the value x - n*y, where n is x/y with its fractional part truncated.
/// The returned value has the same sign as x and is less or equal to y in magnitude.
/// - Parameters:
///   - x: 	floating point value
///   - y: 	floating point value
/// - Returns: If successful, returns the floating-point remainder of the division x/y as defined above.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func mod(_ x: Float32, _ y: Float32) -> Float32 { return simd.fmodf(x, y) }

/// Returns the normalized value of the argument.
///
/// - Parameter x: a float argument.
/// - Returns: one of the following:
///   -1 if ''x'' < 0.
///   1 if ''x'' > 0.
///   NaN otherwise.
public func normalize(_ x: Float32) -> Float32 {
	// FIXME: is this the expected behaviour?
	if x > 0 {
        return 1
    } else if x < 0 {
        return -1
    } else {
        return Float32.nan
    }
}

/// Computes the value of base raised to the power exponent.
///
/// - Parameters:
///   - base: 	base as floating point value
///   - exponent: exponent as floating point value
/// - Returns: If no errors occur, base raised to the power of exponent (base^exponent) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a pole error or a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func pow(_ base: Float32, _ exponent: Float32) -> Float32 { return simd.powf(base, exponent) }

/// Computes the value of base 2 raised to the power exponent.
public func pow2(_ exponent: Float32) -> Float32 { return simd.powf(2, exponent) }

/// Converts degress to radians.
///
/// - Parameter degrees: an angle (in degrees)
/// - Returns: the argument converted to radians.
public func radians(_ degrees: Float32) -> Float32 { return degrees * kDegreeToRadians32 }

/// Reflects the incident vector ''i'' with respect to the normal vector ''n''.
/// This function is equivalent to `i - 2*dot(n, i)*n`.
///
/// - Parameters:
///   - i: the incident vector.
///   - n: the normal, must be normalized to achieve the desired result.
/// - Returns: the reflection vector.
public func reflect(i: Float32, n: Float32) -> Float32 { return i - 2 * (n * i) * n }

/// Refracts the incident vector ''i'' with respect to the normal vector ''n''
/// using the ratio of indices of refraction ''eta''.
///
/// - Parameters:
///   - i: the incident vector, must be normalized to achieve the desired result.
///   - n: the normal, must be normalized to achieve the desired result.
///   - eta: the ratio of indices of refration.
/// - Returns: the refraction vector.
public func refract(i: Float32, n: Float32, eta: Float32) -> Float32 {
	let nTi: Float32 = n * i
	let frac: Float32 = 1 - eta * eta * (1 - nTi * nTi)
	if frac < 0 {
        return Float32(0.0)
    } else {
        return eta * i - (eta * nTi + sqrt(frac)) * n
    }
}

/// Computes the nearest integer value to arg (in floating-point format), rounding halfway cases away from zero, regardless of the current rounding mode.
///
/// - Parameter float: 	floating point value
/// - Returns: If no errors occur, the nearest integer value to arg, rounding halfway cases away from zero, is returned.
public func round(_ float: Float32) -> Float32 { return simd.roundf(float) }

/// Computes the nearest integer value to arg (in integer format), rounding halfway cases away from zero, regardless of the current rounding mode.
///
/// - Parameter float: 	floating point value
/// - Returns: If no errors occur, the nearest integer value to arg, rounding halfway cases away from zero, is returned.
public func round(_ float: Float32) -> Int32 { return Int32(simd.lroundf(float)) }

/// Returns -1 if `x < 0`, +1 if `x > 0`, and 0 otherwise (`sign(NaN)` is 0).
public func sign(_ float: Float32) -> Float32 { return simd.sign(float) }

/// Computes the sine of arg (measured in radians).
///
/// - Parameter float: floating point value representing an angle in radians
/// - Returns: If no errors occur, the sine of arg (sin(arg)) in the range [-1 ; +1], is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sin(_ floatAngleRadians: Float32) -> Float32 { return simd.sinf(floatAngleRadians) }

/// Computes hyperbolic sine of arg.
///
/// - Parameter float: 	floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic sine of arg (sinh(arg), or (e^arg*-e-arg)/2) is returned.
/// If a range error due to overflow occurs, ±HUGE_VAL, ±HUGE_VALF, or ±HUGE_VALL is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sinh(_ float: Float32) -> Float32 { return simd.sinhf(float) }

/// Interpolates smoothly between 0 at edge0 and 1 at edge1
/// You can use a scalar value for edge0 and edge1 if you want to clamp all lanes at the same points.
public func smoothstep(interpolate edge0: Float32, edge1: Float32, x: Float32) -> Float32 { return simd.simd_smoothstep(edge0, edge1, x) }

/// Reciprocal square root.
///
/// - Parameter float: floating point value
/// - Returns: 1 / sqrt(arg)
public func rsqrt(_ float: Float32) -> Float32 { return simd.rsqrt(float) }

/// Computes square root of arg.
///
/// - Parameter float: 	floating point value
/// - Returns: If no errors occur, square root of arg (√arg), is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func sqrt(_ float: Float32) -> Float32 { return simd.sqrtf(float) }

/// Returns 0.0 if x < edge, and 1.0 otherwise.
public func step(_ x: Float32, edge: Float32) -> Float32 { return simd.step(x, edge: edge) }

/// Computes the tangent of arg (measured in radians).
///
/// - Parameter float: 	floating point value representing angle in radians
/// - Returns: If no errors occur, the tangent of arg (tan(arg)) is returned.
/// If a domain error occurs, an implementation-defined value is returned (NaN where supported).
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tan(_ float: Float32) -> Float32 { return simd.tanf(float) }

/// Computes the hyperbolic tangent of arg.
///
/// - Parameter float: 	floating point value representing a hyperbolic angle
/// - Returns: If no errors occur, the hyperbolic tangent of arg (tanh(arg), or (e^arg*-e^-arg)/(e^arg*+e^-arg)) is returned.
/// If a range error occurs due to underflow, the correct result (after rounding) is returned.
public func tanh(_ float: Float32) -> Float32 { return simd.tanhf(float) }

/// Computes the nearest integer not greater in magnitude than arg.
///
/// - Parameter float: 	floating point value
/// - Returns: If no errors occur, the nearest integer value not greater in magnitude than arg (in other words, arg rounded towards zero), is returned.
public func trunc(_ float: Float32) -> Float32 { return simd.truncf(float) }
