/// Returns true if the value is positive zero.
/// - Parameter x: floating point value
/// - Returns: true if the value is positive zero, false otherwise.
public func isPositiveZero(_ x: Float) -> Bool {
    x.floatingPointClass == .positiveZero
}

/// Returns true if the value is positive zero.
/// - Parameter x: floating point value
/// - Returns: true if the value is positive zero, false otherwise.
public func isPositiveZero(_ x: Double) -> Bool {
    x.floatingPointClass == .positiveZero
}