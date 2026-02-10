import Testing
@testable import FirebladeMath

@Suite struct MatrixOperatorTests {
    // MARK: - Mat2x2
    @Test func mat2x2fOperators() {
        let m1 = Mat2x2f([1, 2, 3, 4])
        let m2 = Mat2x2f([5, 6, 7, 8])
        
        let res = m1 * m2
        #expect(res[0, 0] == 1 * 5 + 3 * 6)
        
        var m3 = m1
        m3 *= m2
        #expect(m3 == res)
        
        let scalarRes = 2.0 * m1
        #expect(scalarRes[0, 0] == 2.0)
        
        let vec = Vec2f(1, 1)
        let vecRes1 = m1 * vec
        #expect(vecRes1 == Vec2f(4, 6))

        let vecRes2 = vec * m1
        #expect(vecRes2 == Vec2f(3, 7))
    }

    @Test func mat2x2dOperators() {
        let m1 = Mat2x2d([1, 2, 3, 4])
        let m2 = Mat2x2d([5, 6, 7, 8])
        
        let res = m1 * m2
        #expect(res[0, 0] == 1 * 5 + 3 * 6)

        var m3 = m1
        m3 *= m2
        #expect(m3 == res)

        let scalarRes = 2.0 * m1
        #expect(scalarRes[0, 0] == 2.0)

        let vec = Vec2d(1, 1)
        let vecRes1 = m1 * vec
        #expect(vecRes1 == Vec2d(4, 6))

        let vecRes2 = vec * m1
        #expect(vecRes2 == Vec2d(3, 7))
    }

    // MARK: - Mat3x3
    @Test func mat3x3fOperators() {
        let m1 = Mat3x3f.identity
        let m2 = Mat3x3f.identity
        #expect(m1 * m2 == .identity)

        var m3 = m1
        m3 *= m2
        #expect(m3 == .identity)
        
        let scalarRes = 3.0 * m1
        #expect(scalarRes[0, 0] == 3.0)

        let vec = Vec3f(1, 1, 1)
        #expect(m1 * vec == vec)
        #expect(vec * m1 == vec)
    }

    @Test func mat3x3dOperators() {
        let m1 = Mat3x3d.identity
        let m2 = Mat3x3d.identity
        #expect(m1 * m2 == .identity)

        var m3 = m1
        m3 *= m2
        #expect(m3 == .identity)

        let scalarRes = 3.0 * m1
        #expect(scalarRes[0, 0] == 3.0)

        let vec = Vec3d(1, 1, 1)
        #expect(m1 * vec == vec)
        #expect(vec * m1 == vec)
    }

    // MARK: - Mat4x4
    @Test func mat4x4fOperators() {
        let m1 = Mat4x4f.identity
        let m2 = Mat4x4f.identity
        #expect(m1 * m2 == .identity)

        var m3 = m1
        m3 *= m2
        #expect(m3 == .identity)
        
        let scalarRes = 4.0 * m1
        #expect(scalarRes[0, 0] == 4.0)

        let vec = Vec4f(1, 1, 1, 1)
        #expect(m1 * vec == vec)
        #expect(vec * m1 == vec)
    }

    @Test func mat4x4dOperators() {
        let m1 = Mat4x4d.identity
        let m2 = Mat4x4d.identity
        #expect(m1 * m2 == .identity)

        var m3 = m1
        m3 *= m2
        #expect(m3 == .identity)

        let scalarRes = 4.0 * m1
        #expect(scalarRes[0, 0] == 4.0)

        let vec = Vec4d(1, 1, 1, 1)
        #expect(m1 * vec == vec)
        #expect(vec * m1 == vec)
    }
}