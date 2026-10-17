//
//  MatrixIndexingTests.swift
//  FirebladeMathTests
//

import FirebladeMath
import Testing

struct MatrixIndexingTests {
    // The flat subscript must follow the column-major storage layout:
    // index = column * rows + row.

    @Test func mat2x2FlatIndexIsColumnMajor() {
        let mf: Mat2x2f = [1, 2, 3, 4]
        let md: Mat2x2d = [1, 2, 3, 4]
        for index in 0..<4 {
            #expect(mf[index] == mf[index / 2, index % 2])
            #expect(md[index] == md[index / 2, index % 2])
        }
    }

    @Test func mat3x3FlatIndexIsColumnMajor() {
        let mf = Mat3x3f((1...9).map(Float.init))
        let md = Mat3x3d((1...9).map(Double.init))
        for index in 0..<9 {
            #expect(mf[index] == mf[index / 3, index % 3])
            #expect(md[index] == md[index / 3, index % 3])
        }
    }

    @Test func mat4x4FlatIndexIsColumnMajor() {
        let mf = Mat4x4f((1...16).map(Float.init))
        let md = Mat4x4d((1...16).map(Double.init))
        for index in 0..<16 {
            #expect(mf[index] == mf[index / 4, index % 4])
            #expect(md[index] == md[index / 4, index % 4])
        }
    }

    @Test func flatSubscriptSetterWritesColumnMajor() {
        var matrix = Mat4x4f.identity
        matrix[6] = 42 // column 1, row 2
        #expect(matrix[1, 2] == 42)
        #expect(matrix.columns.1.z == 42)
    }

    // MARK: - Deprecated helpers keep their behavior

    @Test
    @available(*, deprecated, message: "Testing deprecated API")
    func deprecatedColumnRowIsColumnMajor() {
        #expect(columnRow(index: 6, width: 4) == (column: 1, row: 2))
        #expect(columnRow(index: 0, width: 3) == (column: 0, row: 0))
        #expect(columnRow(index: 8, width: 3) == (column: 2, row: 2))
    }

    @Test
    @available(*, deprecated, message: "Testing deprecated API")
    func deprecatedIndexIsRowMajor() {
        // Documented mismatch: index(column:row:width:) is row-major, columnRow is column-major.
        #expect(index(column: 1, row: 2, width: 4) == 9)
        #expect(columnRow(index: index(column: 1, row: 2, width: 4), width: 4) != (column: 1, row: 2))
    }
}
