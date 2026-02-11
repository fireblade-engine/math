/// A protocol for scalar values that can be stored in SIMD vectors and used in mathematical operations.
public protocol StorageScalar: SIMDScalar, BinaryFloatingPoint, Sendable, Codable {
    /// The value 1.0.
    static var one: Self { get }
}

extension Float: StorageScalar {
    /// The value 1.0.
    public static var one: Float {
        1.0
    }
}

extension Double: StorageScalar {
    /// The value 1.0.
    public static var one: Double {
        1.0
    }
}