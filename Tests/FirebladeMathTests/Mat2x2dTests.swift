import Testing
@testable import FirebladeMath

@Suite struct Mat2x2dTests {
    @Test func identity() {
        let m = Mat2x2d.identity
        #expect(m[0, 0] == 1)
        #expect(m[1, 1] == 1)
    }

    @Test func initialization() {
        let m = Mat2x2d([1, 2, 3, 4])
        #expect(m[0, 0] == 1)
        #expect(m[0, 1] == 2)
        #expect(m[1, 0] == 3)
        #expect(m[1, 1] == 4)
    }

    @Test func diagonalInitialization() {
        let m = Mat2x2d(diagonal: [5, 6])
        #expect(m[0, 0] == 5)
        #expect(m[1, 1] == 6)
        #expect(m[0, 1] == 0)
    }

    @Test func arrayInitialization() {
        let m = Mat2x2d([10, 11, 12, 13])
        #expect(m[0, 0] == 10)
        #expect(m[1, 1] == 13)
    }

    @Test func matrixForcedContiguousStorage() throws {
        var mat = Mat2x2d.identity
        try mat.withForcedContiguousMutableStorage { buffer in
            buffer[0] = 2.0
        }
        #expect(mat[0, 0] == 2.0)
    }

    @Test func explicitBaseCalls() {
        let cols = [SIMD2<Double>(1, 2), SIMD2<Double>(3, 4)]
        let m1 = Mat2x2d(cols)
        #expect(m1[0, 0] == 1)
        
        let vals: [Double] = [5, 6, 7, 8]
        let m2 = Mat2x2d(vals)
        #expect(m2[0, 0] == 5)
        
        let m3 = Mat2x2d(diagonal: [9, 10])
        #expect(m3[0, 0] == 9)
        
        #expect(m3.index(before: 1) == 0)
        #expect(m3.index(after: 0) == 1)
    }

    @Test func collection() {
        let m = Mat2x2d.identity
        #expect(m.elements == [1, 0, 0, 1])
        #expect(m.index(before: 1) == 0)
    }
}
