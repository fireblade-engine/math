/// Returns true if the value is positive infinity.
/// - Parameter x: floating point value
/// - Returns: true if the value is positive infinity, false otherwise.
@inlinable
public func isPositiveInfinity(_ x: Float) -> Bool {
    x.isInfinite && x.sign == FloatingPointSign.plus
}

/// Returns true if the value is positive infinity.
/// - Parameter x: floating point value
/// - Returns: true if the value is positive infinity, false otherwise.
@inlinable
public func isPositiveInfinity(_ x: Double) -> Bool {
    x.isInfinite && x.sign == FloatingPointSign.plus
}
