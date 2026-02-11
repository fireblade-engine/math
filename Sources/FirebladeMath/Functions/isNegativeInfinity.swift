/// Returns true if the value is negative infinity.
/// - Parameter x: floating point value
/// - Returns: true if the value is negative infinity, false otherwise.
public func isNegativeInfinity(_ x: Float) -> Bool {
    x.floatingPointClass == .negativeInfinity
}

/// Returns true if the value is negative infinity.
/// - Parameter x: floating point value
/// - Returns: true if the value is negative infinity, false otherwise.
public func isNegativeInfinity(_ x: Double) -> Bool {
    x.floatingPointClass == .negativeInfinity
}