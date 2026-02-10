public protocol StorageScalar: SIMDScalar, BinaryFloatingPoint, Sendable, Codable {
    static var one: Self { get }
}

extension Float: StorageScalar {
    public static var one: Float {
        1.0
    }
}

extension Double: StorageScalar {
    public static var one: Double {
        1.0
    }
}
