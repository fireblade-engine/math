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
    public static let zero: Vec2f = Vec2f(0)
}

extension Vec3f: VectorBase {
    public static let zero: Vec3f = Vec3f(0)
}

extension Vec4f: VectorBase {
    public static let zero: Vec4f = Vec4f(0)
}

// MARK: - Matrix Base

public protocol MatrixBase {
    associatedtype Matrix

    static var identity: Matrix { get }
}

extension Mat3x3f: MatrixBase {
    public static let identity: Mat3x3f = Mat3x3f(1)
}

extension Mat4x4f: MatrixBase {
    public static let identity: Mat4x4f = Mat4x4f(1)
}
