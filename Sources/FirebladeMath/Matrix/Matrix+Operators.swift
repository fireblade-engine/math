//
//  Matrix+Operators.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

// MARK: 4x4f
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

// MARK: 4x4d
public func * (lhs: Mat4x4d, rhs: Mat4x4d) -> Mat4x4d {
    multiply(lhs, rhs)
}

public func * (lhs: Double, rhs: Mat4x4d) -> Mat4x4d {
    multiply(lhs, rhs)
}

public func * (lhs: Vec4d, rhs: Mat4x4d) -> Vec4d {
    multiply(lhs, rhs)
}

public func * (lhs: Mat4x4d, rhs: Vec4d) -> Vec4d {
    multiply(lhs, rhs)
}

public func *= (lhs: inout Mat4x4d, rhs: Mat4x4d) {
    lhs = multiply(lhs, rhs)
}

// MARK: 2x2f
public func * (lhs: Mat2x2f, rhs: Mat2x2f) -> Mat2x2f {
    multiply(lhs, rhs)
}

public func * (lhs: Float, rhs: Mat2x2f) -> Mat2x2f {
    multiply(lhs, rhs)
}

public func * (lhs: Vec2f, rhs: Mat2x2f) -> Vec2f {
    multiply(lhs, rhs)
}

public func * (lhs: Mat2x2f, rhs: Vec2f) -> Vec2f {
    multiply(lhs, rhs)
}

public func *= (lhs: inout Mat2x2f, rhs: Mat2x2f) {
    lhs = multiply(lhs, rhs)
}

// MARK: 2x2d
public func * (lhs: Mat2x2d, rhs: Mat2x2d) -> Mat2x2d {
    multiply(lhs, rhs)
}

public func * (lhs: Double, rhs: Mat2x2d) -> Mat2x2d {
    multiply(lhs, rhs)
}

public func * (lhs: Vec2d, rhs: Mat2x2d) -> Vec2d {
    multiply(lhs, rhs)
}

public func * (lhs: Mat2x2d, rhs: Vec2d) -> Vec2d {
    multiply(lhs, rhs)
}

public func *= (lhs: inout Mat2x2d, rhs: Mat2x2d) {
    lhs = multiply(lhs, rhs)
}
