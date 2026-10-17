import FirebladeMathLibC

/// Computes the value of base 2 raised to the power exponent.
/// - Parameter exponent: The exponent.
/// - Returns: 2 raised to the power of exponent.
public func pow2(_ exponent: Float) -> Float {
    FirebladeMathLibC.powf(2, exponent)
}

/// Computes the value of base 2 raised to the power exponent.
/// - Parameter exponent: The exponent.
/// - Returns: 2 raised to the power of exponent.
public func pow2(_ exponent: Double) -> Double {
    FirebladeMathLibC.pow(2, exponent)
}
