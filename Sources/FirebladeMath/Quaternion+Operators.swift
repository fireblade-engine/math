//
//  Quaternion+Operators.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

public func * (lhs: Float, rhs: Quat4f) -> Quat4f {
    multiply(lhs, rhs)
}

public func * (lhs: Quat4f, rhs: Float) -> Quat4f {
    multiply(lhs, rhs)
}

/// Returns the product of two quaternions.
public func * (lhs: Quat4f, rhs: Quat4f) -> Quat4f {
    multiply(lhs, rhs)
}

/// Returns a vector rotated by a quaternion.
public func * (lhs: Quat4f, rhs: Vec3f) -> Vec3f {
    act(lhs, rhs)
}

public func *= (lhs: inout Quat4f, rhs: Quat4f) {
    lhs = multiply(lhs, rhs)
}

public func + (lhs: Quat4f, rhs: Quat4f) -> Quat4f {
    add(lhs, rhs)
}

public func - (lhs: Quat4f, rhs: Quat4f) -> Quat4f {
    subtract(lhs, rhs)
}
