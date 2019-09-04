//
//  Mat4x4fTests.swift
//  
//
//  Created by Christian Treffs on 21.07.19.
//

import FirebladeMath

import class XCTest.XCTestCase
import func XCTest.XCTAssertEqual
import func XCTest.XCTAssertTrue
import func XCTest.XCTAssertFalse

class Mat4x4fTests: XCTestCase {
    func testIdentity() {
        let identity: Mat4x4f = .identity
        let values: [Float] = [1,0,0,0,
                               0,1,0,0,
                               0,0,1,0,
                               0,0,0,1]
        XCTAssertEqual(identity.elements, values)
    }
    
    func testInitArrayValues() {
        let values: [Float] = rnd(16)
        let mat = Mat4x4f(values)
        XCTAssertEqual(mat.elements, values)
    }
    
    func testInitVectorColumns() {
        let values: [Float] = rnd(16)
        
        let a = Vec4f(values[0...3])
        let b = Vec4f(values[4...7])
        let c = Vec4f(values[8...11])
        let d = Vec4f(values[12...15])
        
        let mat = Mat4x4f(a, b, c, d)
        
        XCTAssertEqual(mat.elements, values)
    }
    
    func testInitDiagonal() {
        let vec = Vec4f(rnd(4))
        
        let values: [Float] = [vec.x,0,0,0,
                               0,vec.y,0,0,
                               0,0,vec.z,0,
                               0,0,0,vec.w]
        
        let mat = Mat4x4f(diagonal: vec)
        
        XCTAssertEqual(mat.elements, values)
    }
    
    
    func testEquality() {
        XCTAssertTrue(Mat4x4f.identity == Mat4x4f.identity)
        XCTAssertFalse(Mat4x4f(diagonal: [1,2,3,4]) == Mat4x4f.identity)
    }
    
    func testTranslationInit() {
        let vec: Vec3f = Vec3f(rnd(3))
        
        let mat = Mat4x4f(translation: vec)
        
        let values: [Float] = [
            1.000000,0.000000,0.000000,0.000000,
            0.000000,1.000000,0.000000,0.000000,
            0.000000,0.000000,1.000000,0.000000,
            vec.x,   vec.y,   vec.z,   1.000000
        ]
        
        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
    }
    
    func testScaleInit() {
        let vec = Vec3f(rnd(3))
        
        let mat = Mat4x4f(scale: vec)
        
        let values: [Float] = [vec.x,0,0,0,
                               0,vec.y,0,0,
                               0,0,vec.z,0,
                               0,0,0,1]
        
        XCTAssertEqual(mat.elements, values)
    }
    
    func testRotationInitX() {
        let angle: Float = radians(13)
        let axis: Vec3f = .axisX
        
        let values: [Float] = [
            1.000000,0.000000,0.000000,0.000000,
            0.000000,0.974370,0.224951,0.000000,
            0.000000,-0.224951,0.974370,0.000000,
            0.000000,0.000000,0.000000,1.000000
        ]
        
        let mat = Mat4x4f(rotation: angle, axis: axis)
        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
    }
    
    func testRotationInitY() {
        let angle: Float = radians(53)
        let axis: Vec3f = .axisY
        
        let values: [Float] = [
            0.601815,0.000000,-0.798636,0.000000,
            0.000000,1.000000,0.000000,0.000000,
            0.798636,0.000000,0.601815,0.000000,
            0.000000,0.000000,0.000000,1.000000
        ]
        
        let mat = Mat4x4f(rotation: angle, axis: axis)
        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
    }
    
    func testRotationInitZ() {
        let angle: Float = radians(79)
        let axis: Vec3f = .axisZ
        
        let values: [Float] = [
            0.190809,0.981627,0.000000,0.000000,
            -0.981627,0.190809,0.000000,0.000000,
            0.000000,0.000000,1.000000,0.000000,
            0.000000,0.000000,0.000000,1.000000
        ]
        
        let mat = Mat4x4f(rotation: angle, axis: axis)
        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
    }
    
