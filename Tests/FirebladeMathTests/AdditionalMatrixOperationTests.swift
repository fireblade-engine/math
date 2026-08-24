import Testing
@testable import FirebladeMath

@Suite struct AdditionalMatrixOperationTests {
    // MARK: - Inverse
    @Test func inverseMat3x3f() {
        let m = Mat3x3f([
            1, 2, 3,
            0, 1, 4,
            5, 6, 0
        ])
        let inv = inverse(m)
        let res = m * inv
        #expect(abs(res[0, 0] - 1.0) < 1e-5)
        #expect(abs(res[1, 1] - 1.0) < 1e-5)
        #expect(abs(res[2, 2] - 1.0) < 1e-5)
        #expect(abs(res[0, 1]) < 1e-5)
    }

    @Test func inverseMat3x3d() {
        let m = Mat3x3d([
            1, 2, 3,
            0, 1, 4,
            5, 6, 0
        ])
        let inv = inverse(m)
        let res = m * inv
        #expect(abs(res[0, 0] - 1.0) < 1e-10)
    }

    @Test func inverseMat4x4f() {
        let m = Mat4x4f([
            1, 0, 2, -1,
            3, 0, 0, 5,
            2, 1, 4, -3,
            1, 0, 5, 0
        ])
        let inv = inverse(m)
        let res = m * inv
        #expect(abs(res[0, 0] - 1.0) < 1e-5)
        #expect(abs(res[1, 1] - 1.0) < 1e-5)
        #expect(abs(res[2, 2] - 1.0) < 1e-5)
        #expect(abs(res[3, 3] - 1.0) < 1e-5)
    }

    @Test func inverseMat4x4d() {
        let m = Mat4x4d([
            1, 0, 2, -1,
            3, 0, 0, 5,
            2, 1, 4, -3,
            1, 0, 5, 0
        ])
        let inv = inverse(m)
        let res = m * inv
        #expect(abs(res[0, 0] - 1.0) < 1e-10)
    }

    @Test func inverseQuat4f() {
        let q = Quat4f(angle: .pi / 4, axis: [0, 1, 0])
        let inv = inverse(q)
        let res = q * inv
        #expect(abs(res.x) < 1e-6)
        #expect(abs(res.y) < 1e-6)
        #expect(abs(res.z) < 1e-6)
        #expect(abs(res.w - 1.0) < 1e-6)
    }

    @Test func inverseQuat4d() {
        let q = Quat4d(angle: .pi / 4, axis: [0, 1, 0])
        let inv = inverse(q)
        let res = q * inv
        #expect(abs(res.x) < 1e-15)
        #expect(abs(res.y) < 1e-15)
        #expect(abs(res.z) < 1e-15)
        #expect(abs(res.w - 1.0) < 1e-15)
    }

    // MARK: - Cross
    @Test func crossVec2f() {
        let v1 = Vec2f(1, 0)
        let v2 = Vec2f(0, 1)
        let res = cross(v1, v2)
        #expect(res == Vec3f(0, 0, 1))
    }

    @Test func crossVec2d() {
        let v1 = Vec2d(1, 0)
        let v2 = Vec2d(0, 1)
        let res = cross(v1, v2)
        #expect(res == Vec3d(0, 0, 1))
    }

    @Test func crossVec3f() {
        let v1 = Vec3f(1, 0, 0)
        let v2 = Vec3f(0, 1, 0)
        let res = cross(v1, v2)
        #expect(res == Vec3f(0, 0, 1))
    }

    @Test func crossVec3d() {
        let v1 = Vec3d(1, 0, 0)
        let v2 = Vec3d(0, 1, 0)
        let res = cross(v1, v2)
        #expect(res == Vec3d(0, 0, 1))
    }

    // MARK: - Matrix from Quaternion
    @Test func matrix3x3FromQuat() {
        let qf = Quat4f(angle: .pi / 2, axis: [0, 1, 0])
        let mf = matrix3x3(from: qf)
        #expect(abs(mf[0, 0] - 0.0) < 1e-6)
        #expect(abs(mf[2, 0] - 1.0) < 1e-6)

        let qd = Quat4d(angle: .pi / 2, axis: [0, 1, 0])
        let md = matrix3x3(from: qd)
        #expect(abs(md[0, 0] - 0.0) < 1e-15)
        #expect(abs(md[2, 0] - 1.0) < 1e-15)
    }

    @Test func matrix4x4FromQuat() {
        let qf = Quat4f(angle: .pi / 2, axis: [0, 1, 0])
        let mf = matrix4x4(from: qf)
        #expect(abs(mf[0, 0] - 0.0) < 1e-6)
        #expect(abs(mf[2, 0] - 1.0) < 1e-6)
        #expect(mf[3, 3] == 1.0)

        let qd = Quat4d(angle: .pi / 2, axis: [0, 1, 0])
        let md = matrix4x4(from: qd)
        #expect(abs(md[0, 0] - 0.0) < 1e-15)
        #expect(abs(md[2, 0] - 1.0) < 1e-15)
        #expect(md[3, 3] == 1.0)
    }

