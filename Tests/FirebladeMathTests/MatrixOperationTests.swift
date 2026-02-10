import Testing
@testable import FirebladeMath

@Suite struct MatrixOperationTests {
    // MARK: - Transpose
    @Test func transposeMat3x3f() {
        let m = Mat3x3f([
            1, 2, 3,
            4, 5, 6,
            7, 8, 9
        ])
        let t = transpose(m)
        #expect(t[0, 0] == 1)
        #expect(t[0, 1] == 4)
        #expect(t[0, 2] == 7)
        #expect(t[1, 0] == 2)
        #expect(t[1, 1] == 5)
        #expect(t[1, 2] == 8)
        #expect(t[2, 0] == 3)
        #expect(t[2, 1] == 6)
        #expect(t[2, 2] == 9)
    }

    @Test func transposeMat3x3d() {
        let m = Mat3x3d([
            1, 2, 3,
            4, 5, 6,
            7, 8, 9
        ])
        let t = transpose(m)
        #expect(t[0, 0] == 1)
        #expect(t[1, 0] == 2) // column 1 row 0
        #expect(t[0, 1] == 4) // column 0 row 1
    }

    @Test func transposeMat4x4f() {
        let m = Mat4x4f([
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 10, 11, 12,
            13, 14, 15, 16
        ])
        let t = transpose(m)
        #expect(t[0, 1] == 5)
        #expect(t[1, 0] == 2)
    }

    @Test func transposeMat4x4d() {
        let m = Mat4x4d([
            1, 2, 3, 4,
            5, 6, 7, 8,
            9, 10, 11, 12,
            13, 14, 15, 16
        ])
        let t = transpose(m)
        #expect(t[0, 1] == 5)
        #expect(t[1, 0] == 2)
    }

    // MARK: - Determinant
    @Test func determinantMat3x3f() {
        let m = Mat3x3f([
            1, 2, 3,
            0, 1, 4,
            5, 6, 0
        ])
        #expect(determinant(m) == 1)
    }

    @Test func determinantMat3x3d() {
        let m = Mat3x3d([
            1, 2, 3,
            0, 1, 4,
            5, 6, 0
        ])
        #expect(determinant(m) == 1)
    }

    @Test func determinantMat4x4f() {
        let m = Mat4x4f([
            1, 0, 2, -1,
            3, 0, 0, 5,
            2, 1, 4, -3,
            1, 0, 5, 0
        ])
        #expect(determinant(m) == 30)
    }

    @Test func determinantMat4x4d() {
        let m = Mat4x4d([
            1, 0, 2, -1,
            3, 0, 0, 5,
            2, 1, 4, -3,
            1, 0, 5, 0
        ])
        #expect(determinant(m) == 30)
    }

    // MARK: - Adjugate
    @Test func adjugateMat3x3f() {
        let m = Mat3x3f([
            1, 2, 3,
            0, 4, 5,
            1, 0, 6
        ])
        let adj = adjugate(m)
        let det = determinant(m)
        
        // m * adj = det * I
        let res = m * adj
        #expect(abs(res[0, 0] - det) < 1e-5)
        #expect(abs(res[1, 1] - det) < 1e-5)
        #expect(abs(res[2, 2] - det) < 1e-5)
        #expect(abs(res[0, 1]) < 1e-5)
    }

    @Test func adjugateMat3x3d() {
        let m = Mat3x3d([
            1, 2, 3,
            0, 4, 5,
            1, 0, 6
        ])
        let adj = adjugate(m)
        let det = determinant(m)
        let res = m * adj
        #expect(abs(res[0, 0] - det) < 1e-10)
    }

    @Test func adjugateMat4x4f() {
        let m = Mat4x4f([
            1, 0, 2, -1,
            3, 0, 0, 5,
            2, 1, 4, -3,
            1, 0, 5, 0
        ])
        let adj = adjugate(m)
        let det = determinant(m)
        let res = m * adj
        #expect(abs(res[0, 0] - det) < 1e-4)
        #expect(abs(res[1, 1] - det) < 1e-4)
        #expect(abs(res[2, 2] - det) < 1e-4)
        #expect(abs(res[3, 3] - det) < 1e-4)
    }

    @Test func adjugateMat4x4d() {
        let m = Mat4x4d([
            1, 0, 2, -1,
            3, 0, 0, 5,
            2, 1, 4, -3,
            1, 0, 5, 0
        ])
        let adj = adjugate(m)
        let det = determinant(m)
        let res = m * adj
        #expect(abs(res[0, 0] - det) < 1e-10)
    }
}
