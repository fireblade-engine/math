/// A protocol that defines the storage requirements for a quaternion.
public protocol QuaternionStorageProtocol: Sequence, Equatable, Sendable where Element == Value {
    /// The scalar type used in the quaternion.
    associatedtype Value: StorageScalar

    /// Creates a new storage from its components.
    init(_ x: Value, _ y: Value, _ z: Value, _ w: Value)
    /// Creates a new storage from a 4D vector [x, y, z, w].
    init(_ vector: SIMD4<Value>)

    /// The x component of the imaginary part.
    var x: Value { get set }
    /// The y component of the imaginary part.
    var y: Value { get set }
    /// The z component of the imaginary part.
    var z: Value { get set }
    /// The real component.
    var w: Value { get set }
}