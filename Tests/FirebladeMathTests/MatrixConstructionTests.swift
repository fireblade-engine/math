//
//  MatrixConstructionTests.swift
//  FirebladeMathTests
//

// Every way of constructing a matrix must produce the same column-major layout,
// and iterating matrices, quaternions and vectors must yield their scalars in order.

import FirebladeMath
import Testing

struct MatrixConstructionTests {
    @Test func mat2x2fConstructionPathsAgree() {
        let values: [Float] = [1, 2, 3, 4]
        let c0 = Vec2f(1, 2), c1 = Vec2f(3, 4)
        let byColumns = Mat2x2f(c0, c1)

        #expect(Mat2x2f([c0, c1]) == byColumns)
        #expect(Mat2x2f(values) == byColumns)
        #expect([1, 2, 3, 4] as Mat2x2f == byColumns)
        #expect(byColumns.columns.0 == c0)
        #expect(byColumns.columns.1 == c1)
        #expect(byColumns.elements == values)
        #expect(Array(byColumns) == values)
        #expect(byColumns[1, 0] == 3)
    }

    @Test func mat2x2dConstructionPathsAgree() {
        let values: [Double] = [1, 2, 3, 4]
        let c0 = Vec2d(1, 2), c1 = Vec2d(3, 4)
        let byColumns = Mat2x2d(c0, c1)

        #expect(Mat2x2d([c0, c1]) == byColumns)
        #expect(Mat2x2d(values) == byColumns)
        #expect([1, 2, 3, 4] as Mat2x2d == byColumns)
        #expect(byColumns.elements == values)
        #expect(Array(byColumns) == values)
    }

    @Test func mat3x3fConstructionPathsAgree() {
        let values: [Float] = (1...9).map(Float.init)
        let c0 = Vec3f(1, 2, 3), c1 = Vec3f(4, 5, 6), c2 = Vec3f(7, 8, 9)
        let byColumns = Mat3x3f(c0, c1, c2)

        #expect(Mat3x3f([c0, c1, c2]) == byColumns)
        #expect(Mat3x3f(values) == byColumns)
        #expect([1, 2, 3, 4, 5, 6, 7, 8, 9] as Mat3x3f == byColumns)
        #expect(byColumns.columns.0 == c0)
        #expect(byColumns.columns.1 == c1)
        #expect(byColumns.columns.2 == c2)
        #expect(byColumns.elements == values)
        #expect(Array(byColumns) == values)
        #expect(byColumns[2, 1] == 8)
    }

    @Test func mat3x3dConstructionPathsAgree() {
        let values: [Double] = (1...9).map(Double.init)
        let c0 = Vec3d(1, 2, 3), c1 = Vec3d(4, 5, 6), c2 = Vec3d(7, 8, 9)
        let byColumns = Mat3x3d(c0, c1, c2)

        #expect(Mat3x3d([c0, c1, c2]) == byColumns)
        #expect(Mat3x3d(values) == byColumns)
        #expect(byColumns.elements == values)
        #expect(Array(byColumns) == values)
    }

    @Test func mat4x4fConstructionPathsAgree() {
        let values: [Float] = (1...16).map(Float.init)
        let c0 = Vec4f(1, 2, 3, 4), c1 = Vec4f(5, 6, 7, 8), c2 = Vec4f(9, 10, 11, 12), c3 = Vec4f(13, 14, 15, 16)
        let byColumns = Mat4x4f(c0, c1, c2, c3)

        #expect(Mat4x4f([c0, c1, c2, c3]) == byColumns)
        #expect(Mat4x4f(values) == byColumns)
        #expect([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] as Mat4x4f == byColumns)
        #expect(byColumns.columns.0 == c0)
        #expect(byColumns.columns.1 == c1)
        #expect(byColumns.columns.2 == c2)
        #expect(byColumns.columns.3 == c3)
        #expect(byColumns.elements == values)
        #expect(Array(byColumns) == values)
        #expect(byColumns[3, 2] == 15)

        var iterated: [Float] = []
        for value in byColumns {
            iterated.append(value)
        }
        #expect(iterated == values)
    }

    @Test func mat4x4dConstructionPathsAgree() {
        let values: [Double] = (1...16).map(Double.init)
        let c0 = Vec4d(1, 2, 3, 4), c1 = Vec4d(5, 6, 7, 8), c2 = Vec4d(9, 10, 11, 12), c3 = Vec4d(13, 14, 15, 16)
        let byColumns = Mat4x4d(c0, c1, c2, c3)

        #expect(Mat4x4d([c0, c1, c2, c3]) == byColumns)
        #expect(Mat4x4d(values) == byColumns)
        #expect(byColumns.elements == values)
        #expect(Array(byColumns) == values)
    }

    @Test func quaternionIteratesComponentsInOrder() {
        let qf = Quat4f(1, 2, 3, 4)
        let qd = Quat4d(1, 2, 3, 4)

        #expect(Array(qf) == [1, 2, 3, 4])
        #expect(qf.elements == [1, 2, 3, 4])
        #expect(Array(qd) == [1, 2, 3, 4])
        #expect(qd.elements == [1, 2, 3, 4])
    }

    @Test func simdElementsAreInLaneOrder() {
        #expect(Vec2f(1, 2).elements == [1, 2])
        #expect(Vec3d(1, 2, 3).elements == [1, 2, 3])
        #expect(Vec4i(1, 2, 3, 4).elements == [1, 2, 3, 4])
        #expect(SIMD8<UInt8>(1, 2, 3, 4, 5, 6, 7, 8).elements == [1, 2, 3, 4, 5, 6, 7, 8])
    }
}
