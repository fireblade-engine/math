/// Returns true if the value is positive zero.
/// - Parameter x: floating point value
/// - Returns: true if the value is positive zero, false otherwise.
@inlinable
public func isPositiveZero(_ x: Float) -> Bool {
    x.isZero && x.sign == FloatingPointSign.plus
}

/// Returns true if the value is positive zero.
/// - Parameter x: floating point value
/// - Returns: true if the value is positive zero, false otherwise.
@inlinable
public func isPositiveZero(_ x: Double) -> Bool {
    x.isZero && x.sign == FloatingPointSign.plus
}