    // MARK: - Multiplication
    @Test func multiplyMat2x2() {
        let m1f = Mat2x2f([1, 2, 3, 4])
        let m2f = Mat2x2f([5, 6, 7, 8])
        #expect(multiply(m1f, m2f) == m1f * m2f)
        #expect(multiply(2.0, m1f) == 2.0 * m1f)
        #expect(multiply(Vec2f(1, 1), m1f) == Vec2f(3, 7))
        #expect(multiply(m1f, Vec2f(1, 1)) == Vec2f(4, 6))

        let m1d = Mat2x2d([1, 2, 3, 4])
        let m2d = Mat2x2d([5, 6, 7, 8])
        #expect(multiply(m1d, m2d) == m1d * m2d)
        #expect(multiply(2.0, m1d) == 2.0 * m1d)
        #expect(multiply(Vec2d(1, 1), m1d) == Vec2d(3, 7))
        #expect(multiply(m1d, Vec2d(1, 1)) == Vec2d(4, 6))
    }

    @Test func multiplyMat3x3() {
        let m1f = Mat3x3f.identity
        let m2f = Mat3x3f.identity
        #expect(multiply(m1f, m2f) == .identity)
        #expect(multiply(3.0, m1f)[0, 0] == 3.0)
        #expect(multiply(Vec3f(1, 1, 1), m1f) == Vec3f(1, 1, 1))
        #expect(multiply(m1f, Vec3f(1, 1, 1)) == Vec3f(1, 1, 1))

        let m1d = Mat3x3d.identity
        let m2d = Mat3x3d.identity
        #expect(multiply(m1d, m2d) == .identity)
        #expect(multiply(3.0, m1d)[0, 0] == 3.0)
        #expect(multiply(Vec3d(1, 1, 1), m1d) == Vec3d(1, 1, 1))
        #expect(multiply(m1d, Vec3d(1, 1, 1)) == Vec3d(1, 1, 1))
    }

    @Test func multiplyMat4x4() {
        let m1f = Mat4x4f.identity
        let m2f = Mat4x4f.identity
        #expect(multiply(m1f, m2f) == .identity)
        #expect(multiply(4.0, m1f)[0, 0] == 4.0)
        #expect(multiply(Vec4f(1, 1, 1, 1), m1f) == Vec4f(1, 1, 1, 1))
        #expect(multiply(m1f, Vec4f(1, 1, 1, 1)) == Vec4f(1, 1, 1, 1))

        let m1d = Mat4x4d.identity
        let m2d = Mat4x4d.identity
        #expect(multiply(m1d, m2d) == .identity)
        #expect(multiply(4.0, m1d)[0, 0] == 4.0)
        #expect(multiply(Vec4d(1, 1, 1, 1), m1d) == Vec4d(1, 1, 1, 1))
        #expect(multiply(m1d, Vec4d(1, 1, 1, 1)) == Vec4d(1, 1, 1, 1))
    }

    // MARK: - Projections & LookAt
    @Test func projectionsAndLookAt() {
        // Perspective
        let pf = Mat4x4f.perspectiveRH(fovy: 1.0, aspect: 1.0, zNear: 0.1, zFar: 10.0)
        #expect(pf[2, 3] == -1.0)
        let pd = Mat4x4d.perspectiveRH(fovy: 1.0, aspect: 1.0, zNear: 0.1, zFar: 10.0)
        #expect(pd[2, 3] == -1.0)

        _ = Mat4x4f.perspectiveLH(fovy: 1.0, aspect: 1.0, zNear: 0.1, zFar: 10.0)
        _ = Mat4x4d.perspectiveLH(fovy: 1.0, aspect: 1.0, zNear: 0.1, zFar: 10.0)

        // Ortho
        _ = Mat4x4f.orthographicRH(left: -1, right: 1, top: 1, bottom: -1, zNear: 0.1, zFar: 10.0)
        _ = Mat4x4d.orthographicRH(left: -1, right: 1, top: 1, bottom: -1, zNear: 0.1, zFar: 10.0)
        _ = Mat4x4f.orthographicLH(left: -1, right: 1, top: 1, bottom: -1, zNear: 0.1, zFar: 10.0)
        _ = Mat4x4d.orthographicLH(left: -1, right: 1, top: 1, bottom: -1, zNear: 0.1, zFar: 10.0)

        // LookAt
        _ = Mat4x4f.look(from: [0, 0, 1], at: [0, 0, 0], up: [0, 1, 0])
        _ = Mat4x4d.look(from: [0, 0, 1], at: [0, 0, 0], up: [0, 1, 0])
    }
}
