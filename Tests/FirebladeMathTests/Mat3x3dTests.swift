import Testing
@testable import FirebladeMath

@Suite struct Mat3x3dTests {
    @Test func identity() {
        let m = Mat3x3d.identity
        #expect(m[0, 0] == 1)
        #expect(m[1, 1] == 1)
        #expect(m[2, 2] == 1)
    }

    @Test func initialization() {
        let m = Mat3x3d(rotation: .pi / 2, axis: [0, 1, 0])
        #expect(abs(m[0, 0]) < 1e-15)
        #expect(abs(m[2, 0] - 1.0) < 1e-15)
    }
    
    @Test func eulerAngles() {
        let m = Mat3x3d(rotation: 0.5, axis: [1, 0, 0])
        #expect(abs(m.eulerAngles.x - (-0.5)) < 1e-15)
    }

    @Test func matrixForcedContiguousStorage() throws {
        var mat = Mat3x3d.identity
        try mat.withForcedContiguousMutableStorage { buffer in
            buffer[0] = 2.0
        }
        #expect(mat[0, 0] == 2.0)
    }
}
