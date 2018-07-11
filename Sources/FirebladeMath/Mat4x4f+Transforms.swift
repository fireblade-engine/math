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

    static func rotation(radians: Float, axis: Vec3f) -> Mat4x4f {
        let unitAxis: Vec3f = normalize(axis)
        let cost: Float = cos(radians)
        let sint: Float = sin(radians)
        let cosi: Float = 1 - cost
        let x: Float = unitAxis.x
        let y: Float = unitAxis.y
        let z: Float = unitAxis.z
        return Mat4x4f(columns: (Vec4f(    cost + x * x * cosi, y * x * cosi + z * sint, z * x * cosi - y * sint, 0),
                                 Vec4f(x * y * cosi - z * sint, cost + y * y * cosi, z * y * cosi + x * sint, 0),
                                 Vec4f(x * z * cosi + y * sint, y * z * cosi - x * sint, cost + z * z * cosi, 0),
                                 Vec4f(                  0, 0, 0, 1)))
    }

    static func translation(_ position: Vec3f) -> Mat4x4f {
        return Mat4x4f(columns: (Vec4f(1, 0, 0, 0),
                                 Vec4f(0, 1, 0, 0),
                                 Vec4f(0, 0, 1, 0),
                                 Vec4f(position.x, position.y, position.z, 1)))
    }

    init(position: Vec3f, scale: Vec3f, orientation: Quat4f) {
        // Ordering:
        //    1. Scale
        //    2. Rotate
        //    3. Translate

        let rot: Mat3x3f = simd_matrix3x3(orientation)
        var mat: Mat4x4f = Mat4x4f.identity

        mat[0][0] = scale.x * rot[0][0]; mat[0][1] = scale.y * rot[0][1]; mat[0][2] = scale.z * rot[0][2]; mat[0][3] = 0
        mat[1][0] = scale.x * rot[1][0]; mat[1][1] = scale.y * rot[1][1]; mat[1][2] = scale.z * rot[1][2]; mat[1][3] = 0
        mat[2][0] = scale.x * rot[2][0]; mat[2][1] = scale.y * rot[2][1]; mat[2][2] = scale.z * rot[2][2]; mat[2][3] = 0
        mat[3][0] = position.x; mat[3][1] = position.y; mat[3][2] = position.z; mat[3][3] = 1

        self = mat
    }
}

// MARK: - private

private extension Mat4x4f {
    static func perspectiveProjectionLH(fovy: AngleRadians, aspect: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        var mat: Mat4x4f = Mat4x4f(0.0)

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
        var mat: Mat4x4f = Mat4x4f(0.0)

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
