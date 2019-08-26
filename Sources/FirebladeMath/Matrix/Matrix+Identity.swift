//
//  Matrix+Identity.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

extension Mat3x3f {
    public static let identity = Mat3x3f(diagonal: .one)
}

extension Mat3x3d {
    public static let identity = Mat3x3d(diagonal: .one)
}

extension Mat4x4f {
    public static let identity = Mat4x4f(diagonal: .one)
}

extension Mat4x4d {
    public static let identity = Mat4x4d(diagonal: .one)
}
