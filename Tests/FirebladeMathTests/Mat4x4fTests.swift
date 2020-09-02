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
        let values: [Float] = [1, 0, 0, 0,
                               0, 1, 0, 0,
                               0, 0, 1, 0,
                               0, 0, 0, 1]
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

        let values: [Float] = [vec.x, 0, 0, 0,
                               0, vec.y, 0, 0,
                               0, 0, vec.z, 0,
                               0, 0, 0, vec.w]

        let mat = Mat4x4f(diagonal: vec)

        XCTAssertEqual(mat.elements, values)
    }

    func testEquality() {
        XCTAssertTrue(Mat4x4f.identity == Mat4x4f.identity)
        XCTAssertFalse(Mat4x4f(diagonal: [1, 2, 3, 4]) == Mat4x4f.identity)
    }

    func testSubscriptColumnRow() {
        let values: [Float] = rnd(16)

        let mat = Mat4x4f(values)

        XCTAssertEqual(mat[0, 0], values[0])
        XCTAssertEqual(mat[0, 1], values[1])
        XCTAssertEqual(mat[0, 2], values[2])
        XCTAssertEqual(mat[0, 3], values[3])

        XCTAssertEqual(mat[1, 0], values[4])
        XCTAssertEqual(mat[1, 1], values[5])
        XCTAssertEqual(mat[1, 2], values[6])
        XCTAssertEqual(mat[1, 3], values[7])

        XCTAssertEqual(mat[2, 0], values[8])
        XCTAssertEqual(mat[2, 1], values[9])
        XCTAssertEqual(mat[2, 2], values[10])
        XCTAssertEqual(mat[2, 3], values[11])

        XCTAssertEqual(mat[3, 0], values[12])
        XCTAssertEqual(mat[3, 1], values[13])
        XCTAssertEqual(mat[3, 2], values[14])
        XCTAssertEqual(mat[3, 3], values[15])
    }

    func testSubscriptIndex() {
        let values: [Float] = rnd(16)

        let mat = Mat4x4f(values)

        XCTAssertEqual(mat[0], values[0])
        XCTAssertEqual(mat[1], values[1])
        XCTAssertEqual(mat[2], values[2])
        XCTAssertEqual(mat[3], values[3])

        XCTAssertEqual(mat[4], values[4])
        XCTAssertEqual(mat[5], values[5])
        XCTAssertEqual(mat[6], values[6])
        XCTAssertEqual(mat[7], values[7])

        XCTAssertEqual(mat[8], values[8])
        XCTAssertEqual(mat[9], values[9])
        XCTAssertEqual(mat[10], values[10])
        XCTAssertEqual(mat[11], values[11])

        XCTAssertEqual(mat[12], values[12])
        XCTAssertEqual(mat[13], values[13])
        XCTAssertEqual(mat[14], values[14])
        XCTAssertEqual(mat[15], values[15])
    }

    func testTranslationInit() {
        let vec = Vec3f(rnd(3))

        let mat = Mat4x4f(translation: vec)

        let values: [Float] = [
            1.000_000, 0.000_000, 0.000_000, 0.000_000,
            0.000_000, 1.000_000, 0.000_000, 0.000_000,
            0.000_000, 0.000_000, 1.000_000, 0.000_000,
            vec.x, vec.y, vec.z, 1.000_000
        ]

        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    func testScaleInit() {
        let vec = Vec3f(rnd(3))

        let mat = Mat4x4f(scale: vec)

        let values: [Float] = [vec.x, 0, 0, 0,
                               0, vec.y, 0, 0,
                               0, 0, vec.z, 0,
                               0, 0, 0, 1]

        XCTAssertEqual(mat.elements, values)
    }

    func testRotationInitX() {
        let angle: Float = radians(13)
        let axis: Vec3f = .axisX

        let values: [Float] = [
            1.000_000, 0.000_000, 0.000_000, 0.000_000,
            0.000_000, 0.974_370, 0.224_951, 0.000_000,
            0.000_000, -0.224_951, 0.974_370, 0.000_000,
            0.000_000, 0.000_000, 0.000_000, 1.000_000
        ]

        let mat = Mat4x4f(rotation: angle, axis: axis)
        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    func testRotationInitY() {
        let angle: Float = radians(53)
        let axis: Vec3f = .axisY

        let values: [Float] = [
            0.601_815, 0.000_000, -0.798_636, 0.000_000,
            0.000_000, 1.000_000, 0.000_000, 0.000_000,
            0.798_636, 0.000_000, 0.601_815, 0.000_000,
            0.000_000, 0.000_000, 0.000_000, 1.000_000
        ]

        let mat = Mat4x4f(rotation: angle, axis: axis)
        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    func testRotationInitZ() {
        let angle: Float = radians(79)
        let axis: Vec3f = .axisZ

        let values: [Float] = [
            0.190_809, 0.981_627, 0.000_000, 0.000_000,
            -0.981_627, 0.190_809, 0.000_000, 0.000_000,
            0.000_000, 0.000_000, 1.000_000, 0.000_000,
            0.000_000, 0.000_000, 0.000_000, 1.000_000
        ]

        let mat = Mat4x4f(rotation: angle, axis: axis)
        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    func testRotationInitXZ() {
        let angle: Float = radians(33)
        let axis: Vec3f = [1, 0, 1]

        let values: [Float] = [
            0.919_335, 0.385_118, 0.080_665, 0.000_000,
            -0.385_118, 0.838_671, 0.385_118, 0.000_000,
            0.080_665, -0.385_118, 0.919_335, 0.000_000,
            0.000_000, 0.000_000, 0.000_000, 1.000_000
        ]

        let mat = Mat4x4f(rotation: angle, axis: axis)
        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    func testQuaternionInit() {
        let vec: Vec4f = [1.23, 4.56, 7.89, 0.12]

        let values: [Float] = [
            -0.963_882, 0.155_028, 0.216_558, 0.000_000,
            0.110_248, -0.507_928, 0.854_315, 0.000_000,
            0.242_439, 0.847_334, 0.472_491, 0.000_000,
            0.000_000, 0.000_000, 0.000_000, 1.000_000
        ]

        let mat = Mat4x4f(orientation: Quat4f(vec))

        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    func testUpperLeft() {
        let vec0 = Vec3f(rnd(3))
        let vec1 = Vec3f(rnd(3))
        let vec2 = Vec3f(rnd(3))

        let mat3x3exp = Mat3x3f(vec0, vec1, vec2)

        let mat = Mat4x4f(upperLeft: mat3x3exp)

        let mat3x3 = mat.upperLeft

        XCTAssertEqual(mat3x3, mat3x3exp)
    }

    func testTranslateMatrixByVector() {
        let values: [Float] = [
            -0.963_882, 0.155_028, 0.216_558, 0.000_000,
            0.110_248, -0.507_928, 0.854_315, 0.000_000,
            0.242_439, 0.847_334, 0.472_491, 0.000_000,
            24.792_658, 131.820_190, 74.315_155, 1.000_000
        ]

        var mat: Mat4x4f = [
            -0.963_882, 0.155_028, 0.216_558, 0.000_000,
            0.110_248, -0.507_928, 0.854_315, 0.000_000,
            0.242_439, 0.847_334, 0.472_491, 0.000_000,
            4.556_310, 64.323_402, -2.345_630, 1.000_000
        ]

        mat.translate(by: [7.56, 33.44, 98.32])

        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    func testTranslation() {
        var mat: Mat4x4f = .identity

        XCTAssertEqual(mat.translation, [0, 0, 0])

        mat.translation = [1, 2, 3]
        XCTAssertEqual(mat.translation, [1, 2, 3])
    }

    func testScaleMatrixByVector() {
        let values: [Float] = [
            -3.113_339, 0.500_740, 0.699_482, 0.000_000,
            0.059_865, -0.275_805, 0.463_893, 0.000_000,
            -1.090_976, -3.813_003, -2.126_209, -0.000_000,
            4.556_310, 64.323_402, -2.345_630, 1.000_000
        ]

        var mat: Mat4x4f = [
            -0.963_882, 0.155_028, 0.216_558, 0.000_000,
            0.110_248, -0.507_928, 0.854_315, 0.000_000,
            0.242_439, 0.847_334, 0.472_491, 0.000_000,
            4.556_310, 64.323_402, -2.345_630, 1.000_000
        ]

        mat.scale(by: [3.23, 0.543, -4.5])

        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    func testRotateMatrixByAngleAroundAxes() {
        let values: [Float] = [
            -0.076_637, -0.960_875, 0.266_170, 0.000_000,
            0.858_961, 0.071_925, 0.506_965, 0.000_000,
            -0.506_274, 0.267_481, 0.819_841, 0.000_000,
            4.556_310, 64.323_402, -2.345_630, 1.000_000
        ]

        var mat: Mat4x4f = [
            -0.963_882, 0.155_028, 0.216_558, 0.000_000,
            0.110_248, -0.507_928, 0.854_315, 0.000_000,
            0.242_439, 0.847_334, 0.472_491, 0.000_000,
            4.556_310, 64.323_402, -2.345_630, 1.000_000
        ]

        mat.rotate(by: radians(91), axis: [0, 1, 1])

        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    func testLookAt() {
        let eye: Vec3f = [10, 45, -3]
        let center: Vec3f = [4, 6.4, 0.45]
        let up: Vec3f = .axisY

        let values: [Float] = [
            -0.498_471, -0.853_298, 0.153_000, 0.000_000,
            0.000_000, 0.176_490, 0.984_302, 0.000_000,
            -0.866_906, 0.490_646, -0.087_975, 0.000_000,
            2.383_993, 2.062_865, -46.087_540, 1.000_000
        ]

        let mat: Mat4x4f = .look(from: eye, at: center, up: up)

        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    func testPerspective() {
        let values: [Float] = [
            0.697_798, 0.000_000, 0.000_000, 0.000_000,
            0.000_000, 1.116_477, 0.000_000, 0.000_000,
            0.000_000, 0.000_000, -1.000_010, -1.000_000,
            0.000_000, 0.000_000, -0.0010000, 0.000_000
        ]

        let mat: Mat4x4f = .perspectiveRH(fovy: radians(83.7),
                                          aspect: 2880.0 / 1800.0,
                                          zNear: 0.001,
                                          zFar: 100.0)

        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    func testOrthographic() {
        let width: Float = 2880.0
        let height: Float = 1800.0

        let values: [Float] = [
            0.000_694, 0.000_000, 0.000_000, 0.000_000,
            0.000_000, 0.001_111, 0.000_000, 0.000_000,
            0.000_000, 0.000_000, -0.0100001, 0.0,
            -0.000_000, -0.000_000, -1.0000101e-05, 1.000_000
        ]

        let mat = Mat4x4f.orthographicRH(left: -width / 2.0,
                                         right: width / 2.0,
                                         top: height / 2.0,
                                         bottom: -height / 2.0,
                                         zNear: 0.001,
                                         zFar: 100.0)

        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    func testMultiply() {
        let m0 = Mat4x4f(rotation: radians(51), axis: [1, 0, 1])
        let m1 = Mat4x4f(translation: [1, 2, 3])

        let values: [Float] = [
            0.814_660, 0.549_525, 0.185_340, 0.000_000,
            -0.549_525, 0.629_320, 0.549_525, 0.000_000,
            0.185_340, -0.549_525, 0.814_660, 0.000_000,
            0.271_629, 0.159_591, 3.728_371, 1.000_000
        ]

        var mat: Mat4x4f = multiply(m0, m1)
        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)

        mat = m0 * m1
        XCTAssertEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    func testMultiplyVec4f() {
        #if FRB_MATH_USE_SIMD
        let m0 = Mat4x4f(rotation: radians(51), axis: [1, 0, 1])
        let m1 = Mat4x4f(translation: [1, 2, 3])
        let mat00 = m0 * m1

        var mat = multiply(mat00, Vec4f(78.0, 3.02, -32, 0.093))
        XCTAssertEqualElements(mat.elements, [55.978_317, 62.363_155, -9.606_318, 0.093_000], accuracy: 1e-5) // FIXME: would like to have 1e-6

        mat = mat00 * Vec4f(78.0, 3.02, -32, 0.093)
        XCTAssertEqualElements(mat.elements, [55.978_317, 62.363_155, -9.606_318, 0.093_000], accuracy: 1e-5) // FIXME: would like to have 1e-6

        #else
        #warning("MATRIX * VECTOR * SCALAR MULTIPLICATION NOT TESTED")
        #endif
    }

    func testInverse() {
        #if FRB_MATH_USE_SIMD
        let values: [Float] = [
            -0.963_882, 0.110_248, 0.242_439, 0.000_000,
            0.155_028, -0.507_928, 0.847_335, 0.000_000,
            0.216_559, 0.854_316, 0.472_492, -0.000_000,
            -5.072_230, 34.173_248, -54.499_783, 1.000_000
        ]
        let mat: Mat4x4f = [
            -0.963_882, 0.155_028, 0.216_558, 0.000_000,
            0.110_248, -0.507_928, 0.854_315, 0.000_000,
            0.242_439, 0.847_334, 0.472_491, 0.000_000,
            4.556_310, 64.323_402, -2.345_630, 1.000_000
        ]

        let iMat = mat.inverted
        XCTAssertEqualElements(iMat.elements, values, accuracy: 1e-5)
        #else
        #warning("MATRIX INVERSE NOT TESTED")
        #endif
    }
}
