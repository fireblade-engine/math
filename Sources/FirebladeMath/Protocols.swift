//
//  Protocols.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 21.05.18.
//

// MARK: - Vector Base

public extension Vec2u {
    static let zero = Vec2u(repeating: 0)
    static let one = Vec2u(repeating: 1)
}

public extension Vec3u {
    static let zero = Vec3u(repeating: 0)
    static let one = Vec3u(repeating: 1)
}

public extension Vec4u {
    static let zero = Vec4u(repeating: 0)
    static let one = Vec4u(repeating: 1)
}

public extension Vec2i {
    static let zero = Vec2i(repeating: 0)
    static let one = Vec2i(repeating: 1)
}

public extension Vec3i {
    static let zero = Vec3i(repeating: 0)
    static let one = Vec3i(repeating: 1)
}

public extension Vec4i {
    static let zero = Vec4i(repeating: 0)
    static let one = Vec4i(repeating: 1)
}

public extension Vec2f {
    static let zero = Vec2f(repeating: 0)
    static let one = Vec2f(repeating: 1)
}

public extension Vec3f {
    static let zero = Vec3f(repeating: 0)
    static let one = Vec3f(repeating: 1)
}

public extension Vec4f {
    static let zero = Vec4f(repeating: 0)
    static let one = Vec4f(repeating: 1)
}

public extension Vec3f {
    static let axisX: Vec3f = simd_normalize([1, 0, 0])
    static let axisY: Vec3f = simd_normalize([0, 1, 0])
    static let axisZ: Vec3f = simd_normalize([0, 0, 1])
}

// MARK: - Matrix Base

public protocol MatrixBase {
    associatedtype Matrix

    static var identity: Matrix { get }
}

// swiftlint:disable explicit_top_level_acl

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
