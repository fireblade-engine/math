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

    func testTranslationInit() {
        let vec = Vec3f(rnd(3))

        let mat = Mat4x4f(translation: vec)

        let values: [Float] = [
            1.000_000, 0.000_000, 0.000_000, 0.000_000,
            0.000_000, 1.000_000, 0.000_000, 0.000_000,
            0.000_000, 0.000_000, 1.000_000, 0.000_000,
            vec.x, vec.y, vec.z, 1.000_000
        ]

        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
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
        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
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
        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
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
        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
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
        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
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

        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
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

        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
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

        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
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

        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
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

        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
    }

    func testPerspective() {
        let values: [Float] = [
            0.697_798, 0.000_000, 0.000_000, 0.000_000,
            0.000_000, 1.116_477, 0.000_000, 0.000_000,
            0.000_000, 0.000_000, -1.000_020, -1.000_000,
            0.000_000, 0.000_000, -0.002_000, 0.000_000
        ]

        let mat: Mat4x4f = .perspective(fovy: radians(83.7),
                                        width: 2880.0,
                                        height: 1800.0,
                                        zNear: 0.001,
                                        zFar: 100.0)

        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
    }

    func testOrthographic() {
        let width: Float = 2880.0
        let height: Float = 1800.0

        let values: [Float] = [
            0.000_694, 0.000_000, 0.000_000, 0.000_000,
            0.000_000, 0.001_111, 0.000_000, 0.000_000,
            0.000_000, 0.000_000, -0.020_000, 0.000_000,
            -0.000_000, -0.000_000, -1.000_020, 1.000_000
        ]

        let mat: Mat4x4f = .orthographic(left: -width / 2.0,
                                         right: width / 2.0,
                                         bottom: -height / 2.0,
                                         top: height / 2.0,
                                         zNear: 0.001,
                                         zFar: 100.0)

        XCTAssertEqualArray(mat.elements, values, accuracy: 1e-6)
    }
}
