/// Returns true if the value is positive infinity.
/// - Parameter x: floating point value
/// - Returns: true if the value is positive infinity, false otherwise.
public func isPositiveInfinity(_ x: Float) -> Bool {
    x.floatingPointClass == .positiveInfinity
}

/// Returns true if the value is positive infinity.
/// - Parameter x: floating point value
/// - Returns: true if the value is positive infinity, false otherwise.
public func isPositiveInfinity(_ x: Double) -> Bool {
    x.floatingPointClass == .positiveInfinity
}
