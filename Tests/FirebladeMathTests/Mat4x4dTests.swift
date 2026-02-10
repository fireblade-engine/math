import Testing
@testable import FirebladeMath

@Suite struct Mat4x4dTests {
    @Test func identity() {
        let m = Mat4x4d.identity
        #expect(m[0, 0] == 1)
        #expect(m[1, 1] == 1)
        #expect(m[2, 2] == 1)
        #expect(m[3, 3] == 1)
        #expect(m[0, 1] == 0)
    }

    @Test func initialization() {
        let m = Mat4x4d(rotation: .pi / 2, axis: [0, 1, 0])
        #expect(abs(m[0, 0]) < 1e-15)
        #expect(abs(m[2, 0] - 1.0) < 1e-15)
    }
    
    @Test func translation() {
        var m = Mat4x4d.identity
        m.translation = [1, 2, 3]
        #expect(m.translation == SIMD3<Double>(1, 2, 3))
        #expect(m[3, 0] == 1)
        #expect(m[3, 1] == 2)
        #expect(m[3, 2] == 3)
    }
    
    @Test func lookAt() {
        let eye = Vec3d(0, 0, 5)
        let center = Vec3d(0, 0, 0)
        let up = Vec3d(0, 1, 0)
        let m = Mat4x4d.look(from: eye, at: center, up: up)
        
        let p = Vec3d(0, 0, 0)
        let tp = m.transformPoint(p)
        #expect(abs(tp.z - (-5.0)) < 1e-14)
    }

    @Test func matrixForcedContiguousStorage() throws {
        var mat = Mat4x4d.identity
        try mat.withForcedContiguousMutableStorage { buffer in
            buffer[0] = 2.0
        }
        #expect(mat[0, 0] == 2.0)
    }

    @Test func eulerAngles() {
        let m = Mat4x4d(rotation: 0.5, axis: [1, 0, 0])
        #expect(abs(m.eulerAnglesXYZ.x - (-0.5)) < 1e-15)
        
        let m2 = Mat4x4d(rotation: .pi / 2, axis: [0, 1, 0])
        #expect(abs(m2.eulerAnglesXYZ.y - (-.pi / 2)) < 1e-15)
    }
}
