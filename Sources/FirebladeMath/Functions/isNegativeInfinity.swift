/// Returns true if the value is negative infinity.
/// - Parameter x: floating point value
/// - Returns: true if the value is negative infinity, false otherwise.
@inlinable
public func isNegativeInfinity(_ x: Float) -> Bool {
    x.isInfinite && x.sign == FloatingPointSign.minus
}

/// Returns true if the value is negative infinity.
/// - Parameter x: floating point value
/// - Returns: true if the value is negative infinity, false otherwise.
@inlinable
public func isNegativeInfinity(_ x: Double) -> Bool {
    x.isInfinite && x.sign == FloatingPointSign.minus
}