    func testRotationInitXZ() {
        let angle: Float = radians(33)
        let axis: Vec3f = [1,0,1]
        
        let values: [Float] = [
            0.919335,0.385118,0.080665,0.000000,
            -0.385118,0.838671,0.385118,0.000000,
            0.080665,-0.385118,0.919335,0.000000,
            0.000000,0.000000,0.000000,1.000000
        ]
        
        let mat = Mat4x4f(rotation: angle, axis: axis)
        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
    }
    
    
    func testQuaternionInit() {
        let vec: Vec4f = [1.23,4.56,7.89,0.12]
        
        let values: [Float] = [
            -0.963882,0.155028,0.216558,0.000000,
            0.110248,-0.507928,0.854315,0.000000,
            0.242439,0.847334,0.472491,0.000000,
            0.000000,0.000000,0.000000,1.000000
        ]
        
        let mat = Mat4x4f(orientation: Quat4f(vec))
        
        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
    }
    
    
    func testUpperLeft() {
        let vec0: Vec3f = Vec3f(rnd(3))
        let vec1: Vec3f = Vec3f(rnd(3))
        let vec2: Vec3f = Vec3f(rnd(3))
        
        let mat3x3exp = Mat3x3f(vec0, vec1, vec2)
        
        let mat = Mat4x4f(upperLeft: mat3x3exp)
        
        let mat3x3 = mat.upperLeft
        
        XCTAssertEqual(mat3x3, mat3x3exp)
    }
    
    
    func testTranslateMatrixByVector() {
        let values: [Float] = [
            -0.963882,0.155028,0.216558,0.000000,
            0.110248,-0.507928,0.854315,0.000000,
            0.242439,0.847334,0.472491,0.000000,
            24.792658,131.820190,74.315155,1.000000
        ]
        
        var mat: Mat4x4f = [
            -0.963882,0.155028,0.216558,0.000000,
            0.110248,-0.507928,0.854315,0.000000,
            0.242439,0.847334,0.472491,0.000000,
            4.556310,64.323402,-2.345630,1.000000
        ]
        
        mat.translate(by: [7.56, 33.44, 98.32])
        
        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
    }
    
