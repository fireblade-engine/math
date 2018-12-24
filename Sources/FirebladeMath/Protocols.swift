//
//  Protocols.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 21.05.18.
//

// MARK: - Vector Base

public protocol VectorBase {
    associatedtype Vector

    static var zero: Vector { get }
}

extension Vec2f: VectorBase {
    public static let zero = Vec2f(0)
}

extension Vec3f: VectorBase {
    public static let zero = Vec3f(0)
}

extension Vec4f: VectorBase {
    public static let zero = Vec4f(0)
}

public extension Vec3f {
    static let axisX: Vec3f = [1, 0, 0]
    static let axisY: Vec3f = [0, 1, 0]
    static let axisZ: Vec3f = [0, 0, 1]
}

// MARK: - Matrix Base

public protocol MatrixBase {
    associatedtype Matrix

    static var identity: Matrix { get }
}

extension Mat3x3f: MatrixBase {
    public static let identity = Mat3x3f(1)
}

extension Mat4x4f: MatrixBase {
    public static let identity = Mat4x4f(1)
}

// MARK: - Quaternion base
public protocol QuaternionBase {
    associatedtype Quaternion

    static var identity: Quaternion { get }
}

extension Quat4f: QuaternionBase {
    public static let identity = Quat4f(0, 0, 0, 1)
}
