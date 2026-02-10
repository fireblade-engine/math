import Testing
@testable import FirebladeMath

@Suite struct QuaternionOperatorTests {
    // MARK: - Quat4f
    @Test func quat4fOperators() {
        let q1 = Quat4f(0, 0, 0, 1)
        let q2 = Quat4f(1, 0, 0, 0)
        
        #expect(q1 + q2 == Quat4f(1, 0, 0, 1))
        #expect(q1 - q2 == Quat4f(-1, 0, 0, 1))
        #expect(q1 * q2 == q2)
        
        let scalarRes = q1 * 2.0
        #expect(scalarRes.w == 2.0)
        
        let vec = Vec3f(1, 0, 0)
        let qRot = Quat4f(angle: .pi / 2, axis: [0, 0, 1])
        let rotated = qRot * vec
        #expect(abs(rotated.y - 1.0) < 1e-6)
    }

    // MARK: - Quat4d
    @Test func quat4dOperators() {
        let q1 = Quat4d(0, 0, 0, 1)
        let q2 = Quat4d(1, 0, 0, 0)
        
        #expect(q1 + q2 == Quat4d(1, 0, 0, 1))
        #expect(q1 - q2 == Quat4d(-1, 0, 0, 1))
        #expect(q1 * q2 == q2)
        
        let scalarRes = q1 * 2.0
        #expect(scalarRes.w == 2.0)
        
        let vec = Vec3d(1, 0, 0)
        let qRot = Quat4d(angle: .pi / 2, axis: [0, 0, 1])
        let rotated = qRot * vec
        #expect(abs(rotated.y - 1.0) < 1e-15)
    }
}
