//
//  Quat4fTests.swift
//  
//
//  Created by Christian Treffs on 26.07.19.
//

import FirebladeMath

import class XCTest.XCTestCase
import func XCTest.XCTAssertEqual
import func XCTest.XCTAssertNotEqual
import func XCTest.XCTAssertNotNil

#if canImport(SceneKit)
import class SceneKit.SCNNode
#endif

#if canImport(GLKit)
import GLKit
#endif

class Quat4fTests: XCTestCase {
    
    func testQuatBasicProperties() {
        let q: Quat4f = Quat4f(0,1,2,3)
        XCTAssertNotNil(q)
        XCTAssertNotNil(q.x)
        XCTAssertNotNil(q.y)
        XCTAssertNotNil(q.z)
        XCTAssertNotNil(q.w)
    }
    
    func testQuatInit() {
        let vec: Vec4f = Vec4f(rnd(4))
        
        let glkQuat = GLKQuaternionMake(vec.x, vec.y, vec.z, vec.w)
        let quat = Quat4f(vec)
        
        XCTAssertEqual(quat.vector.x, glkQuat.x)
        XCTAssertEqual(quat.vector.y, glkQuat.y)
        XCTAssertEqual(quat.vector.z, glkQuat.z)
        XCTAssertEqual(quat.vector.w, glkQuat.w)
        
    }
    
    func testGetYawPitchRoll() {
        // prevent gimbal lock
        let yaw: Float = radians(rndDecimal(1, in: -89...89)[0])
        let pitch: Float = radians(rndDecimal(1, in: -180...180)[0])
        let roll: Float = radians(rndDecimal(1, in: -180...180)[0])
        
        let xQuat = Quat4f(angle: pitch, axis: .axisX)
        XCTAssertEqual(xQuat.yaw, 0.0)
        XCTAssertEqual(xQuat.pitch, pitch, accuracy: 1e-6)
        XCTAssertEqual(xQuat.roll, 0.0)
        
        let yQuat = Quat4f(angle: yaw, axis: .axisY)
        XCTAssertEqual(yQuat.yaw, yaw, accuracy: 1e-6)
        XCTAssertEqual(yQuat.pitch, 0.0)
        XCTAssertEqual(yQuat.roll, 0.0)
        
        let zQuat = Quat4f(angle: roll, axis: .axisZ)
        XCTAssertEqual(zQuat.yaw, 0.0)
        XCTAssertEqual(zQuat.pitch, 0.0)
        XCTAssertEqual(zQuat.roll, roll, accuracy: 1e-6)
    }
    
    func testInitYawPitchRoll() {
        // prevent gimbal lock
        let yawDeg = rndDecimal(1, in: -89...89)[0]
        let pitchDeg = rndDecimal(1, in: -180...180)[0]
        let rollDeg = rndDecimal(1, in: -180...180)[0]
        let vec: Vec3f = Vec3f(yawDeg, pitchDeg, rollDeg)
        
        let quat = Quat4f(yaw: radians(vec.x), pitch: radians(vec.y), roll: radians(vec.z))
        
        XCTAssertEqual(quat.yaw, radians(vec.x), accuracy: 1e-6)
        XCTAssertEqual(quat.pitch, radians(vec.y), accuracy: 1e-6)
        XCTAssertEqual(quat.roll, radians(vec.z), accuracy: 1e-6)
        
        XCTAssertEqual(quat.eulerAngles.x, radians(vec.x), accuracy: 1e-6)
        XCTAssertEqual(quat.eulerAngles.y, radians(vec.y), accuracy: 1e-6)
        XCTAssertEqual(quat.eulerAngles.z, radians(vec.z), accuracy: 1e-6)
        
    }
    
    func testAngleAndAxis() {
        let axis: Vec3f = Vec3f(rnd(3))
        let angle: Float = radians(rnd(1)[0])
        
        let glkQuat = GLKQuaternionMakeWithAngleAndVector3Axis(angle, GLKVector3(v: (axis.x, axis.y, axis.z)))
        
        let quat = Quat4f(angle: angle, axis: axis)
        
        XCTAssertEqual(quat.x, glkQuat.x)
        XCTAssertEqual(quat.y, glkQuat.y)
        XCTAssertEqual(quat.z, glkQuat.z)
        XCTAssertEqual(quat.w, glkQuat.w)
        
        let glkAngle = GLKQuaternionAngle(glkQuat)
        let glkAxis = GLKQuaternionAxis(glkQuat)
        XCTAssertEqual(quat.rotationAngle, glkAngle)
        XCTAssertEqual(quat.rotationAxis.x, glkAxis.x, accuracy: 1e-6)
        XCTAssertEqual(quat.rotationAxis.y, glkAxis.y, accuracy: 1e-6)
        XCTAssertEqual(quat.rotationAxis.z, glkAxis.z, accuracy: 1e-6)
    }
    
    func testSIMDQuatAngleBug() {
        let axis: Vec3f = Vec3f(rndDecimal(3))
        let angle: Float = radians(rndDecimal(1)[0])
        
        let glkQuat = GLKQuaternionMakeWithAngleAndVector3Axis(angle, GLKVector3(v: (axis.x, axis.y, axis.z)))
        let quat = Quat4f(angle: angle, axis: axis)
        let glkAngle = GLKQuaternionAngle(glkQuat)
        
        XCTAssertEqual(quat.angle, glkAngle) // FIXME: bug in simd?! It's always ~.pi
        XCTAssertNotEqual(quat.angle, 3.1415927, accuracy: 1e-6)
        XCTAssertEqual(simd_angle(quat), glkAngle) // FIXME: bug in simd?! It's always ~.pi
    }
}
