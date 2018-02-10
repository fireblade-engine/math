//
//  Mat4x4f+Operators.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 10.02.18.
//

import simd

public func * (lhs: Mat4x4f, rhs: Mat4x4f) -> Mat4x4f {
	return matrix_multiply(lhs, rhs)
}
