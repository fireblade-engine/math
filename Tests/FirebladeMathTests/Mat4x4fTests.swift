//
//  Mat4x4fTests.swift
//  
//
//  Created by Christian Treffs on 21.07.19.
//

import XCTest
import simd
import GLKit
import SceneKit
import FirebladeMath

func rnd(_ count: Int, in range: ClosedRange<Float> = -1e-9...1e9) -> [Float] {
    return (0..<count).map { _ in Float.random(in: range) }
}

class Mat4x4fTests: XCTestCase {
    
    func testIdentity() {
        let glkIdentity = GLKMatrix4Identity
        let identity: Mat4x4f = .identity
        XCTAssertEqual(identity.array, glkIdentity.array)
    }
    
    func testArrayInit() {
        let f = rnd(16)
        let glkMat = GLKMatrix4(f)
        
        let mat = Mat4x4f(f)
        
        XCTAssertEqual(mat.array, glkMat.array)
    }
    
    func testVectorColumnsInit() {
        let f = rnd(16)
        let glkMat = GLKMatrix4(f)
        
        let mat = Mat4x4f(columns: Vec4f(f[0...3]), Vec4f(f[4...7]), Vec4f(f[8...11]), Vec4f(f[12...15]))
        
        XCTAssertEqual(mat.array, glkMat.array)
    }
    
    func testTranslationInit() {
        let vec = Vec3f(rnd(3))
        let glkMat = GLKMatrix4Translate(GLKMatrix4Identity, vec.x, vec.y, vec.z)
        
        let mat = Mat4x4f(translation: vec)
        
        XCTAssertEqual(mat.array, glkMat.array)
    }
    
    func testScaleInit() {
        let vec = Vec3f(rnd(3))
        let glkMat = GLKMatrix4Scale(GLKMatrix4Identity, vec.x, vec.y, vec.z)
        
        let mat = Mat4x4f(scale: vec)
        
        XCTAssertEqual(mat.array, glkMat.array)
    }
    
    func testRotationInit() {
        let axis = Vec3f(rnd(3))
        let angle = rnd(1, in: -720...720)[0]
        
        let glkRot = GLKMatrix4Rotate(GLKMatrix4Identity, radians(angle), axis.x, axis.y, axis.z)
        
        let matRot = Mat4x4f(rotation: radians(angle), axis: axis)
        
        for (a, b) in zip(matRot.array, glkRot.array) {
            XCTAssertEqual(a, b, accuracy: 1e-6)
        }
        //XCTAssertEqual(matRot.floatArray, glkRot.floatArray)
        
    }
    
