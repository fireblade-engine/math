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
        XCTAssertEqualElements(quat.elements, [0, 0, 0, 1], accuracy: 1e-7)
    }

    func testElementsInit() {
        let vec = Vec4f(rnd(4))
        let quat = Quat4f(vec.x, vec.y, vec.z, vec.w)
        XCTAssertEqualElements(quat.elements, vec.elements, accuracy: 1e-6)
    }

    func testVectorInit() {
        let vec = Vec4f(rnd(4))
        let quat = Quat4f(vec)
        XCTAssertEqualElements(quat.elements, vec.elements, accuracy: 1e-6)
    }

    func testArrayInit() {
        let vec = Vec4f(rnd(4))
        let quat = Quat4f([vec.x, vec.y, vec.z, vec.w])
        XCTAssertEqualElements(quat.elements, vec.elements, accuracy: 1e-6)
    }

    func testArrayLiteralInit() {
        let vec = Vec4f(rnd(4))
        let quat: Quat4f = [vec.x, vec.y, vec.z, vec.w]
        XCTAssertEqualElements(quat.elements, vec.elements, accuracy: 1e-6)
    }

    func testFromToInit() {
        let quat = Quat4f(from: [1, 2, 3], to: [4, 5, 6])
        let values: [Float] = [
            -0.240_965_78,
            0.481_931_63,
            -0.240_965_96,
            3.694_809
        ]
        XCTAssertEqualElements(quat.elements, values, accuracy: 1e-6)
    }

    func testAngleAxisX() {
        let angle: Float = radians(33)
        let quat = Quat4f(angle: angle, axis: .axisX)
        XCTAssertEqualElements(quat.elements, [0.284_015, 0.000_000, 0.000_000, 0.958_820], accuracy: 1e-6)
    }

    func testAngleAxisY() {
        let angle: Float = radians(51)
        let quat = Quat4f(angle: angle, axis: .axisY)
        XCTAssertEqualElements(quat.elements, [0.000_000, 0.430_511, 0.000_000, 0.902_585], accuracy: 1e-6)
    }

    func testAngleAxisZ() {
        let angle: Float = radians(79)
        let quat = Quat4f(angle: angle, axis: .axisZ)
        XCTAssertEqualElements(quat.elements, [0.000_000, 0.000_000, 0.636_078, 0.771_625], accuracy: 1e-6)
    }

    func testAngleAxisXY() {
        let angle: Float = radians(123)
        let quat = Quat4f(angle: angle, axis: [1, 1, 0])
        XCTAssertEqualElements(quat.elements, [0.878_817, 0.878_817, 0.000_000, 0.477_159], accuracy: 1e-6)
    }

    func testEquality() {
        let q0 = Quat4f(1, 2, 3, 4)
        let q1 = Quat4f(4, 3, 2, 1)

        XCTAssertTrue(q0 == q0)
        XCTAssertTrue(q1 == q1)
        XCTAssertFalse(q0 == q1)
        XCTAssertFalse(q1 == q0)
    }

    func testIsNaN() {
        let qNaN1 = Quat4f(.nan, 1.0, 2.0, 3.0)
        let qNaN2 = Quat4f(0, .nan, 2.0, 3.0)
        let qNaN3 = Quat4f(0, 1.0, .nan, 3.0)
        let qNaN4 = Quat4f(0, 2.0, 3.0, .nan)
        let noNaN = Quat4f(1, 2, 3, 4)

        XCTAssertTrue(qNaN1.isNaN)
        XCTAssertTrue(qNaN2.isNaN)
        XCTAssertTrue(qNaN3.isNaN)
        XCTAssertTrue(qNaN4.isNaN)

        XCTAssertFalse(noNaN.isNaN)
    }

    func testLength() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        XCTAssertEqual(quat.length, 9.196_357_7, accuracy: 1e-6)
    }

    func testAxis() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        XCTAssertEqualElements(quat.axis.elements, [0.133_760, 0.495_891, 0.858_021], accuracy: 1e-6)
    }

    func testAngle() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        XCTAssertEqual(quat.angle, 3.115_49, accuracy: 1e-5)
    }

    func testInverse() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        let qInv = quat.inverse
        XCTAssertEqualElements(qInv.elements, [-0.014_544, -0.053_918, -0.093_292, 0.001_419], accuracy: 1e-6)
    }

    func testConjugate() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        let qConj = quat.conjugate
        XCTAssertEqualElements(qConj.elements, [-1.230_000, -4.560_000, -7.890_000, 0.120_000], accuracy: 1e-6)
    }

    func testNormalize() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        let qNorm = quat.normalized
        XCTAssertEqualElements(qNorm.elements, [0.133_749, 0.495_848, 0.857_948, 0.013_049], accuracy: 1e-6)
    }

    func testMultipy() {
        let q0 = Quat4f(1, 2, 3, 4)
        let q1 = Quat4f(4, 3, 2, 1)
        var quat = multiply(q0, q1)
        XCTAssertEqualElements(quat.elements, [12.000_000, 24.000_000, 6.000_000, -12.000_000], accuracy: 1e-6)

        quat = q0 * q1
        XCTAssertEqualElements(quat.elements, [12.000_000, 24.000_000, 6.000_000, -12.000_000], accuracy: 1e-6)
    }

    func testAdd() {
        let q0 = Quat4f(1, 2, 3, 4)
        let q1 = Quat4f(4, 3, 2, 1)
        var quat = FirebladeMath.add(q0, q1)
        XCTAssertEqualElements(quat.elements, [5.000_000, 5.000_000, 5.000_000, 5.000_000], accuracy: 1e-6)

        quat = q0 + q1
        XCTAssertEqualElements(quat.elements, [5.000_000, 5.000_000, 5.000_000, 5.000_000], accuracy: 1e-6)
    }

    func testSubtract() {
        let q0 = Quat4f(1, 2, 3, 4)
        let q1 = Quat4f(4, 3, 2, 1)
        var quat = subtract(q0, q1)
        XCTAssertEqualElements(quat.elements, [-3.000_000, -1.000_000, 1.000_000, 3.000_000], accuracy: 1e-6)

        quat = q0 - q1
        XCTAssertEqualElements(quat.elements, [-3.000_000, -1.000_000, 1.000_000, 3.000_000], accuracy: 1e-6)
    }

    func testAct() {
        let q = Quat4f(1, 2, 3, 4)
        let v = Vec3f(5, 6, 7)
        let vec: Vec3f = act(q, v)
        XCTAssertEqualElements(vec.elements, [1.800_000, 7.600_000, 7.000_000], accuracy: 1e-6)
    }

    func testRotMat3x3() {
        let angle: Float = radians(33)
        let rotMat = Mat3x3f(rotation: angle, axis: [1, 0, 1])
        let quat = Quat4f(rotation: rotMat)
        XCTAssertEqualElements(quat.elements, [0.200_829, 0.000_000, 0.200_829, 0.958_820], accuracy: 1e-6)
    }

    func testRotMat4x4() {
        let angle: Float = radians(33)
        let rotMat = Mat4x4f(rotation: angle, axis: [1, 0, 1])
        let quat = Quat4f(rotation: rotMat)
        XCTAssertEqualElements(quat.elements, [0.200_829, 0.000_000, 0.200_829, 0.958_820], accuracy: 1e-6)
    }
}
