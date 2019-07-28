//
//  Quat4fTests.swift
//  
//
//  Created by Christian Treffs on 26.07.19.
//

import FirebladeMath
import XCTest
import GLKit
import SceneKit

class Quat4fTests: XCTestCase {
    
    func testVectorInit() {
        let vec: Vec4f = Vec4f(rnd(4))
        
        let glkQuat = GLKQuaternionMake(vec.x, vec.y, vec.z, vec.w)
        let quat = Quat4f(vec)
        
        XCTAssertEqual(quat.vector.x, glkQuat.x)
        XCTAssertEqual(quat.vector.y, glkQuat.y)
        XCTAssertEqual(quat.vector.z, glkQuat.z)
        XCTAssertEqual(quat.vector.w, glkQuat.w)
        
    }
    
    func testGetYawPitchRoll() {
        // FIXME: prevent gimbal lock
        let angle: Float = radians(rndDecimal(1, in: -180...180)[0])
        
        let xQuat = Quat4f(angle: angle, axis: .axisX)
        XCTAssertEqual(xQuat.yaw, 0.0)
        XCTAssertEqual(xQuat.pitch, angle, accuracy: 1e-7)
        XCTAssertEqual(xQuat.roll, 0.0)
        
        let yQuat = Quat4f(angle: angle, axis: .axisY)
        XCTAssertEqual(yQuat.yaw, angle, accuracy: 1e-7)
        XCTAssertEqual(yQuat.pitch, 0.0)
        XCTAssertEqual(yQuat.roll, 0.0)
        
        let zQuat = Quat4f(angle: angle, axis: .axisZ)
        XCTAssertEqual(zQuat.yaw, 0.0)
        XCTAssertEqual(zQuat.pitch, 0.0)
        XCTAssertEqual(zQuat.roll, angle, accuracy: 1e-7)
    }
    
    func testInitYawPitchRoll() {
        // FIXME: prevent gimbal lock
        let yawDeg = rndDecimal(1, in: -89...89)[0]
        let pitchDeg = rndDecimal(1, in: -180...180)[0]
        let rollDeg = rndDecimal(1, in: -180...180)[0]
        let vec: Vec3f = Vec3f(yawDeg, pitchDeg, rollDeg)
        
        let quat = Quat4f(yaw: radians(vec.x), pitch: radians(vec.y), roll: radians(vec.z))
        
        XCTAssertEqual(quat.yaw, radians(vec.x), accuracy: 1e-6)
        XCTAssertEqual(quat.pitch, radians(vec.y), accuracy: 1e-6)
        XCTAssertEqual(quat.roll, radians(vec.z), accuracy: 1e-6)
        
        XCTAssertEqual(quat.eulerAngles.yaw, radians(vec.x), accuracy: 1e-6)
        XCTAssertEqual(quat.eulerAngles.pitch, radians(vec.y), accuracy: 1e-6)
        XCTAssertEqual(quat.eulerAngles.roll, radians(vec.z), accuracy: 1e-6)
        
    }
    
    func testAngle() {
        let axis: Vec3f = Vec3f(rnd(3))
        let angle: Float = radians(rnd(1)[0])
        
        let glkQuat = GLKQuaternionMakeWithAngleAndVector3Axis(angle, GLKVector3(v: (axis.x, axis.y, axis.z)))
        
        let quat = Quat4f(angle: angle, axis: axis)
        
        XCTAssertEqual(quat.vector.x, glkQuat.x)
        XCTAssertEqual(quat.vector.y, glkQuat.y)
        XCTAssertEqual(quat.vector.z, glkQuat.z)
        XCTAssertEqual(quat.vector.w, glkQuat.w)
        
        let glkAngle = GLKQuaternionAngle(glkQuat)
        let qAngle = quat.angle
        let pAngle = simd_angle(quat)
        let wAngle = quat.angle2
        let rAngle = quat.angle3
        
        XCTAssertEqual(qAngle, glkAngle) // FIXME: bug in simd?! It's always .pi
        XCTAssertNotEqual(qAngle, 3.1415927)
        XCTAssertEqual(pAngle, glkAngle) // FIXME: bug in simd?! It's always .pi
        XCTAssertEqual(wAngle, glkAngle)
        XCTAssertEqual(rAngle, glkAngle)
        
    }
}