    func testQuaternionInit() {
        let vec = rnd(4)
        
        let glkQuad = GLKQuaternion(q: (vec[0], vec[1], vec[2], vec[3]))
        let glkMat = GLKMatrix4MakeWithQuaternion(glkQuad)
        
        let quad = Quat4f(ix: vec[0], iy: vec[1], iz: vec[2], r: vec[3])
        
        XCTAssertEqual(quad.vector[0], glkQuad.x)
        XCTAssertEqual(quad.vector[1], glkQuad.y)
        XCTAssertEqual(quad.vector[2], glkQuad.z)
        XCTAssertEqual(quad.vector[3], glkQuad.w)
        
        let mat = Mat4x4f(orientation: quad)
        
        for (a, b) in zip(mat.array, glkMat.array) {
            XCTAssertEqual(a, b, accuracy: 1e-6)
        }
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
    
    func testUpperLeft() {
        let vec0: Vec3f = Vec3f(rnd(3))
        let vec1: Vec3f = Vec3f(rnd(3))
        let vec2: Vec3f = Vec3f(rnd(3))
        
        let mat3x3exp = Mat3x3f(vec0, vec1, vec2)
        
        let mat = Mat4x4f(upperLeft: mat3x3exp)
        
        let mat3x3 = mat.upperLeft
        
        XCTAssertEqual(mat3x3, mat3x3exp)
    }
    
    func testDiagonal() {
        let vec = Vec4f(rnd(4))
        let mat = Mat4x4f(diagonal: vec)
        
        XCTAssertEqual(mat[0][0], vec.x)
        XCTAssertEqual(mat[0][1], 0)
        XCTAssertEqual(mat[0][2], 0)
        XCTAssertEqual(mat[0][3], 0)
        
        XCTAssertEqual(mat[1][0], 0)
        XCTAssertEqual(mat[1][1], vec.y)
        XCTAssertEqual(mat[1][2], 0)
        XCTAssertEqual(mat[1][3], 0)
        
        XCTAssertEqual(mat[2][0], 0)
        XCTAssertEqual(mat[2][1], 0)
        XCTAssertEqual(mat[2][2], vec.z)
        XCTAssertEqual(mat[2][3], 0)
        
        XCTAssertEqual(mat[3][0], 0)
        XCTAssertEqual(mat[3][1], 0)
        XCTAssertEqual(mat[3][2], 0)
        XCTAssertEqual(mat[3][3], vec.w)
    }
    
    func testTranslateBy() {
        let floats = rnd(16)
        let vec: Vec3f = Vec3f(rnd(3))
        
        let glkMat = GLKMatrix4Translate(GLKMatrix4(floats), vec.x, vec.y, vec.z)
        
        
        var mat = Mat4x4f(floats)
        mat.translate(by: vec)
        
        XCTAssertEqual(mat.array, glkMat.array)
    }
    
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
    
    func testGetScale() {
        let node = SCNNode()
        
        let vec = Vec3f(rnd(3))
        node.simdScale = vec
        XCTAssertEqual(node.simdScale, vec)
        
        let mat = Mat4x4f(scale: vec)
        node.simdTransform = mat
        XCTAssertEqual(mat.scale, vec)
        XCTAssertEqual(node.simdScale, vec)
        XCTAssertEqual(mat.scale, node.simdScale)
        
        let mat2 = Mat4x4f(rotation: radians(35), axis: .axisY) * mat
        node.simdTransform = mat2
        XCTAssertEqual(mat2.scale, vec)
        XCTAssertEqual(node.simdScale, vec)
        XCTAssertEqual(mat2.scale, node.simdScale)
    }
    
    func testGetTranslation() {
        let vec = Vec3f(rnd(3))
        let mat = Mat4x4f(translation: vec)
        XCTAssertEqual(mat.translation, vec)
    }
    
    func testEuler() {
        let vec = Vec3f(rnd(3))
        let node = SCNNode()
        node.simdPivot = .identity
        
        /// SceneKit applies these rotations relative to the node’s simdPivot property
        /// in the reverse order of the components: first roll, then yaw, then pitch
        /// in radians
        node.simdEulerAngles = vec
        
        
        let mat = Mat4x4f(eulerAngles: vec)
        
        let refMat = Mat4x4f(rotation: vec.z, axis: .axisZ) * Mat4x4f(rotation: vec.y, axis: .axisY) * Mat4x4f(rotation: vec.x, axis: .axisX)
        
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
        
        XCTAssertEqual(refMat[0][0], node.simdTransform[0][0], accuracy: 1e-6)
        XCTAssertEqual(refMat[0][1], node.simdTransform[0][1], accuracy: 1e-6)
        XCTAssertEqual(refMat[0][2], node.simdTransform[0][2], accuracy: 1e-6)
        XCTAssertEqual(refMat[0][3], node.simdTransform[0][3], accuracy: 1e-6)
        XCTAssertEqual(refMat[1][0], node.simdTransform[1][0], accuracy: 1e-6)
        XCTAssertEqual(refMat[1][1], node.simdTransform[1][1], accuracy: 1e-6)
        XCTAssertEqual(refMat[1][2], node.simdTransform[1][2], accuracy: 1e-6)
        XCTAssertEqual(refMat[1][3], node.simdTransform[1][3], accuracy: 1e-6)
        XCTAssertEqual(refMat[2][0], node.simdTransform[2][0], accuracy: 1e-6)
        XCTAssertEqual(refMat[2][1], node.simdTransform[2][1], accuracy: 1e-6)
        XCTAssertEqual(refMat[2][2], node.simdTransform[2][2], accuracy: 1e-6)
        XCTAssertEqual(refMat[2][3], node.simdTransform[2][3], accuracy: 1e-6)
        XCTAssertEqual(refMat[3][0], node.simdTransform[3][0], accuracy: 1e-6)
        XCTAssertEqual(refMat[3][1], node.simdTransform[3][1], accuracy: 1e-6)
        XCTAssertEqual(refMat[3][2], node.simdTransform[3][2], accuracy: 1e-6)
        XCTAssertEqual(refMat[3][3], node.simdTransform[3][3], accuracy: 1e-6)
        
    }
}



