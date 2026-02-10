//
//  Mat4x4fTests.swift
//
//
//  Created by Christian Treffs on 21.07.19.
//

import FirebladeMath
import Testing

struct Mat4x4fTests {
    @Test func identity() {
        let identity: Mat4x4f = .identity
        let values: [Float] = [1, 0, 0, 0,
                               0, 1, 0, 0,
                               0, 0, 1, 0,
                               0, 0, 0, 1]
        #expect(identity.elements == values)
    }

    @Test func initArrayValues() {
        let values: [Float] = rnd(16)
        let mat = Mat4x4f(values)
        #expect(mat.elements == values)
    }

    @Test func initVectorColumns() {
        let values: [Float] = rnd(16)

        let a = Vec4f(values[0...3])
        let b = Vec4f(values[4...7])
        let c = Vec4f(values[8...11])
        let d = Vec4f(values[12...15])

        let mat = Mat4x4f(a, b, c, d)

        #expect(mat.elements == values)
    }

    @Test func initDiagonal() {
        let vec = Vec4f(rnd(4))

        let values: [Float] = [vec.x, 0, 0, 0,
                               0, vec.y, 0, 0,
                               0, 0, vec.z, 0,
                               0, 0, 0, vec.w]

        let mat = Mat4x4f(diagonal: vec)

        #expect(mat.elements == values)
    }

    @Test func equality() {
        #expect(Mat4x4f.identity == Mat4x4f.identity)
        #expect(Mat4x4f(diagonal: [1, 2, 3, 4]) != Mat4x4f.identity)
    }

    @Test func subscriptColumnRow() {
        let values: [Float] = rnd(16)

        let mat = Mat4x4f(values)

        #expect(mat[0, 0] == values[0])
        #expect(mat[0, 1] == values[1])
        #expect(mat[0, 2] == values[2])
        #expect(mat[0, 3] == values[3])

        #expect(mat[1, 0] == values[4])
        #expect(mat[1, 1] == values[5])
        #expect(mat[1, 2] == values[6])
        #expect(mat[1, 3] == values[7])

        #expect(mat[2, 0] == values[8])
        #expect(mat[2, 1] == values[9])
        #expect(mat[2, 2] == values[10])
        #expect(mat[2, 3] == values[11])

        #expect(mat[3, 0] == values[12])
        #expect(mat[3, 1] == values[13])
        #expect(mat[3, 2] == values[14])
        #expect(mat[3, 3] == values[15])
    }

    @Test func subscriptIndex() {
        let values: [Float] = rnd(16)

        let mat = Mat4x4f(values)

        #expect(mat[0] == values[0])
        #expect(mat[1] == values[1])
        #expect(mat[2] == values[2])
        #expect(mat[3] == values[3])

        #expect(mat[4] == values[4])
        #expect(mat[5] == values[5])
        #expect(mat[6] == values[6])
        #expect(mat[7] == values[7])

        #expect(mat[8] == values[8])
        #expect(mat[9] == values[9])
        #expect(mat[10] == values[10])
        #expect(mat[11] == values[11])

        #expect(mat[12] == values[12])
        #expect(mat[13] == values[13])
        #expect(mat[14] == values[14])
        #expect(mat[15] == values[15])
    }

