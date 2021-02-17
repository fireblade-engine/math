//
//  EulerConversionTests.swift
//  FirebladeMathTests
//
//  Created by Christian Treffs on 19.02.21.
//

import XCTest
import FirebladeMath

final class EulerConversionTests: XCTestCase {
    
    #if DEBUG
    let step: Float = 4
    let expMaxFailureRate: Double = 0.052
    #else
    let step: Float = 0.5
    let expMaxFailureRate: Double = 0.033
    #endif
    
    let precission: Float = 1e-04
    
    lazy var angles_2pi = AngleDeg(from: -180, to: 180, step: step)
    lazy var angles_Pi  = AngleDeg(from: -90, to: 90, step: step)
    
    func testPrecissionEuler2Quat2Euler_123() throws {
        // 123 - total:186624000 - failure rate: 3.2522606953017834%
        XCTAssertLessThanOrEqual(try convertEul2Quat2Eul(name: "123",
                                                         precission: precission,
                                                         pitch: angles_2pi,
                                                         yaw: angles_Pi,
                                                         roll: angles_2pi,
                                                         fromEuler: Quat4f.fromEulerAngles_123,
                                                         toEuler: quaternionToEulerAngles_123), expMaxFailureRate)
    }
    
    func testPrecissionEuler2Quat2Euler_132() throws {
        // 132 - total:186624000 - failure rate: 3.2738302683470506%
        XCTAssertLessThanOrEqual(try convertEul2Quat2Eul(name: "132",
                                                         precission: precission,
                                                         pitch: angles_2pi,
                                                         yaw: angles_Pi,
                                                         roll: angles_2pi,
                                                         fromEuler: Quat4f.fromEulerAngles_132,
                                                         toEuler: quaternionToEulerAngles_132), expMaxFailureRate)
    }
    
    func testPrecissionEuler2Quat2Euler_213() throws {
        // 213 - total:186624000 - failure rate: 3.2428599751371747%
        XCTAssertLessThanOrEqual(try convertEul2Quat2Eul(name: "213",
                                                         precission: precission,
                                                         pitch: angles_2pi,
                                                         yaw: angles_Pi,
                                                         roll: angles_2pi,
                                                         fromEuler: Quat4f.fromEulerAngles_213,
                                                         toEuler: quaternionToEulerAngles_213), expMaxFailureRate)
    }
    
    func testPrecissionEuler2Quat2Euler_231() throws {
        // 231 - total:186624000 - failure rate: 3.25240751457476%
        XCTAssertLessThanOrEqual(try convertEul2Quat2Eul(name: "231",
                                                         precission: precission,
                                                         pitch: angles_2pi,
                                                         yaw: angles_Pi,
                                                         roll: angles_2pi,
                                                         fromEuler: Quat4f.fromEulerAngles_231,
                                                         toEuler: quaternionToEulerAngles_231), expMaxFailureRate)
    }
    
    func testPrecissionEuler2Quat2Euler_312() throws {
        // 312 - total:186624000 - failure rate: 3.2207770704732512%
        XCTAssertLessThanOrEqual(try convertEul2Quat2Eul(name: "312",
                                                         precission: precission,
                                                         pitch: angles_2pi,
                                                         yaw: angles_Pi,
                                                         roll: angles_2pi,
                                                         fromEuler: Quat4f.fromEulerAngles_312,
                                                         toEuler: quaternionToEulerAngles_312), expMaxFailureRate)
        
    }
    
    func testPrecissionEuler2Quat2Euler_321() throws {
        // 321 - total:186624000 - failure rate: 3.2740563914609053%
        XCTAssertLessThanOrEqual(try convertEul2Quat2Eul(name: "321",
                                                         precission: precission,
                                                         pitch: angles_2pi,
                                                         yaw: angles_Pi,
                                                         roll: angles_2pi,
                                                         fromEuler: Quat4f.fromEulerAngles_321,
                                                         toEuler: quaternionToEulerAngles_321), expMaxFailureRate)
    }
    
