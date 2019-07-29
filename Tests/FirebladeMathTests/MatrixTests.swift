//
//  MatrixTests.swift
//  
//
//  Created by Christian Treffs on 19.07.19.
//

import XCTest
import FirebladeMath
import GLKit
import SceneKit
import QuartzCore

/*
class MatrixTests: XCTestCase {
    
    func testMatrixTranslation() {
        let mat = Mat4x4f(translation: [1,2,3])
        
        XCTAssertEqual(mat[3][0], 1)
        XCTAssertEqual(mat[3][1], 2)
        XCTAssertEqual(mat[3][2], 3)
        
        XCTAssertEqual(mat.translation, [1,2,3])
        
    }
    
    func TestMatrixScale() {
        let mat = Mat4x4f(scale: [1,2,3])
        
        XCTAssertEqual(mat[0][0], 1)
        XCTAssertEqual(mat[1][1], 2)
        XCTAssertEqual(mat[2][2], 3)
        
        XCTAssertEqual(mat.scale, [1,2,3])
    }
    
    func testMatrixRotation() {
        
        let angle: Float = radians(45)
        
        let glkMat = GLKMatrix4MakeRotation(angle, 1, 0, 0)
        
        let caMat = CATransform3DMakeRotation(CGFloat(angle), 1, 0, 0)
        
        let scnMat = SCNMatrix4MakeRotation(CGFloat(angle), 1, 0, 0)
        
        let mat = Mat4x4f(angle: angle, axis: .axisX)
        
        
        //XCTAssertEqual(mat, glkMat)
        //XCTAssertEqual(mat, caMat)
        //XCTAssertEqual(mat, scnMat)
        
    }
}

extension GLKMatrix4: CustomStringConvertible {
    
    public var description: String {
        return """
        ▿ GLKMatrix4
          - m00 : \(m00)
          - m01 : \(m01)
          - m02 : \(m02)
          - m03 : \(m03)
          - m10 : \(m10)
          - m11 : \(m11)
          - m12 : \(m12)
          - m13 : \(m13)
          - m20 : \(m20)
          - m21 : \(m21)
          - m22 : \(m22)
          - m23 : \(m23)
          - m30 : \(m30)
          - m31 : \(m32)
          - m32 : \(m32)
          - m33 : \(m33)
        """
    }
}

extension Mat4x4f: CustomStringConvertible {
    public var description: String {
           return """
           ▿ Mat4x4f
             - m00 : \(self[0][0])
             - m01 : \(self[0][1])
             - m02 : \(self[0][2])
             - m03 : \(self[0][3])
             - m10 : \(self[1][0])
             - m11 : \(self[1][1])
             - m12 : \(self[1][2])
             - m13 : \(self[1][3])
             - m20 : \(self[2][0])
             - m21 : \(self[2][1])
             - m22 : \(self[2][2])
             - m23 : \(self[2][3])
             - m30 : \(self[3][0])
             - m31 : \(self[3][1])
             - m32 : \(self[3][2])
             - m33 : \(self[3][3])
           """
       }
}

*/
