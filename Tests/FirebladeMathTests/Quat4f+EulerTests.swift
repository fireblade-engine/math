//
//  Quat4f+EulerTests.swift
//  FirebladeMathTests
//
//  Created by Christian Treffs on 18.02.21.
//

import XCTest
import FirebladeMath

class Quat4f_EulerTests: XCTestCase {
    
    func testQuatFromEulerAngles_0_0_0() {
        let pitch: Float = 0
        let yaw: Float   = 0
        let roll: Float  = 0
        
        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)
        
        XCTAssertEqual(quat.x, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.y, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.z, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.w, 1, accuracy: 1e-7)
        XCTAssertEqual(quat.pitch, 0)
        XCTAssertEqual(quat.yaw, 0)
        XCTAssertEqual(quat.roll, 0)
    }
    
    func testQuatFromEulerAngles_90_0_0() {
        let pitch: Float = .pi
        let yaw: Float   = 0
        let roll: Float  = 0
        
        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)
        
        XCTAssertEqual(quat.x, 1, accuracy: 1e-7)
        XCTAssertEqual(quat.y, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.z, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.w, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.pitch, .pi)
        XCTAssertEqual(quat.yaw, 0)
        XCTAssertEqual(quat.roll, 0)
    }
    
    func testQuatFromEulerAngles_n90_0_0() {
        let pitch: Float = -.pi
        let yaw: Float   = 0
        let roll: Float  = 0
        
        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)
        
        XCTAssertEqual(quat.x, -1, accuracy: 1e-7)
        XCTAssertEqual(quat.y, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.z, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.w, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.pitch, -.pi)
        XCTAssertEqual(quat.yaw, 0)
        XCTAssertEqual(quat.roll, 0)
    }
    
    
    func testQuatFromEulerAngles_0_90_0() {
        let pitch: Float = 0
        let yaw: Float   = .pi
        let roll: Float  = 0
        
        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)
        
        XCTAssertEqual(quat.x, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.y, 1, accuracy: 1e-7)
        XCTAssertEqual(quat.z, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.w, 0, accuracy: 1e-7)
        // gimbal lock
        XCTAssertEqual(quat.pitch, .pi)
        XCTAssertEqual(quat.yaw, 0, accuracy: 1e-6)
        XCTAssertEqual(quat.roll, .pi)
    }
    
    func testQuatFromEulerAngles_0_n90_0() {
        let pitch: Float = 0
        let yaw: Float   = -.pi
        let roll: Float  = 0
        
        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)
        
        XCTAssertEqual(quat.x, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.y, -1, accuracy: 1e-7)
        XCTAssertEqual(quat.z, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.w, 0, accuracy: 1e-7)
        // gimbal lock
        XCTAssertEqual(quat.pitch, .pi)
        XCTAssertEqual(quat.yaw, 0, accuracy: 1e-6)
        XCTAssertEqual(quat.roll, .pi)
    }
    
    func testQuatFromEulerAngles_0_0_90() {
        let pitch: Float = 0
        let yaw: Float   = 0
        let roll: Float  = .pi
        
        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)
        
        XCTAssertEqual(quat.x, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.y, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.z, 1, accuracy: 1e-7)
        XCTAssertEqual(quat.w, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.pitch, 0)
        XCTAssertEqual(quat.yaw, 0)
        XCTAssertEqual(quat.roll, .pi)
    }
    
    func testQuatFromEulerAngles_0_0_n90() {
        let pitch: Float = 0
        let yaw: Float   = 0
        let roll: Float  = -.pi
        
        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)
        
        XCTAssertEqual(quat.x, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.y, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.z, -1, accuracy: 1e-7)
        XCTAssertEqual(quat.w, 0, accuracy: 1e-7)
        XCTAssertEqual(quat.pitch, 0)
        XCTAssertEqual(quat.yaw, 0)
        XCTAssertEqual(quat.roll, -.pi)
    }
    
    func testQuatFromEulerAngles_pitches_yaw0_roll0() {
        let pitches: [Float] = [-180, -90, -1, 1, 90, 180].map(radians)
        let yaw: Float = radians(0)
        let roll: Float  = radians(0)
        
        let results: [Quat4f] = pitches.map { Quat4f(pitch: $0, yaw: yaw, roll: roll) }
        
        let expectations: [Quat4f] = [
            .init(-1.0, -0.0, 0.0, -4.371139e-08),
            .init(-0.70710677, 0.0, 0.0, 0.70710677),
            .init(-0.008726535, 0.0, 0.0, 0.9999619),
            .init(0.008726535, 0.0, 0.0, 0.9999619),
            .init(0.70710677, 0.0, 0.0, 0.70710677),
            .init(1.0, 0.0, -0.0, -4.371139e-08),
        ]
        assert(expectations.count == results.count)
        
        for (res, exp) in zip(results, expectations) {
            XCTAssertEqual(res.x, exp.x, accuracy: 1e-7)
            XCTAssertEqual(res.y, exp.y, accuracy: 1e-7)
            XCTAssertEqual(res.z, exp.z, accuracy: 1e-7)
            XCTAssertEqual(res.w, exp.w, accuracy: 1e-7)
        }   
    }
    
    func testQuatFromEulerAngles_pitch0_yaws_roll0() {
        let pitch: Float = radians(0)
        let yaws: [Float] = [-180, -90, -1, 1, 90, 180].map(radians)
        let roll: Float  = radians(0)
        
        let results: [Quat4f] = yaws.map { Quat4f(pitch: pitch, yaw: $0, roll: roll) }
        
        let expectations: [Quat4f] = [
            .init(0.0, -1.0, 0.0, -4.371139e-08),
            .init(0.0, -0.70710677, 0.0, 0.70710677),
            .init(0.0, -0.008726535, 0.0, 0.9999619),
            .init(0.0, 0.008726535, 0.0, 0.9999619),
            .init(0.0, 0.70710677, 0.0, 0.70710677),
            .init(-0.0,  1.0, -0.0, -4.371139e-08),
        ]
        assert(expectations.count == results.count)
        
        for (res, exp) in zip(results, expectations) {
            XCTAssertEqual(res.x, exp.x, accuracy: 1e-7)
            XCTAssertEqual(res.y, exp.y, accuracy: 1e-7)
            XCTAssertEqual(res.z, exp.z, accuracy: 1e-7)
            XCTAssertEqual(res.w, exp.w, accuracy: 1e-7)
        }
    }
    
    func testQuatFromEulerAngles_pitch0_yaw0_rolls() {
        let pitch: Float = radians(0)
        let yaw: Float = radians(0)
        let rolls: [Float] = [-180, -90, -1, 1, 90, 180].map(radians)
        
        let results: [Quat4f] = rolls.map { Quat4f(pitch: pitch, yaw: yaw, roll: $0) }
        
        let expectations: [Quat4f] = [
            .init(0.0, -0.0, -1.0, -4.371139e-08),
            .init(0.0, 0.0, -0.70710677, 0.70710677),
            .init(0.0, 0.0, -0.008726535, 0.9999619),
            .init(0.0, 0.0, 0.008726535, 0.9999619),
            .init(0.0, 0.0, 0.70710677, 0.70710677),
            .init(-0.0, 0.0, 1.0, -4.371139e-08),
        ]
        assert(expectations.count == results.count)
        
        for (res, exp) in zip(results, expectations) {
            XCTAssertEqual(res.x, exp.x, accuracy: 1e-7)
            XCTAssertEqual(res.y, exp.y, accuracy: 1e-7)
            XCTAssertEqual(res.z, exp.z, accuracy: 1e-7)
            XCTAssertEqual(res.w, exp.w, accuracy: 1e-7)
        }
    }
    
    func testEulerAnglesFromQuat_0_0_0() {
        let quat = Quat4f.identity
        let eulers = quat.eulerAngles
        XCTAssertEqual(eulers.x, 0, accuracy: 1e-7)
        XCTAssertEqual(eulers.y, 0, accuracy: 1e-7)
        XCTAssertEqual(eulers.z, 0, accuracy: 1e-7)
    }
    
    /*
    func testEulerAnglesFromQuat_pitches_yaw0_roll0() {
        let quats: [Quat4f] = [
            .init(-1.0, -0.0, 0.0, -4.371139e-08),    // -180, 0, 0
            .init(-0.70710677, 0.0, 0.0, 0.70710677), // - 90, 0, 0
            .init(-0.008726535, 0.0, 0.0, 0.9999619), // - 1, 0, 0
            .init(0.008726535, 0.0, 0.0, 0.9999619),  // 1, 0, 0
            .init(0.70710677, 0.0, 0.0, 0.70710677),  // 90, 0, 0
            .init(-1.0, 0.0, -0.0, -4.371139e-08),     // 180, 0, 0
        ]
        
        let pitches: [Float] = [-180, -90, -1, 1, 90, 180].map(radians)
        let yaw: Float = radians(0)
        let roll: Float  = radians(0)
        
        let expectations: [Vec3f] = pitches.map { Vec3f($0, yaw, roll) }
        
        let results = quats.map(\.eulerAngles)
        
        assert(expectations.count == results.count)
        
        for (res, exp) in zip(results, expectations) {
            XCTAssertEqual(res.x, exp.x, accuracy: 1e-6)
            XCTAssertEqual(res.y, exp.y, accuracy: 1e-6)
            XCTAssertEqual(res.z, exp.z, accuracy: 1e-6)
        }
    }
    
    func testEulerAnglesFromQuat_pitch0_yaws_roll0() {
        let quats: [Quat4f] = [
            .init(0.0, -1.0, 0.0, -4.371139e-08),
            .init(0.0, -0.70710677, 0.0, 0.70710677),
            .init(0.0, -0.008726535, 0.0, 0.9999619),
            .init(0.0, 0.008726535, 0.0, 0.9999619),
            .init(0.0, 0.70710677, 0.0, 0.70710677),
            .init(-0.0,  1.0, -0.0, -4.371139e-08),
        ]
        
        let pitch: Float = radians(0)
        let yaws: [Float] = [-180, -90, -1, 1, 90, 180].map(radians)
        let roll: Float  = radians(0)
        
        let expectations: [Vec3f] = yaws.map { Vec3f(pitch, $0, roll) }
        
        let results = quats.map(\.eulerAngles)
        
        assert(expectations.count == results.count)
        
        for (res, exp) in zip(results, expectations) {
            XCTAssertEqual(res.x, exp.x, accuracy: 1e-6)
            XCTAssertEqual(res.y, exp.y, accuracy: 1e-6)
            XCTAssertEqual(res.z, exp.z, accuracy: 1e-6)
        }
    }
    
    func testEulerAnglesFromQuat_pitch0_yaw0_rolls() {
        let quats: [Quat4f] = [
            .init(0.0, -0.0, -1.0, -4.371139e-08),
            .init(0.0, 0.0, -0.70710677, 0.70710677),
            .init(0.0, 0.0, -0.008726535, 0.9999619),
            .init(0.0, 0.0, 0.008726535, 0.9999619),
            .init(0.0, 0.0, 0.70710677, 0.70710677),
            .init(-0.0, 0.0, 1.0, -4.371139e-08),
        ]
        
        let pitch: Float = radians(0)
        let yaw: Float = radians(0)
        let rolls: [Float] = [-180, -90, -1, 1, 90, 180].map(radians)
        
        let expectations: [Vec3f] = rolls.map { Vec3f(pitch, yaw, $0) }
        
        let results = quats.map(\.eulerAngles)
        
        assert(expectations.count == results.count)
        
        for (res, exp) in zip(results, expectations) {
            XCTAssertEqual(res.x, exp.x, accuracy: 1e-6)
            XCTAssertEqual(res.y, exp.y, accuracy: 1e-6)
            XCTAssertEqual(res.z, exp.z, accuracy: 1e-6)
        }
    }
     */
}