    /*
     // MARK: - two axes
     //
     //  testQuatFromEulerAnglesFunc(name: "121",
     //                              deltaDeg: deltaDeg,
     //                              pitch: angles_2pi,
     //                              yaw: angles_2pi,
     //                              roll: angles_Pi,
     //                              fromEuler: Quat4f.fromEulerAngles_121,
     //                              toEuler: quaternionToEulerAngles_121)
     //
     //  testQuatFromEulerAnglesFunc(name: "131",
     //                              deltaDeg: deltaDeg,
     //                              pitch: angles_Pi,
     //                              yaw: angles_2pi,
     //                              roll: angles_2pi,
     //                              fromEuler: Quat4f.fromEulerAngles_131,
     //                              toEuler: quaternionToEulerAngles_131)
     //
     //  testQuatFromEulerAnglesFunc(name: "212",
     //                              deltaDeg: deltaDeg,
     //                              pitch: angles_2pi,
     //                              yaw: angles_Pi,
     //                              roll: angles_2pi,
     //                              fromEuler: Quat4f.fromEulerAngles_212,
     //                              toEuler: quaternionToEulerAngles_212)
     //
     //  testQuatFromEulerAnglesFunc(name: "232",
     //                              deltaDeg: deltaDeg,
     //                              pitch: angles_Pi,
     //                              yaw: angles_2pi,
     //                              roll: angles_2pi,
     //                              fromEuler: Quat4f.fromEulerAngles_232,
     //                              toEuler: quaternionToEulerAngles_232)
     //
     //  testQuatFromEulerAnglesFunc(name: "313",
     //                              deltaDeg: deltaDeg,
     //                              pitch: angles_2pi,
     //                              yaw: angles_2pi,
     //                              roll: angles_Pi,
     //                              fromEuler: Quat4f.fromEulerAngles_313,
     //                              toEuler: quaternionToEulerAngles_313)
     //
     //  testQuatFromEulerAnglesFunc(name: "323",
     //                              deltaDeg: deltaDeg,
     //                              pitch: angles_2pi,
     //                              yaw: angles_2pi,
     //                              roll: angles_Pi,
     //                              fromEuler: Quat4f.fromEulerAngles_323,
     //                              toEuler: quaternionToEulerAngles_323)
     
     */
}

let debugPrint: Bool = false

struct AngleDeg {
    let from: Float
    let to: Float
    let step: Float
}

@discardableResult
func convertEul2Quat2Eul(name: String,
                         precission: Float,
                         pitch: AngleDeg,
                         yaw: AngleDeg,
                         roll: AngleDeg,
                         fromEuler: (Vec3f) -> Quat4f,
                         toEuler: (Quat4f) -> Vec3f) throws -> Double {
    let pitchesDeg: [Float] = stride(from: pitch.from, to: pitch.to, by: pitch.step).map { $0 }
    let pitchesRad: [Float] = pitchesDeg.map { radians($0) }
    
    let yawsDeg: [Float] = stride(from: yaw.from, to: yaw.to, by: yaw.step).map { $0 }
    let yawsRad: [Float] = yawsDeg.map { radians($0) }
    
    let rollsDeg: [Float] = stride(from: roll.from, to: roll.to, by: roll.step).map { $0 }
    let rollsRad: [Float] = rollsDeg.map { radians($0) }
    
    
    var count: Int = 0
    let total: Int = pitchesDeg.count * yawsDeg.count * rollsDeg.count
    
    for roll in rollsRad {
        for yaw in yawsRad {
            for pitch in pitchesRad {
                let quat = fromEuler(Vec3f(pitch, yaw, roll))
                let eulers = toEuler(quat)
                
                let dPitchDeg = degrees(abs(eulers.x-pitch))
                let dYawDeg   = degrees(abs(eulers.y-yaw))
                let dRollDeg  = degrees(abs(eulers.z-roll))
                
                if dPitchDeg > precission || dYawDeg > precission || dRollDeg > precission {
                    count += 1
                }
            }
        }
    }
    let failureRate = Double(count)/Double(total)
    if debugPrint {
        let result = "\(name) - total:\(total) - failure rate: \(failureRate*100.0)%"
        try result.write(toFile: "euler_result_\(name).txt", atomically: true, encoding: .utf8)
    }
    return failureRate
}
