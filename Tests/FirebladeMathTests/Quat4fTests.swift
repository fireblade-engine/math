//
//  Quat4fTests.swift
//
//
//  Created by Christian Treffs on 26.07.19.
//

import FirebladeMath
import Testing

struct Quat4fTests {
    @Test func identity() {
        let quat = Quat4f.identity
        expectEqualElements(quat.elements, [0, 0, 0, 1], accuracy: 1e-7)
    }

    @Test func elementsInit() {
        let vec = Vec4f(rnd(4))
        let quat = Quat4f(vec.x, vec.y, vec.z, vec.w)
        expectEqualElements(quat.elements, vec.elements, accuracy: 1e-6)
    }

    @Test func vectorInit() {
        let vec = Vec4f(rnd(4))
        let quat = Quat4f(vec)
        expectEqualElements(quat.elements, vec.elements, accuracy: 1e-6)
    }

    @Test func arrayInit() {
        let vec = Vec4f(rnd(4))
        let quat = Quat4f([vec.x, vec.y, vec.z, vec.w])
        expectEqualElements(quat.elements, vec.elements, accuracy: 1e-6)
    }

    @Test func arrayLiteralInit() {
        let vec = Vec4f(rnd(4))
        let quat: Quat4f = [vec.x, vec.y, vec.z, vec.w]
        expectEqualElements(quat.elements, vec.elements, accuracy: 1e-6)
    }

    @Test func fromToInit() {
        let quat = Quat4f(from: [1, 2, 3], to: [4, 5, 6])
        let values: [Float] = [
            -0.240_965_78,
            0.481_931_63,
            -0.240_965_96,
            3.694_809
        ]
        expectEqualElements(quat.elements, values, accuracy: 1e-6)
    }

    @Test func angleAxisX() {
        let angle: Float = radians(33)
        let quat = Quat4f(angle: angle, axis: .axisX)
        expectEqualElements(quat.elements, [0.284_015, 0.000_000, 0.000_000, 0.958_820], accuracy: 1e-6)
    }

    @Test func angleAxisY() {
        let angle: Float = radians(51)
        let quat = Quat4f(angle: angle, axis: .axisY)
        expectEqualElements(quat.elements, [0.000_000, 0.430_511, 0.000_000, 0.902_585], accuracy: 1e-6)
    }

    @Test func angleAxisZ() {
        let angle: Float = radians(79)
        let quat = Quat4f(angle: angle, axis: .axisZ)
        expectEqualElements(quat.elements, [0.000_000, 0.000_000, 0.636_078, 0.771_625], accuracy: 1e-6)
    }

    @Test func angleAxisXY() {
        let angle: Float = radians(123)
        let quat = Quat4f(angle: angle, axis: [1, 1, 0])
        expectEqualElements(quat.elements, [0.878_817, 0.878_817, 0.000_000, 0.477_159], accuracy: 1e-6)
    }

    @Test func equality() {
        let q0 = Quat4f(1, 2, 3, 4)
        let q1 = Quat4f(4, 3, 2, 1)

        #expect(q0 == q0)
        #expect(q1 == q1)
        #expect(q0 != q1)
        #expect(q1 != q0)
    }

    @Test func isNaN() {
        let qNaN1 = Quat4f(.nan, 1.0, 2.0, 3.0)
        let qNaN2 = Quat4f(0, .nan, 2.0, 3.0)
        let qNaN3 = Quat4f(0, 1.0, .nan, 3.0)
        let qNaN4 = Quat4f(0, 2.0, 3.0, .nan)
        let noNaN = Quat4f(1, 2, 3, 4)

        #expect(qNaN1.isNaN)
        #expect(qNaN2.isNaN)
        #expect(qNaN3.isNaN)
        #expect(qNaN4.isNaN)

        #expect(!noNaN.isNaN)
    }

