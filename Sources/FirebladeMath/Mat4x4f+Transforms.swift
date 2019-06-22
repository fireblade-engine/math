//
//  Mat4x4f+Transforms.swift
//  FirebladeGFX
//
//  Created by Christian Treffs on 27.01.18.
//  Copyright © 2018 Fireblade. All rights reserved.
//

import simd

// SEE: https://github.com/g-truc/glm/blob/master/glm/gtc/matrix_transform.inl
public extension Mat4x4f {
    /// Creates a perspective projection matrix
    ///
    /// - Parameters:
    ///   - fovy: field of view
    ///   - aspect: aspect ratio
    ///   - zNear: near plane
    ///   - zFar: far plane
    /// - Returns: perspective projection matrix
    static func perspectiveProjection(fovy: AngleRadians, aspect: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        assert(aspect > 0.0)
        assert(zNear > 0.0)
        assert(zFar > zNear)
        assert(fovy > AngleRadians(0.0))
        //TODO: Float.pi - FLT_EPSILON
        //TODO: precondition(fovy <= Angle<T>(radians: T.pi - T.epsilon))

        switch kCoordinateSystem {
        case .leftHanded:
            return perspectiveProjectionLH(fovy: fovy, aspect: aspect, zNear: zNear, zFar: zFar)

        case .rightHanded:
            return perspectiveProjectionRH(fovy: fovy, aspect: aspect, zNear: zNear, zFar: zFar)
        }
    }
    // swiftlint:disable identifier_name
    /// Constructs a view matrix that is positioned at `eye` and looks toward `center`,
    /// with the `up` pointing up.
    ///
    /// - Parameters:
    ///   - eye: eye position
    ///   - center: look point
    ///   - up: up vector
    /// - Returns: view matrix
    static func lookAt(eye: Vec3f, center: Vec3f, up: Vec3f) -> Mat4x4f {
        let z: Vec3f = normalize(eye - center)
        let x: Vec3f = normalize(cross(up, z))
        let y: Vec3f = cross(z, x)
        let t = Vec3f(-dot(x, eye), -dot(y, eye), -dot(z, eye))

        return Mat4x4f(
            columns:
            (
                Vec4f(x.x, y.x, z.x, 0.0),
                Vec4f(x.y, y.y, z.y, 0.0),
                Vec4f(x.z, y.z, z.z, 0.0),
                Vec4f(t.x, t.y, t.z, 1.0)
            )
        )
    }

    static func rotation(radians: Float, axis: Vec3f) -> Mat4x4f {
        let unitAxis: Vec3f = normalize(axis)
        let cost: Float = cos(radians)
        let sint: Float = sin(radians)
        let cosi: Float = 1 - cost
        let x: Float = unitAxis.x
        let y: Float = unitAxis.y
        let z: Float = unitAxis.z
        return Mat4x4f(
            columns:
            (
                Vec4f(    cost + x * x * cosi, y * x * cosi + z * sint, z * x * cosi - y * sint, 0),
                Vec4f(x * y * cosi - z * sint, cost + y * y * cosi, z * y * cosi + x * sint, 0),
                Vec4f(x * z * cosi + y * sint, y * z * cosi - x * sint, cost + z * z * cosi, 0),
                Vec4f(                  0, 0, 0, 1)
            )
        )
    }

    init(position: Vec3f, scale: Vec3f, orientation: Quat4f) {
        // Ordering:
        //    1. Scale
        //    2. Rotate
        //    3. Translate

        let rot: Mat3x3f = simd_matrix3x3(orientation)
        var mat = Mat4x4f.identity

        mat[0][0] = scale.x * rot[0][0]; mat[0][1] = scale.y * rot[0][1]; mat[0][2] = scale.z * rot[0][2]; mat[0][3] = 0
        mat[1][0] = scale.x * rot[1][0]; mat[1][1] = scale.y * rot[1][1]; mat[1][2] = scale.z * rot[1][2]; mat[1][3] = 0
        mat[2][0] = scale.x * rot[2][0]; mat[2][1] = scale.y * rot[2][1]; mat[2][2] = scale.z * rot[2][2]; mat[2][3] = 0
        mat[3][0] = position.x; mat[3][1] = position.y; mat[3][2] = position.z; mat[3][3] = 1

        self = mat
    }

    @inlinable var position: Vec3f {
        get {
            return Vec3f(columns.3.x, columns.3.y, columns.3.z)
        }
        set {
            columns.3.x = newValue.x
            columns.3.y = newValue.y
            columns.3.z = newValue.z
        }
    }

    @inlinable var scale: Vec3f {
        get {
            let sx: Float = length(Vec3f(columns.0.x, columns.0.y, columns.0.z))
            let sy: Float = length(Vec3f(columns.1.x, columns.1.y, columns.1.z))
            let sz: Float = length(Vec3f(columns.2.x, columns.2.y, columns.2.z))
            return Vec3f(sx, sy, sz)
        }
        set {
            self = Mat4x4f(position: position, scale: newValue, orientation: orientation)
        }
    }

    @inlinable var orientation: Quat4f {
        get {
            return simd_quaternion(self)
        }
        set {
            self = Mat4x4f(position: position, scale: scale, orientation: newValue)
        }
    }
}

// MARK: - private

private extension Mat4x4f {
    static func perspectiveProjectionLH(fovy: AngleRadians, aspect: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        var mat = Mat4x4f(0.0)

        let tanHalfFovy: Float = tan(fovy * 0.5)

        mat[0][0] = 1.0 / (aspect * tanHalfFovy)
        mat[1][1] = 1.0 / tanHalfFovy
        mat[2][3] = 1.0

        switch kDepthClipSpace {
        case .zeroToOne:
            mat[2][2] = zFar / (zFar - zNear)
            mat[3][2] = -(zFar * zNear) / (zFar - zNear)

        case .negOneToOne:
            mat[2][2] = (zFar + zNear) / (zFar - zNear)
            mat[3][2] = -(zFar * zNear * 2.0) / (zFar - zNear)
        }

        return mat
    }

    static func perspectiveProjectionRH(fovy: AngleRadians, aspect: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        var mat = Mat4x4f(0.0)

        let tanHalfFovy: Float = tan(fovy * 0.5)

        mat[0][0] = 1.0 / (aspect * tanHalfFovy)
        mat[1][1] = 1.0 / tanHalfFovy
        mat[2][3] = -1.0

        switch kDepthClipSpace {
        case .zeroToOne:
            mat[2][2] = zFar / (zNear - zFar)
            mat[3][2] = -(zFar * zNear) / (zFar - zNear)

        case .negOneToOne:
            mat[2][2] = -(zFar + zNear) / (zFar - zNear)
            mat[3][2] = -(zFar * zNear * 2.0) / (zFar - zNear)
        }

        return mat
    }
}

// FIXME: --- refactor
/*func matrix_perspective_right_hand(fovyRadians fovy: Float, aspectRatio: Float, nearZ: Float, farZ: Float) -> matrix_float4x4 {
 let ys: Float = 1 / tanf(fovy * 0.5)
 let xs: Float = ys / aspectRatio
 let zs: Float = farZ / (nearZ - farZ)
 return matrix_float4x4.init(columns: (vector_float4(xs, 0, 0, 0),
 vector_float4( 0, ys, 0, 0),
 vector_float4( 0, 0, zs, -1),
 vector_float4( 0, 0, zs * nearZ, 0)))
 }*/
