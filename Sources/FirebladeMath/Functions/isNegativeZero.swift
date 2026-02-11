/// Returns true if the value is negative zero.
/// - Parameter x: floating point value
/// - Returns: true if the value is negative zero, false otherwise.
public func isNegativeZero(_ x: Float) -> Bool {
    x.floatingPointClass == .negativeZero
}

/// Returns true if the value is negative zero.
/// - Parameter x: floating point value
/// - Returns: true if the value is negative zero, false otherwise.
public func isNegativeZero(_ x: Double) -> Bool {
    x.floatingPointClass == .negativeZero
}