    /*
     func testScaleBy() {
     let floats = rnd(16)
     let vec: Vec3f = Vec3f(rnd(3))
     
     let glkMat = GLKMatrix4Scale(GLKMatrix4(floats), vec.x, vec.y, vec.z)
     
     var mat = Mat4x4f(floats)
     mat.scale(by: vec)
     
     XCTAssertEqual(mat.array, glkMat.array)
     }
     
     func testRotateBy() {
     let floats = rnd(16)
     let vec: Vec3f = Vec3f(rnd(3))
     let rads = radians(rnd(1, in: -720...720)[0])
     let glkMat = GLKMatrix4Rotate(GLKMatrix4(floats), rads, vec.x, vec.y, vec.z)
     
     var mat = Mat4x4f(floats)
     mat.rotate(by: rads, axis: vec)
     
     for (a, b) in zip(mat.array, glkMat.array) {
     XCTAssertEqual(a, b, accuracy: 1e-4) // FIXME: needs more accuracy
     }
     //XCTAssertEqual(mat.floatArray, glkMat.floatArray)
     }
     
     
     func testLookAt() {
     let eye: Vec3f = Vec3f(rnd(3, in: -100.0...100.0))
     let center: Vec3f = Vec3f(rnd(3, in: -100.0...100.0))
     let up: Vec3f = [Vec3f.axisX, Vec3f.axisY, Vec3f.axisZ].randomElement()!
     
     let glkMat = GLKMatrix4MakeLookAt(eye.x, eye.y, eye.z,
     center.x, center.y, center.z,
     up.x, up.y, up.z)
     
     let mat: Mat4x4f = .look(from: eye, at: center, up: up)
     
     for (a, b) in zip(mat.array, glkMat.array) {
     XCTAssertEqual(a, b, accuracy: 1e-5) // FIXME: unstable due to varying resolution depending on input
     }
     //XCTAssertEqual(mat.floatArray, glkMat.floatArray)
     }
     
     func testPerspective() {
     
     let fovy: Float = radians(rnd(1, in: 0.1...360)[0])
     
     let width: Float = rnd(1, in: 1...10000)[0]
     let height: Float = rnd(1, in: 1...10000)[0]
     let aspect: Float = width / height
     let zNear: Float = rnd(1, in: 0.0001...50.0)[0]
     let zFar: Float = rnd(1, in: 50.0001...3000)[0]
     
     let glkMat = GLKMatrix4MakePerspective(fovy, aspect, zNear, zFar)
     
     let mat: Mat4x4f = .perspective(fovy: fovy, width: width, height: height, zNear: zNear, zFar: zFar)
     
     for (a, b) in zip(mat.array, glkMat.array) {
     XCTAssertEqual(a, b)
     }
     }
     
     func testOrthographic() {
     let left: Float = rnd(1)[0]
     let right: Float = rnd(1)[0]
     let bottom: Float = rnd(1)[0]
     let top: Float = rnd(1)[0]
     let zNear: Float = rnd(1, in: 0.0001...50.0)[0]
     let zFar: Float = rnd(1, in: 50.0001...3000)[0]
     
     let glkMat = GLKMatrix4MakeOrtho(left, right, bottom, top, zNear, zFar)
     
     let mat: Mat4x4f = .orthographic(left: left, right: right, bottom: bottom, top: top, zNear: zNear, zFar: zFar)
     
     for (a, b) in zip(mat.array, glkMat.array) {
     XCTAssertEqual(a, b)
     }
     }
     
     
     
     
     
     func testGetScale() {
     let node = SCNNode()
     
     let vec = Vec3f(rnd(3))
     node.simdScale = vec
     XCTAssertEqual(node.simdScale, vec)
     
     let mat = Mat4x4f(scale: vec)
     node.simdTransform = mat
     XCTAssertEqual(mat.scale.x, vec.x)
     XCTAssertEqual(mat.scale.y, vec.y)
     XCTAssertEqual(mat.scale.z, vec.z)
     XCTAssertEqual(node.simdScale.x, vec.x)
     XCTAssertEqual(node.simdScale.y, vec.y)
     XCTAssertEqual(node.simdScale.z, vec.z)
     
     XCTAssertEqual(mat.scale.x, node.simdScale.x)
     XCTAssertEqual(mat.scale.y, node.simdScale.y)
     XCTAssertEqual(mat.scale.z, node.simdScale.z)
     
     let mat2 = Mat4x4f(rotation: radians(35), axis: .axisY) * mat
     node.simdTransform = mat2
     XCTAssertEqual(mat2.scale.x, vec.x)
     XCTAssertEqual(mat2.scale.y, vec.y)
     XCTAssertEqual(mat2.scale.z, vec.z)
     XCTAssertEqual(node.simdScale.x, vec.x)
     XCTAssertEqual(node.simdScale.y, vec.y)
     XCTAssertEqual(node.simdScale.z, vec.z)
     XCTAssertEqual(mat2.scale.x, node.simdScale.x)
     XCTAssertEqual(mat2.scale.y, node.simdScale.y)
     XCTAssertEqual(mat2.scale.z, node.simdScale.z)
     }
     
     func testGetTranslation() {
     let vec = Vec3f(rnd(3))
     let mat = Mat4x4f(translation: vec)
     XCTAssertEqual(mat.translation, vec)
     }
     
     func testEuler() {
     let vec = Vec3f(1, 2, 3)
     let node = SCNNode()
     node.simdPivot = .identity
     
     /// SceneKit applies these rotations relative to the node’s simdPivot property
     /// in the reverse order of the components: first roll, then yaw, then pitch
     /// in radians
     node.simdEulerAngles = vec
     
     let mat = Mat4x4f(eulerAngles: vec)
     
     XCTAssertEqual(mat[0][0], node.simdTransform[0][0])
     XCTAssertEqual(mat[0][1], node.simdTransform[0][1])
     XCTAssertEqual(mat[0][2], node.simdTransform[0][2])
     XCTAssertEqual(mat[0][3], node.simdTransform[0][3])
     XCTAssertEqual(mat[1][0], node.simdTransform[1][0])
     XCTAssertEqual(mat[1][1], node.simdTransform[1][1])
     XCTAssertEqual(mat[1][2], node.simdTransform[1][2])
     XCTAssertEqual(mat[1][3], node.simdTransform[1][3])
     XCTAssertEqual(mat[2][0], node.simdTransform[2][0])
     XCTAssertEqual(mat[2][1], node.simdTransform[2][1])
     XCTAssertEqual(mat[2][2], node.simdTransform[2][2])
     XCTAssertEqual(mat[2][3], node.simdTransform[2][3])
     XCTAssertEqual(mat[3][0], node.simdTransform[3][0])
     XCTAssertEqual(mat[3][1], node.simdTransform[3][1])
     XCTAssertEqual(mat[3][2], node.simdTransform[3][2])
     XCTAssertEqual(mat[3][3], node.simdTransform[3][3])
     
     XCTAssertEqual(mat.eulerAngles, node.simdEulerAngles)
     XCTAssertEqual(mat.eulerAngles, vec.normalized)
     
     XCTAssertEqual(mat.eulerAnglesXYZ, node.simdEulerAngles)
     XCTAssertEqual(mat.eulerAnglesXZY, node.simdEulerAngles)
     XCTAssertEqual(mat.eulerAnglesYXZ, node.simdEulerAngles)
     XCTAssertEqual(mat.eulerAnglesZXY, node.simdEulerAngles)
     XCTAssertEqual(mat.eulerAnglesZYX, node.simdEulerAngles)
     
     }
     */
}



