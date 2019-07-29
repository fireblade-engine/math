//
//  EqualityCheckTests.swift
//  FirebladeMathTests
//
//  Created by Christian Treffs on 21.07.19.
//

import FirebladeMath

import class XCTest.XCTestCase
import func XCTest.XCTAssertEqual
import func XCTest.XCTAssertTrue

import struct QuartzCore.CATransform3D

import func GLKit.GLKMatrix4MakeLookAt
import func GLKit.GLKMatrix4MakeOrtho
import func GLKit.GLKMatrix4MakePerspective
import func GLKit.GLKMatrix4MakeWithQuaternion
import func GLKit.GLKMatrix4Rotate
import func GLKit.GLKMatrix4Scale
import func GLKit.GLKMatrix4Translate
import func GLKit.GLKMatrix4MakeWithColumns
import struct GLKit.GLKVector4
import struct GLKit.GLKMatrix4
import struct GLKit.GLKQuaternion
import var GLKit.GLKMatrix4Identity

class EqualityCheckTests: XCTestCase {
    
    func testSimd_float4x4EqualsGLMatrix4() {
        
        let mat = Mat4x4f.init(SIMD4<Float>(1, 2, 3, 4),
                                     SIMD4<Float>(5, 6, 7, 8),
                                     SIMD4<Float>(9, 10, 11, 12),
                                     SIMD4<Float>(13, 14, 15, 16))
        
        let glkMat = GLKMatrix4MakeWithColumns(GLKVector4(v: (1,2,3,4)),
                                               GLKVector4(v: (5,6,7,8)),
                                               GLKVector4(v: (9,10,11,12)),
                                               GLKVector4(v: (13,14,15,16)))
        
        XCTAssertEqual(mat.array, glkMat.array)
        XCTAssertTrue(mat == glkMat)
    }
    
    func testSimd_float4x4EqualsCATransform3D() {
        let mat = Mat4x4f.init(SIMD4<Float>(1, 2, 3, 4),
                                     SIMD4<Float>(5, 6, 7, 8),
                                     SIMD4<Float>(9, 10, 11, 12),
                                     SIMD4<Float>(13, 14, 15, 16))
        
        let caMat = CATransform3D.init(m11: 1,
                                       m12: 2,
                                       m13: 3,
                                       m14: 4,
                                       m21: 5,
                                       m22: 6,
                                       m23: 7,
                                       m24: 8,
                                       m31: 9,
                                       m32: 10,
                                       m33: 11,
                                       m34: 12,
                                       m41: 13,
                                       m42: 14,
                                       m43: 15,
                                       m44: 16)
        
        XCTAssertEqual(mat.array, caMat.array)
        XCTAssertTrue(mat == caMat)
    }
    
}
