public protocol QuaternionStorageProtocol: Sequence, Equatable, Sendable where Element == Value {
    associatedtype Value: StorageScalar

    init(_ x: Value, _ y: Value, _ z: Value, _ w: Value)
    init(_ vector: SIMD4<Value>)

    var x: Value { get set }
    var y: Value { get set }
    var z: Value { get set }
    var w: Value { get set }
}
