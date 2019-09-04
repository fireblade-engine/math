//
//  File.swift
//
//
//  Created by Christian Treffs on 29.08.19.
//
#if canImport(GLKit)

import FirebladeMath

import func XCTest.XCTAssertEqual
import func XCTest.XCTAssertTrue

import struct GLKit.GLKVector2
import struct GLKit.GLKVector3
import struct GLKit.GLKVector4

import struct GLKit.GLKMatrix3
import struct GLKit.GLKMatrix4

import let GLKit.GLKMatrix4Identity
import let GLKit.GLKMatrix3Identity

func == (lhs: Mat4x4f, rhs: GLKMatrix4) -> Bool {
    return lhs[0][0] == rhs.m00 &&
        lhs[0][1] == rhs.m01 &&
        lhs[0][2] == rhs.m02 &&
        lhs[0][3] == rhs.m03 &&

        lhs[1][0] == rhs.m10 &&
        lhs[1][1] == rhs.m11 &&
        lhs[1][2] == rhs.m12 &&
        lhs[1][3] == rhs.m13 &&

        lhs[2][0] == rhs.m20 &&
        lhs[2][1] == rhs.m21 &&
        lhs[2][2] == rhs.m22 &&
        lhs[2][3] == rhs.m23 &&

        lhs[3][0] == rhs.m30 &&
        lhs[3][1] == rhs.m31 &&
        lhs[3][2] == rhs.m32 &&
        lhs[3][3] == rhs.m33
}

func == (lhs: Mat3x3f, rhs: GLKMatrix3) -> Bool {
    return lhs[0][0] == rhs.m00 &&
        lhs[0][1] == rhs.m01 &&
        lhs[0][2] == rhs.m02 &&

        lhs[1][0] == rhs.m10 &&
        lhs[1][1] == rhs.m11 &&
        lhs[1][2] == rhs.m12 &&

        lhs[2][0] == rhs.m20 &&
        lhs[2][1] == rhs.m21 &&
        lhs[2][2] == rhs.m22
}

func == (lhs: Vec4f, rhs: GLKVector4) -> Bool {
    return lhs.x == rhs.x &&
        lhs.y == rhs.y &&
        lhs.z == rhs.z &&
        lhs.w == rhs.w
}

func == (lhs: Vec3f, rhs: GLKVector3) -> Bool {
    return lhs.x == rhs.x &&
        lhs.y == rhs.y &&
        lhs.z == rhs.z
}

func == (lhs: Vec2f, rhs: GLKVector2) -> Bool {
    return lhs.x == rhs.x &&
        lhs.y == rhs.y
}

func validateEquality() {
    XCTAssertTrue(Mat4x4f.identity == GLKMatrix4Identity)
    XCTAssertTrue(Mat3x3f.identity == GLKMatrix3Identity)
    XCTAssertTrue(Vec4f(1, 2, 3, 4) == GLKVector4(v: (1.0, 2.0, 3.0, 4.0)))
    XCTAssertTrue(Vec3f(1, 2, 3) == GLKVector3(v: (1.0, 2.0, 3.0)))
    XCTAssertTrue(Vec2f(1, 2) == GLKVector2(v: (1.0, 2.0)))
}

#endif
