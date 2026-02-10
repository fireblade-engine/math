//
//  MatrixMultiplicationTests.swift
//
//
//  Created by Christian Treffs on 09.02.26.
//

import FirebladeMath
import Testing

struct MatrixMultiplicationTests {
    @Test func multiplyVec4fMat4x4f() {
        let vec = Vec4f(1, 2, 3, 4)
        let mat = Mat4x4f(diagonal: [1, 1, 1, 1])
        let result = multiply(vec, mat)
        #expect(result == vec)
    }

    @Test func multiplyVec4dMat4x4d() {
        let vec = Vec4d(1, 2, 3, 4)
        let mat = Mat4x4d(diagonal: [1, 1, 1, 1])
        let result = multiply(vec, mat)
        #expect(result == vec)
    }

    @Test func multiplyVec2fMat2x2f() {
        let vec = Vec2f(1, 2)
        let mat = Mat2x2f(diagonal: [1, 1])
        let result = multiply(vec, mat)
        #expect(result == vec)
    }

    @Test func multiplyVec2dMat2x2d() {
        let vec = Vec2d(1, 2)
        let mat = Mat2x2d(diagonal: [1, 1])
        let result = multiply(vec, mat)
        #expect(result == vec)
    }

    @Test func multiplyMat4x4fFunc() {
        let mat = Mat4x4f(diagonal: [1, 2, 3, 4])
        let result = multiply(mat, .identity)
        #expect(result == mat)
    }

    @Test func multiplyMat3x3fFunc() {
        let mat = Mat3x3f(diagonal: [1, 2, 3])
        let result = multiply(mat, .identity)
        #expect(result == mat)
    }

    @Test func multiplyMat2x2fFunc() {
        let mat = Mat2x2f(diagonal: [1, 2])
        let result = multiply(mat, .identity)
        #expect(result == mat)
    }
}