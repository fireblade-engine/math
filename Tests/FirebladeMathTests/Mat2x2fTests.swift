import FirebladeMath
import Testing

struct Mat2x2fTests {
    @Test func identity() {
        let mat = Mat2x2f.identity
        #expect(mat[0, 0] == 1)
        #expect(mat[1, 1] == 1)
    }

    @Test func initialization() {
        let mat = Mat2x2f([1, 2, 3, 4])
        #expect(mat[0, 0] == 1)
        #expect(mat[0, 1] == 2)
        #expect(mat[1, 0] == 3)
        #expect(mat[1, 1] == 4)
        
        let mat2 = Mat2x2f([1, 2], [3, 4])
        #expect(mat2[0, 0] == 1)
        #expect(mat2[1, 1] == 4)
        
        let mat3 = Mat2x2f(diagonal: [5, 6])
        #expect(mat3[0, 0] == 5)
        #expect(mat3[1, 1] == 6)
        #expect(mat3[0, 1] == 0)

        let mat4 = Mat2x2f([10, 11, 12, 13])
        #expect(mat4[0, 0] == 10)
        #expect(mat4[1, 1] == 13)
        
        let mat5 = Mat2x2f(SIMD2<Float>(1, 2), SIMD2<Float>(3, 4))
        #expect(mat5[0, 0] == 1)
        #expect(mat5[1, 1] == 4)
    }

    @Test func subscripts() {
        var m = Mat2x2f.identity
        m[0, 0] = 5
        #expect(m[0, 0] == 5)
        m[1] = 10
        #expect(m[0, 1] == 10)
    }

    @Test func columns() {
        let m = Mat2x2f.identity
        let cols = m.columns
        #expect(cols.0 == [1, 0])
        #expect(cols.1 == [0, 1])
    }

    @Test func explicitBaseCalls() {
        let cols = [SIMD2<Float>(1, 2), SIMD2<Float>(3, 4)]
        let m1 = Mat2x2f(cols)
        #expect(m1[0, 0] == 1)
        
        let vals: [Float] = [5, 6, 7, 8]
        let m2 = Mat2x2f(vals)
        #expect(m2[0, 0] == 5)
        
        let m3 = Mat2x2f(diagonal: [9, 10])
        #expect(m3[0, 0] == 9)
        
        #expect(m3.index(before: 1) == 0)
    }

    @Test func matrixForcedContiguousStorage() throws {
        var mat = Mat2x2f.identity
        try mat.withForcedContiguousMutableStorage { buffer in
            buffer[0] = 2.0
        }
        #expect(mat[0, 0] == 2.0)
        
        try mat.withForcedContiguousStorage { buffer in
            #expect(buffer[0] == 2.0)
        }
    }

    @Test func collection() {
        let m = Mat2x2f.identity
        #expect(m.elements == [1, 0, 0, 1])
        #expect(m.count == 4)
        #expect(m.index(after: 0) == 1)
        #expect(m.index(before: 1) == 0)
        #expect(m.startIndex == 0)
        #expect(m.endIndex == 4)
    }
}
