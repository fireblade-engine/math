/// Returns true if the value is negative zero.
/// - Parameter x: floating point value
/// - Returns: true if the value is negative zero, false otherwise.
@inlinable
public func isNegativeZero(_ x: Float) -> Bool {
    x.isZero && x.sign == FloatingPointSign.minus
}

/// Returns true if the value is negative zero.
/// - Parameter x: floating point value
/// - Returns: true if the value is negative zero, false otherwise.
@inlinable
public func isNegativeZero(_ x: Double) -> Bool {
    x.isZero && x.sign == FloatingPointSign.minus
}