    @Test func length() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        #expect(abs(quat.length - 9.196_357_7) <= 1e-6)
    }

    @Test func axis() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        expectEqualElements(quat.axis.elements, [0.133_760, 0.495_891, 0.858_021], accuracy: 1e-6)
    }

    @Test func angle() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        #expect(abs(quat.angle - 3.115_49) <= 1e-5)
    }

    @Test func inverse() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        let qInv = quat.inverse
        expectEqualElements(qInv.elements, [-0.014_544, -0.053_918, -0.093_292, 0.001_419], accuracy: 1e-6)
    }

    @Test func conjugate() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        let qConj = quat.conjugate
        expectEqualElements(qConj.elements, [-1.230_000, -4.560_000, -7.890_000, 0.120_000], accuracy: 1e-6)
    }

    @Test func normalize() {
        let quat = Quat4f(1.23, 4.56, 7.89, 0.12)
        let qNorm = quat.normalized
        expectEqualElements(qNorm.elements, [0.133_749, 0.495_848, 0.857_948, 0.013_049], accuracy: 1e-6)
    }

    @Test func multiplyQuaternions() {
        let q0 = Quat4f(1, 2, 3, 4)
        let q1 = Quat4f(4, 3, 2, 1)
        var quat = multiply(q0, q1)
        expectEqualElements(quat.elements, [12.000_000, 24.000_000, 6.000_000, -12.000_000], accuracy: 1e-6)

        quat = q0 * q1
        expectEqualElements(quat.elements, [12.000_000, 24.000_000, 6.000_000, -12.000_000], accuracy: 1e-6)
    }

    @Test func addQuaternions() {
        let q0 = Quat4f(1, 2, 3, 4)
        let q1 = Quat4f(4, 3, 2, 1)
        var quat = FirebladeMath.add(q0, q1)
        expectEqualElements(quat.elements, [5.000_000, 5.000_000, 5.000_000, 5.000_000], accuracy: 1e-6)

        quat = q0 + q1
        expectEqualElements(quat.elements, [5.000_000, 5.000_000, 5.000_000, 5.000_000], accuracy: 1e-6)
    }

    @Test func subtractQuaternions() {
        let q0 = Quat4f(1, 2, 3, 4)
        let q1 = Quat4f(4, 3, 2, 1)
        var quat = subtract(q0, q1)
        expectEqualElements(quat.elements, [-3.000_000, -1.000_000, 1.000_000, 3.000_000], accuracy: 1e-6)

        quat = q0 - q1
        expectEqualElements(quat.elements, [-3.000_000, -1.000_000, 1.000_000, 3.000_000], accuracy: 1e-6)
    }

    @Test func act() {
        let q = Quat4f(1, 2, 3, 4)
        let v = Vec3f(5, 6, 7)
        let vec: Vec3f = FirebladeMath.act(q, v)
        expectEqualElements(vec.elements, [1.800_000, 7.600_000, 7.000_000], accuracy: 1e-6)
    }

    @Test func rotMat3x3() {
        let angle: Float = radians(33)
        let rotMat = Mat3x3f(rotation: angle, axis: [1, 0, 1])
        let quat = Quat4f(rotation: rotMat)
        expectEqualElements(quat.elements, [0.200_829, 0.000_000, 0.200_829, 0.958_820], accuracy: 1e-6)
    }

    @Test func rotMat4x4() {
        let angle: Float = radians(33)
        let rotMat = Mat4x4f(rotation: angle, axis: [1, 0, 1])
        let quat = Quat4f(rotation: rotMat)
        expectEqualElements(quat.elements, [0.200_829, 0.000_000, 0.200_829, 0.958_820], accuracy: 1e-6)
    }
    
    @Test func rotationAngle() {
        let q = Quat4f(angle: .pi / 2, axis: [0, 1, 0])
        #expect(abs(q.rotationAngle - .pi / 2) < 1e-6)
        
        let q2 = Quat4f(0, 0, 0, 1)
        #expect(q2.rotationAngle == 0)
    }

    @Test func sequence() {
        let q = Quat4f(1, 2, 3, 4)
        #expect(Array(q) == [1, 2, 3, 4])
        #expect(q.elements == [1, 2, 3, 4])
    }

    @Test func setters() {
        var q = Quat4f.identity
        q.x = 1
        q.y = 2
        q.z = 3
        q.w = 4
        #expect(q.x == 1)
        #expect(q.y == 2)
        #expect(q.z == 3)
        #expect(q.w == 4)
    }

    @Test func eulerAngles() {
        let q = Quat4f(pitch: 0.1, yaw: 0.2, roll: 0.3)
        #expect(abs(q.pitch - 0.1) < 1e-5)
        #expect(abs(q.yaw - 0.2) < 1e-5)
        #expect(abs(q.roll - 0.3) < 1e-5)
    }
}

private func expectEqualElements<T, S>(_ expression1: @autoclosure () throws -> S,
                                       _ expression2: @autoclosure () throws -> S,
                                       accuracy: T,
                                       _ message: @autoclosure () -> String = "",
                                       sourceLocation: SourceLocation = #_sourceLocation) where T: FloatingPoint, S: Sequence, S.Element == T {
    do {
        let s1 = try expression1()
        let s2 = try expression2()
        for (index, elements) in zip(s1, s2).enumerated() {
            let diff = abs(elements.0 - elements.1)
            let comment = Comment(stringLiteral: "[element:\(index + 1)] \(elements.0) is not equal to \(elements.1) +/- \(accuracy) " + message())
            #expect(diff <= accuracy, comment, sourceLocation: sourceLocation)
        }
    } catch {
        Issue.record(error, Comment(stringLiteral: "Error thrown during element comparison"), sourceLocation: sourceLocation)
    }
}