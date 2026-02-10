import FirebladeMath
import Testing

struct Mat3x3fTests {
    @Test func identity() {
        let mat = Mat3x3f.identity
        #expect(mat[0, 0] == 1)
        #expect(mat[1, 1] == 1)
        #expect(mat[2, 2] == 1)
    }

    @Test func initialization() {
        let m = Mat3x3f(rotation: .pi / 2, axis: [0, 1, 0])
        #expect(abs(m[0, 0]) < 1e-6)
        #expect(abs(m[2, 0] - 1.0) < 1e-6)
        
        let m2 = Mat3x3f([1, 2, 3], [4, 5, 6], [7, 8, 9])
        #expect(m2[0, 0] == 1)
        #expect(m2[1, 0] == 4)
        #expect(m2[2, 0] == 7)
        
        let m3 = Mat3x3f(rotation: .pi / 4, axis: [1, 1, 1])
        #expect(m3 != .identity)
    }

    @Test func rotationInitY() {
        let m = Mat3x3f(rotation: .pi / 2, axis: [0, 1, 0])
        #expect(abs(m[0, 0]) < 1e-6)
    }

    @Test func rotationInitZ() {
        let m = Mat3x3f(rotation: .pi / 2, axis: [0, 0, 1])
        #expect(abs(m[2, 2] - 1.0) < 1e-6)
    }
    
    @Test func subscripts() {
        var m = Mat3x3f.identity
        m[0, 0] = 5
        #expect(m[0, 0] == 5)
        m[1] = 10 // index 1 is row 1 column 0? No, column 0 row 1.
        #expect(m[0, 1] == 10)
    }
    
    @Test func columns() {
        let m = Mat3x3f.identity
        let cols = m.columns
        #expect(cols.0 == [1, 0, 0])
        #expect(cols.1 == [0, 1, 0])
        #expect(cols.2 == [0, 0, 1])
    }
    
    @Test func arrayLiteral() {
        let m: Mat3x3f = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        #expect(m[0, 0] == 1)
        #expect(m[2, 2] == 9)
    }

    @Test func eulerAngles() {
        let m = Mat3x3f(rotation: 0.5, axis: [1, 0, 0])
        #expect(abs(m.eulerAngles.x - (-0.5)) < 1e-6)
    }
    
    @Test func eulerAnglesEdgeCases() {
        let m1 = Mat3x3f(rotation: -.pi / 2, axis: [0, 1, 0])
        #expect(abs(m1.eulerAngles.y - (.pi / 2)) < 1e-6)
        
        let m2 = Mat3x3f(rotation: .pi / 2, axis: [0, 1, 0])
        #expect(abs(m2.eulerAngles.y - (-.pi / 2)) < 1e-6)
    }

    @Test func matrixForcedContiguousStorage() throws {
        var mat = Mat3x3f.identity
        try mat.withForcedContiguousMutableStorage { buffer in
            buffer[0] = 2.0
        }
        #expect(mat[0, 0] == 2.0)
        
        try mat.withForcedContiguousStorage { buffer in
            #expect(buffer[0] == 2.0)
        }
    }

    @Test func collection() {
        let m = Mat3x3f.identity
        #expect(m.elements == [1, 0, 0, 0, 1, 0, 0, 0, 1])
        #expect(m.count == 9)
        #expect(m.index(before: 1) == 0)
    }
}
