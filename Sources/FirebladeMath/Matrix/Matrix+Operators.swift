//
//  Matrix+Operators.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

public func * (lhs: Mat4x4f, rhs: Mat4x4f) -> Mat4x4f {
    multiply(lhs, rhs)
}

public func * (lhs: Float, rhs: Mat4x4f) -> Mat4x4f {
    multiply(lhs, rhs)
}

public func * (lhs: Vec4f, rhs: Mat4x4f) -> Vec4f {
    multiply(lhs, rhs)
}

public func * (lhs: Mat4x4f, rhs: Vec4f) -> Vec4f {
    multiply(lhs, rhs)
}

public func *= (lhs: inout Mat4x4f, rhs: Mat4x4f) {
    lhs = multiply(lhs, rhs)
}
