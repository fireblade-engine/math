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
import func XCTest.XCTAssertTrue
import func XCTest.XCTAssertFalse

class Quat4fTests: XCTestCase {
    func testIdentity() {
        let quat = Quat4f.identity
        XCTAssertEqualArray(quat.elements, [0, 0, 0, 1], accuracy: 1e-7)
    }

    func testElementsInit() {
        let vec = Vec4f(rnd(4))
        let quat = Quat4f(vec.x, vec.y, vec.z, vec.w)
        XCTAssertEqualArray(quat.elements, [vec.x, vec.y, vec.z, vec.w], accuracy: 1e-6)
    }

    func testVectorInit() {
        let vec = Vec4f(rnd(4))
        let quat = Quat4f(vec)
        XCTAssertEqualArray(quat.elements, [vec.x, vec.y, vec.z, vec.w], accuracy: 1e-6)
    }

    func testArrayInit() {
        let vec = Vec4f(rnd(4))
        let quat = Quat4f([vec.x, vec.y, vec.z, vec.w])
        XCTAssertEqualArray(quat.elements, [vec.x, vec.y, vec.z, vec.w], accuracy: 1e-6)
    }

    func testArrayLiteralInit() {
        let vec = Vec4f(rnd(4))
        let quat: Quat4f = [vec.x, vec.y, vec.z, vec.w]
        XCTAssertEqualArray(quat.elements, [vec.x, vec.y, vec.z, vec.w], accuracy: 1e-6)
    }

    func testEquality() {
        let q0 = Quat4f(1, 2, 3, 4)
        let q1 = Quat4f(4, 3, 2, 1)

        XCTAssertTrue(q0 == q0)
        XCTAssertTrue(q1 == q1)
        XCTAssertFalse(q0 == q1)
        XCTAssertFalse(q1 == q0)
    }

    func testLength() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        XCTAssertEqual(quat.length, 9.196_357_7, accuracy: 1e-6)
    }

    func testAxis() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        XCTAssertEqualArray(quat.axis.elements, [0.133_760, 0.495_891, 0.858_021], accuracy: 1e-6)
    }

    func testAngle() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        XCTAssertEqual(quat.angle, 2.901_012_9, accuracy: 1e-6)
    }

    func testInverse() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        let qInv = quat.inverse
        XCTAssertEqualArray(qInv.elements, [-0.014_544, -0.053_918, -0.093_292, 0.001_419], accuracy: 1e-6)
    }

    func testConjugate() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        let qConj = quat.conjugate
        XCTAssertEqualArray(qConj.elements, [-1.230_000, -4.560_000, -7.890_000, 0.120_000], accuracy: 1e-6)
    }

    func testNormalize() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        let qNorm = quat.normalized
        XCTAssertEqualArray(qNorm.elements, [0.133_749, 0.495_848, 0.857_948, 0.013_049], accuracy: 1e-6)
    }
    /*
     func testQuatBasicProperties() {
     let qf = Quat4f(0, 1, 2, 3)
     let qd = Quat4d(0, 1, 2, 3)

     }

     func testExpressibleByArrayLiteral() {
     XCTAssertNotNil(Quat4f(arrayLiteral: 1, 2, 3, 4))
     XCTAssertNotNil(Quat4d(arrayLiteral: 1, 2, 3, 4))
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
     */
}
