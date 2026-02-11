/// A quaternion.
/// Quaternions are used to represent 3D rotations and orientations.
/// Mathematical representation: q = w + xi + yj + zk
@frozen
public struct Quaternion<Storage: QuaternionStorageProtocol>: Sendable {
    /// The scalar type used in the quaternion.
    public typealias Value = Storage.Value
    @usableFromInline var storage: Storage

    /// Creates a quaternion from a storage object.
    /// - Parameter storage: The storage object.
    @inlinable
    public init(storage: Storage) {
        self.storage = storage
    }
}

extension Quaternion {
    /// Constructs a quaternion from a four-element vector.
    /// - Parameter vector: A four-element vector.
    ///
    /// Note that the imaginary (vector) part of the quaternion comes
    /// from lanes 0, 1, and 2 of the vector, and the real (scalar) part comes from
    /// lane 3.
    public init(_ vector: SIMD4<Value>) {
        self.init(storage: Storage(vector))
    }

    /// Creates a quaternion from its components.
    /// - Parameters:
    ///   - x: The x component of the imaginary part.
    ///   - y: The y component of the imaginary part.
    ///   - z: The z component of the imaginary part.
    ///   - w: The real component.
    public init(_ x: Value, _ y: Value, _ z: Value, _ w: Value) {
        self.init(storage: Storage(x, y, z, w))
    }

    /// Creates an identity quaternion.
    @inlinable
    public init() {
        self.init(Value.zero, Value.zero, Value.zero, Value.one)
    }
}

extension Quaternion {
    /// The x component of the imaginary part.
    @inlinable public var x: Value {
        get { storage.x }
        set { storage.x = newValue }
    }

    /// The y component of the imaginary part.
    @inlinable public var y: Value {
        get { storage.y }
        set { storage.y = newValue }
    }

    /// The z component of the imaginary part.
    @inlinable public var z: Value {
        get { storage.z }
        set { storage.z = newValue }
    }

    /// The real component.
    @inlinable public var w: Value {
        get { storage.w }
        set { storage.w = newValue }
    }
}

extension Quaternion: Sequence {
    /// Creates an iterator over the components of the quaternion.
    public func makeIterator() -> Storage.Iterator {
        storage.makeIterator()
    }

    /// An array containing the components of the quaternion [x, y, z, w].
    @inlinable public var elements: [Value] {
        Array(storage)
    }
}

extension Quaternion: ExpressibleByArrayLiteral {
    /// Creates a quaternion from an array literal.
    public init(arrayLiteral elements: Value...) {
        precondition(elements.count == 4, "Quaternion needs to be initialized with exactly 4 elements")
        self.init(storage: Storage(elements[0], elements[1], elements[2], elements[3]))
    }
}

extension Quaternion: Equatable where Value: Equatable {
    /// Returns a Boolean value indicating whether two quaternions are equal.
    public static func == (lhs: Quaternion<Storage>, rhs: Quaternion<Storage>) -> Bool {
        lhs.storage == rhs.storage
    }
}