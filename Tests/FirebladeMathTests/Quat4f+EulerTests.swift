//
//  Quat4f+EulerTests.swift
//  FirebladeMathTests
//
//  Created by Christian Treffs on 18.02.21.
//

import FirebladeMath
import Testing

struct Quat4f_EulerTests {
    @Test func quatFromEulerAngles_0_0_0() {
        let pitch: Float = 0
        let yaw: Float = 0
        let roll: Float = 0

        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)

        #expect(abs(quat.x - 0) <= 1e-7)
        #expect(abs(quat.y - 0) <= 1e-7)
        #expect(abs(quat.z - 0) <= 1e-7)
        #expect(abs(quat.w - 1) <= 1e-7)
        #expect(quat.pitch == 0)
        #expect(quat.yaw == 0)
        #expect(quat.roll == 0)
    }

    @Test func quatFromEulerAngles_90_0_0() {
        let pitch: Float = .pi
        let yaw: Float = 0
        let roll: Float = 0

        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)

        #expect(abs(quat.x - 1) <= 1e-7)
        #expect(abs(quat.y - 0) <= 1e-7)
        #expect(abs(quat.z - 0) <= 1e-7)
        #expect(abs(quat.w - 0) <= 1e-7)
        #expect(abs(quat.pitch - Float.pi) <= 1e-7)
        #expect(abs(quat.yaw - 0) <= 1e-7)
        #expect(abs(quat.roll - 0) <= 1e-7)
    }

    @Test func quatFromEulerAngles_n90_0_0() {
        let pitch: Float = -.pi
        let yaw: Float = 0
        let roll: Float = 0

        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)

        #expect(abs(quat.x - (-1)) <= 1e-7)
        #expect(abs(quat.y - 0) <= 1e-7)
        #expect(abs(quat.z - 0) <= 1e-7)
        #expect(abs(quat.w - 0) <= 1e-7)
        #expect(abs(quat.pitch - (-Float.pi)) <= 1e-7)
        #expect(abs(quat.yaw - 0) <= 1e-7)
        #expect(abs(quat.roll - 0) <= 1e-7)
    }

    @Test func quatFromEulerAngles_0_90_0() {
        let pitch: Float = 0
        let yaw: Float = .pi
        let roll: Float = 0

        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)

        #expect(abs(quat.x - 0) <= 1e-7)
        #expect(abs(quat.y - 1) <= 1e-7)
        #expect(abs(quat.z - 0) <= 1e-7)
        #expect(abs(quat.w - 0) <= 1e-7)
        // gimbal lock
        #expect(abs(quat.pitch - .pi) <= 1e-6)
        #expect(abs(quat.yaw - 0) <= 1e-6)
        #expect(abs(quat.roll - .pi) <= 1e-6)
    }

    @Test func quatFromEulerAngles_0_n90_0() {
        let pitch: Float = 0
        let yaw: Float = -.pi
        let roll: Float = 0

        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)

        #expect(abs(quat.x - 0) <= 1e-7)
        #expect(abs(quat.y - (-1)) <= 1e-7)
        #expect(abs(quat.z - 0) <= 1e-7)
        #expect(abs(quat.w - 0) <= 1e-7)
        // gimbal lock
        #expect(abs(quat.pitch - .pi) <= 1e-6)
        #expect(abs(quat.yaw - 0) <= 1e-6)
        #expect(abs(quat.roll - .pi) <= 1e-6)
    }

    @Test func quatFromEulerAngles_0_0_90() {
        let pitch: Float = 0
        let yaw: Float = 0
        let roll: Float = .pi

        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)

        #expect(abs(quat.x - 0) <= 1e-7)
        #expect(abs(quat.y - 0) <= 1e-7)
        #expect(abs(quat.z - 1) <= 1e-7)
        #expect(abs(quat.w - 0) <= 1e-7)
        #expect(quat.pitch == 0)
        #expect(quat.yaw == 0)
        #expect(quat.roll == .pi)
    }

    @Test func quatFromEulerAngles_0_0_n90() {
        let pitch: Float = 0
        let yaw: Float = 0
        let roll: Float = -.pi

        let quat = Quat4f(pitch: pitch, yaw: yaw, roll: roll)

        #expect(abs(quat.x - 0) <= 1e-7)
        #expect(abs(quat.y - 0) <= 1e-7)
        #expect(abs(quat.z - (-1)) <= 1e-7)
        #expect(abs(quat.w - 0) <= 1e-7)
        #expect(quat.pitch == 0)
        #expect(quat.yaw == 0)
        #expect(quat.roll == -.pi)
    }

    @Test func quatFromEulerAngles_pitches_yaw0_roll0() {
        let pitches: [Float] = [-180, -90, -1, 1, 90, 180].map(radians)
        let yaw: Float = radians(0)
        let roll: Float = radians(0)

        let results: [Quat4f] = pitches.map { Quat4f(pitch: $0, yaw: yaw, roll: roll) }

        let expectations: [Quat4f] = [
            .init(-1.0, -0.0, 0.0, -4.371139e-08),
            .init(-0.70710677, 0.0, 0.0, 0.70710677),
            .init(-0.008726535, 0.0, 0.0, 0.9999619),
            .init(0.008726535, 0.0, 0.0, 0.9999619),
            .init(0.70710677, 0.0, 0.0, 0.70710677),
            .init(1.0, 0.0, -0.0, -4.371139e-08),
        ]
        #expect(expectations.count == results.count)

        for (res, exp) in zip(results, expectations) {
            #expect(abs(res.x - exp.x) <= 1e-7)
            #expect(abs(res.y - exp.y) <= 1e-7)
            #expect(abs(res.z - exp.z) <= 1e-7)
            #expect(abs(res.w - exp.w) <= 1e-7)
        }
    }

    @Test func quatFromEulerAngles_pitch0_yaws_roll0() {
        let pitch: Float = radians(0)
        let yaws: [Float] = [-180, -90, -1, 1, 90, 180].map(radians)
        let roll: Float = radians(0)

        let results: [Quat4f] = yaws.map { Quat4f(pitch: pitch, yaw: $0, roll: roll) }

        let expectations: [Quat4f] = [
            .init(0.0, -1.0, 0.0, -4.371139e-08),
            .init(0.0, -0.70710677, 0.0, 0.70710677),
            .init(0.0, -0.008726535, 0.0, 0.9999619),
            .init(0.0, 0.008726535, 0.0, 0.9999619),
            .init(0.0, 0.70710677, 0.0, 0.70710677),
            .init(-0.0, 1.0, -0.0, -4.371139e-08),
        ]
        #expect(expectations.count == results.count)

        for (res, exp) in zip(results, expectations) {
            #expect(abs(res.x - exp.x) <= 1e-7)
            #expect(abs(res.y - exp.y) <= 1e-7)
            #expect(abs(res.z - exp.z) <= 1e-7)
            #expect(abs(res.w - exp.w) <= 1e-7)
        }
    }

    @Test func quatFromEulerAngles_pitch0_yaw0_rolls() {
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
        #expect(expectations.count == results.count)

        for (res, exp) in zip(results, expectations) {
            #expect(abs(res.x - exp.x) <= 1e-7)
            #expect(abs(res.y - exp.y) <= 1e-7)
            #expect(abs(res.z - exp.z) <= 1e-7)
            #expect(abs(res.w - exp.w) <= 1e-7)
        }
    }

    @Test func eulerAnglesFromQuat_0_0_0() {
        let quat = Quat4f.identity
        let eulers = quat.eulerAngles
        #expect(abs(eulers.x - 0) <= 1e-7)
        #expect(abs(eulers.y - 0) <= 1e-7)
        #expect(abs(eulers.z - 0) <= 1e-7)
    }
}