    @Test func translationInit() {
        let vec = Vec3f(rnd(3))

        let mat = Mat4x4f(translation: vec)

        let values: [Float] = [
            1.000_000, 0.000_000, 0.000_000, 0.000_000,
            0.000_000, 1.000_000, 0.000_000, 0.000_000,
            0.000_000, 0.000_000, 1.000_000, 0.000_000,
            vec.x, vec.y, vec.z, 1.000_000
        ]

        expectEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    @Test func scaleInit() {
        let vec = Vec3f(rnd(3))

        let mat = Mat4x4f(scale: vec)

        let values: [Float] = [vec.x, 0, 0, 0,
                               0, vec.y, 0, 0,
                               0, 0, vec.z, 0,
                               0, 0, 0, 1]

        #expect(mat.elements == values)
    }

    @Test func rotationInitX() {
        let angle: Float = radians(13)
        let axis: Vec3f = .axisX

        let values: [Float] = [
            1.000_000, 0.000_000, 0.000_000, 0.000_000,
            0.000_000, 0.974_370, 0.224_951, 0.000_000,
            0.000_000, -0.224_951, 0.974_370, 0.000_000,
            0.000_000, 0.000_000, 0.000_000, 1.000_000
        ]

        let mat = Mat4x4f(rotation: angle, axis: axis)
        expectEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    @Test func rotationInitY() {
        let angle: Float = radians(53)
        let axis: Vec3f = .axisY

        let values: [Float] = [
            0.601_815, 0.000_000, -0.798_636, 0.000_000,
            0.000_000, 1.000_000, 0.000_000, 0.000_000,
            0.798_636, 0.000_000, 0.601_815, 0.000_000,
            0.000_000, 0.000_000, 0.000_000, 1.000_000
        ]

        let mat = Mat4x4f(rotation: angle, axis: axis)
        expectEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    @Test func rotationInitZ() {
        let angle: Float = radians(79)
        let axis: Vec3f = .axisZ

        let values: [Float] = [
            0.190_809, 0.981_627, 0.000_000, 0.000_000,
            -0.981_627, 0.190_809, 0.000_000, 0.000_000,
            0.000_000, 0.000_000, 1.000_000, 0.000_000,
            0.000_000, 0.000_000, 0.000_000, 1.000_000
        ]

        let mat = Mat4x4f(rotation: angle, axis: axis)
        expectEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    @Test func rotationInitXZ() {
        let angle: Float = radians(33)
        let axis: Vec3f = [1, 0, 1]

        let values: [Float] = [
            0.919_335, 0.385_118, 0.080_665, 0.000_000,
            -0.385_118, 0.838_671, 0.385_118, 0.000_000,
            0.080_665, -0.385_118, 0.919_335, 0.000_000,
            0.000_000, 0.000_000, 0.000_000, 1.000_000
        ]

        let mat = Mat4x4f(rotation: angle, axis: axis)
        expectEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    @Test func quaternionInit() {
        let vec: Vec4f = [1.23, 4.56, 7.89, 0.12]

        let values: [Float] = [
            -0.963_882, 0.155_028, 0.216_558, 0.000_000,
            0.110_248, -0.507_928, 0.854_315, 0.000_000,
            0.242_439, 0.847_334, 0.472_491, 0.000_000,
            0.000_000, 0.000_000, 0.000_000, 1.000_000
        ]

        let mat = Mat4x4f(orientation: Quat4f(vec))

        expectEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    @Test func upperLeft() {
        let vec0 = Vec3f(rnd(3))
        let vec1 = Vec3f(rnd(3))
        let vec2 = Vec3f(rnd(3))

        let mat3x3exp = Mat3x3f(vec0, vec1, vec2)

        let mat = Mat4x4f(upperLeft: mat3x3exp)

        let mat3x3 = mat.upperLeft

        #expect(mat3x3 == mat3x3exp)
    }

    @Test func translateMatrixByVector() {
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

        expectEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    @Test func translation() {
        var mat: Mat4x4f = .identity

        #expect(mat.translation == [0, 0, 0])

        mat.translation = [1, 2, 3]
        #expect(mat.translation == [1, 2, 3])
    }

    @Test func scaleMatrixByVector() {
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

        expectEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    @Test func rotateMatrixByAngleAroundAxes() {
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

        expectEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    @Test func lookAt() {
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

        expectEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    @Test func perspective() {
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

        expectEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    @Test func orthographic() {
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

        expectEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    @Test func multiplyMatrices() {
        let m0 = Mat4x4f(rotation: radians(51), axis: [1, 0, 1])
        let m1 = Mat4x4f(translation: [1, 2, 3])

        let values: [Float] = [
            0.814_660, 0.549_525, 0.185_340, 0.000_000,
            -0.549_525, 0.629_320, 0.549_525, 0.000_000,
            0.185_340, -0.549_525, 0.814_660, 0.000_000,
            0.271_629, 0.159_591, 3.728_371, 1.000_000
        ]

        var mat: Mat4x4f = multiply(m0, m1)
        expectEqualElements(mat.elements, values, accuracy: 1e-6)

        mat = m0 * m1
        expectEqualElements(mat.elements, values, accuracy: 1e-6)
    }

    @Test func multiplyVec4f() {
        let m0 = Mat4x4f(rotation: radians(51), axis: [1, 0, 1])
        let m1 = Mat4x4f(translation: [1, 2, 3])
        let mat00 = m0 * m1

        var mat = multiply(mat00, Vec4f(78.0, 3.02, -32, 1.0))
        expectEqualElements(mat.elements, [56.224686, 62.507904, -6.2246857, 1.0], accuracy: 1e-5)

        mat = mat00 * Vec4f(78.0, 3.02, -32, 1.0)
        expectEqualElements(mat.elements, [56.224686, 62.507904, -6.2246857, 1.0], accuracy: 1e-5)
    }

    @Test func inverse() {
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
        expectEqualElements(iMat.elements, values, accuracy: 1e-5)
    }

    @Test func transformations() {
        let mat = Mat4x4f(translation: [1, 2, 3], scale: [2, 2, 2])
        
        let p = Vec3f(1, 1, 1)
        let tp = mat.transformPoint(p)
        #expect(tp == [3, 4, 5]) // (1,1,1) * 2 + (1,2,3)
        
        let d = Vec3f(1, 1, 1)
        let td = mat.transformDirection(d)
        #expect(td == [2, 2, 2]) // (1,1,1) * 2
    }
    
    @Test func orientationProperties() {
        var mat = Mat4x4f.identity
        mat.right = [1, 2, 3]
        mat.up = [4, 5, 6]
        mat.forward = [7, 8, 9]
        
        #expect(mat.right == [1, 2, 3])
        #expect(mat.up == [4, 5, 6])
        #expect(mat.forward == [7, 8, 9])
    }
    
    @Test func eulerAngles() {
        let mat = Mat4x4f(rotation: 0.5, axis: [1, 0, 0])
        #expect(abs(mat.eulerAnglesXYZ.x - (-0.5)) < 1e-6)
    }
    
    @Test func rotationProperty() {
        let q = Quat4f(angle: .pi / 2, axis: [0, 1, 0])
        let mat = Mat4x4f(rotation: .pi / 2, axis: [0, 1, 0])
        let rot = mat.rotation
        #expect(abs(rot.y - q.y) < 1e-6)
    }
    
    @Test func staticInitializers() {
        let t = Mat4x4f.translation(x: 1, y: 2, z: 3)
        #expect(t.translation == [1, 2, 3])
        
        let s = Mat4x4f.scaling(x: 2, y: 3, z: 4)
        #expect(s.scale == [2, 3, 4])
        
        let r = Mat4x4f.rotation(angle: 0.5, axis: [1, 0, 0])
        #expect(abs(r.eulerAnglesXYZ.x - (-0.5)) < 1e-6)
    }
    
    @Test func pitchYawRoll() {
        var mat = Mat4x4f.identity
        mat.pitch(by: 0.1)
        mat.yaw(by: 0.2)
        mat.roll(by: 0.3)
        // Just verify it doesn't crash and changes the matrix
        #expect(mat != .identity)
    }

    @Test func collectionConformance() {
        let mat = Mat4x4f.identity
        #expect(mat.startIndex == 0)
        #expect(mat.endIndex == 16)
        #expect(mat.index(after: 0) == 1)
        #expect(mat.index(before: 1) == 0)
        #expect(mat.count == 16)
    }

    @Test func matrixForcedContiguousStorage () throws {
        let mat = Mat4x4f(diagonal: Vec4f(1, 2, 3, 4))

        try mat.withForcedContiguousStorage { buffer in
            #expect(buffer.baseAddress != nil)
            #expect(buffer[0] == 1)
            #expect(buffer[5] == 2)
            #expect(buffer[10] == 3)
            #expect(buffer[15] == 4)
        }

        #expect(mat[0] == 1)
        #expect(mat[5] == 2)
        #expect(mat[10] == 3)
        #expect(mat[15] == 4)

        var mutableMat: Mat4x4f = Mat4x4f(diagonal: Vec4f(1, 2, 3, 4))
        try mutableMat.withForcedContiguousMutableStorage { buffer in
            #expect(buffer.baseAddress != nil)
            #expect(buffer[0] == 1)
            buffer[0] = 123
            #expect(buffer[5] == 2)
            buffer[5] = 456
            #expect(buffer[10] == 3)
            buffer[10] = 789
            #expect(buffer[15] == 4)
            buffer[15] = 012
        }

        #expect(mutableMat[0] == 123)
        #expect(mutableMat[5] == 456)
        #expect(mutableMat[10] == 789)
        #expect(mutableMat[15] == 012)
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