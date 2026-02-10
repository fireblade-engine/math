import Testing
@testable import FirebladeMath

@Suite struct Quat4dTests {
    @Test func initialization() {
        let q = Quat4d(1, 2, 3, 4)
        #expect(q.x == 1)
        #expect(q.y == 2)
        #expect(q.z == 3)
        #expect(q.w == 4)
        
        let q2 = Quat4d(SIMD4<Double>(5, 6, 7, 8))
        #expect(q2.x == 5)
        #expect(q2.w == 8)
        
        let q3 = Quat4d()
        #expect(q3.x == 0)
        #expect(q3.w == 1)
        
        let q4f = Quat4f(1, 2, 3, 4)
        let q4d = Quat4d(q4f)
        #expect(q4d.x == 1)
        #expect(q4d.w == 4)
    }
    
    @Test func properties() {
        let q = Quat4d(0, 0, 0, 1)
        #expect(q.length == 1)
        #expect(q.normalized == q)
        #expect(q.conjugate == Quat4d(0, 0, 0, 1))
        
        let q2 = Quat4d(1, 0, 0, 0)
        #expect(q2.conjugate == Quat4d(-1, 0, 0, 0))
        
        #expect(!q.isNaN)
        #expect(Quat4d(Double.nan, 0, 0, 1).isNaN)
    }
    
    @Test func rotationInit() {
        let axis = Vec3d(0, 1, 0)
        let angle = Double.pi / 2
        let q = Quat4d(angle: angle, axis: axis)
        
        #expect(abs(q.angle - angle) < 1e-10)
        #expect(abs(q.axis.y - 1.0) < 1e-10)
        
        let m = Mat3x3d(rotation: angle, axis: axis)
        let qm = Quat4d(rotation: m)
        #expect(abs(qm.w - q.w) < 1e-10)
    }
    
    @Test func eulerAngles() {
        let q = Quat4d(pitch: 0.1, yaw: 0.2, roll: 0.3)
        #expect(abs(q.pitch - 0.1) < 1e-10)
        #expect(abs(q.yaw - 0.2) < 1e-10)
        #expect(abs(q.roll - 0.3) < 1e-10)
    }

    @Test func sequence() {
        let q = Quat4d(1, 2, 3, 4)
        #expect(Array(q) == [1, 2, 3, 4])
        #expect(q.elements == [1, 2, 3, 4])
    }

    @Test func arrayLiteral() {
        let q: Quat4d = [1, 2, 3, 4]
        #expect(q.x == 1)
        #expect(q.w == 4)
    }

    @Test func matrixInit() {
        let m = Mat3x3d(rotation: .pi / 2, axis: [0, 1, 0])
        let q = Quat4d(rotation: m)
        #expect(abs(q.rotationAngle - .pi / 2) < 1e-10)
        
        let m4 = Mat4x4d(rotation: .pi / 2, axis: [0, 1, 0])
        let q4 = Quat4d(rotation: m4)
        #expect(abs(q4.rotationAngle - .pi / 2) < 1e-10)
    }
}
