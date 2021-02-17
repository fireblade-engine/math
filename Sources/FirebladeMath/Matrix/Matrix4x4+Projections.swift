//
//  Matrix4x4+Projections.swift
//
//
//  Created by Christian Treffs on 02.09.20.
//

extension Mat4x4f {
    /// Perspective projection matrix in right-handed coordinates.
    /// - Parameters:
    ///   - fovyRad: The field of view in radians.
    ///   - aspect: The aspect ratio of the view.
    ///   - zNear: The near plane coordinate of the projection volume.
    ///   - zFar: The far plane coordinate of the projection volume.
    /// - Returns: A 4x4 perspective projection matrix in right-handed coordinates.
    public static func perspectiveRH(fovy fovyRad: Float, aspect: Float, zNear: Float, zFar: Float) -> Self {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>

        /* https://docs.microsoft.com/en-us/windows/win32/direct3d10/d3d10-d3dxmatrixperspectivefovrh
         xScale     0          0              0
         0        yScale       0              0
         0          0      zf/(zn-zf)        -1
         0          0      zn*zf/(zn-zf)      0
         where:
         yScale = cot(fovY/2)

         xScale = yScale / aspect ratio
         */

        let yScale: Float = 1.0 / tan(fovyRad / 2.0)
        let xScale: Float = yScale / aspect

        let m00: Float = xScale
        let m11: Float = yScale
        let m22: Float = zFar / (zNear - zFar) // zf/(zn-zf)
        let m23: Float = -1.0
        let m32: Float = (zNear * zFar) / (zNear - zFar) // zn*zf/(zn-zf)
        let m33: Float = 0.0

        let P = SIMD4<Float>(m00, 0.0, 0.0, 0.0)
        let Q = SIMD4<Float>(0.0, m11, 0.0, 0.0)
        let R = SIMD4<Float>(0.0, 0.0, m22, m23)
        let S = SIMD4<Float>(0.0, 0.0, m32, m33)

        return Self(P, Q, R, S)
    }

    /// Perspective projection matrix in left-handed coordinates.
    /// - Parameters:
    ///   - fovyRad: The field of view in radians.
    ///   - aspect: The aspect ratio of the view.
    ///   - zNear: The near plane coordinate of the projection volume.
    ///   - zFar: The far plane coordinate of the projection volume.
    /// - Returns: A 4x4 perspective projection matrix in left-handed coordinates.
    public static func perspectiveLH(fovy fovyRad: Float, aspect: Float, zNear: Float, zFar: Float) -> Self {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>

        /* https://docs.microsoft.com/en-us/windows/win32/direct3d10/d3d10-d3dxmatrixperspectivefovlh
         xScale     0          0               0
         0        yScale       0               0
         0          0       zf/(zf-zn)         1
         0          0       -zn*zf/(zf-zn)     0
         where:
         yScale = cot(fovY/2)

         xScale = yScale / aspect ratio
         */

        let yScale: Float = 1.0 / tan(fovyRad / 2.0)
        let xScale: Float = yScale / aspect

        let m00: Float = xScale
        let m11: Float = yScale
        let m22: Float = zFar / (zFar - zNear) // zf/(zf-zn)
        let m23: Float = 1.0
        let m32: Float = -(zNear * zFar) / (zFar - zNear) // -zn*zf/(zf-zn)
        let m33: Float = 0.0

        let P = SIMD4<Float>(m00, 0.0, 0.0, 0.0)
        let Q = SIMD4<Float>(0.0, m11, 0.0, 0.0)
        let R = SIMD4<Float>(0.0, 0.0, m22, m23)
        let S = SIMD4<Float>(0.0, 0.0, m32, m33)

        return Self(P, Q, R, S)
    }

    /// Orthographic projection matrix in right-handed coordinates.
    /// - Parameters:
    ///   - left: The left coordinate of the projection volume in eye coordinates.
    ///   - right: The right coordinate of the projection volume in eye coordinates.
    ///   - top: The top coordinate of the projection volume in eye coordinates.
    ///   - bottom: The bottom coordinate of the projection volume in eye coordinates.
    ///   - zNear: The near coordinate of the projection volume in eye coordinates.
    ///   - zFar: The far coordinate of the projection volume in eye coordinates.
    /// - Returns: A 4x4 orthographic projection matrix in right-handed coordinates.
    public static func orthographicRH(left: Float, right: Float, top: Float, bottom: Float, zNear: Float, zFar: Float) -> Self {
        // https://metashapes.com/blog/opengl-metal-projection-matrix-problem/

        /* Ortho Right Handed
         https://docs.microsoft.com/en-us/windows/win32/direct3d9/d3dxmatrixorthooffcenterrh
         2/(r-l)      0            0           0
         0            2/(t-b)      0           0
         0            0            1/(zn-zf)   0
         (l+r)/(l-r)  (t+b)/(b-t)  zn/(zn-zf)  1
         */

        let m00: Float = 2.0 / (right - left) // 2/(r-l)
        let m03: Float = (left + right) / (left - right) // (l+r)/(l-r)
        let m11: Float = 2.0 / (top - bottom) // 2/(t-b)
        let m13: Float = (top + bottom) / (bottom - top) // (t+b)/(b-t)
        let m22: Float = 1.0 / (zNear - zFar) // 1/(zn-zf)
        let m23: Float = zNear / (zNear - zFar) // zn/(zn-zf)
        let m33: Float = 1.0

        let P = SIMD4<Float>(m00, 0.0, 0.0, 0.0)
        let Q = SIMD4<Float>(0.0, m11, 0.0, 0.0)
        let R = SIMD4<Float>(0.0, 0.0, m22, 0.0)
        let S = SIMD4<Float>(m03, m13, m23, m33)

        return Self(P, Q, R, S)
    }

    /// Orthographic projection matrix in left-handed coordinates.
    /// - Parameters:
    ///   - left: The left coordinate of the projection volume in eye coordinates.
    ///   - right: The right coordinate of the projection volume in eye coordinates.
    ///   - top: The top coordinate of the projection volume in eye coordinates.
    ///   - bottom: The bottom coordinate of the projection volume in eye coordinates.
    ///   - zNear: The near coordinate of the projection volume in eye coordinates.
    ///   - zFar: The far coordinate of the projection volume in eye coordinates.
    /// - Returns: A 4x4 orthographic projection matrix in left-handed coordinates.
    public static func orthographicLH(left: Float, right: Float, top: Float, bottom: Float, zNear: Float, zFar: Float) -> Self {
        // https://blog.demofox.org/2017/03/31/orthogonal-projection-matrix-plainly-explained/

        /* Ortho Left Handed
         https://docs.microsoft.com/en-us/windows/win32/direct3d9/d3dxmatrixorthooffcenterlh
         2/(r-l)      0            0           0
         0            2/(t-b)      0           0
         0            0            1/(zf-zn)   0
         (l+r)/(l-r)  (t+b)/(b-t)  zn/(zn-zf)  1
         */

        let m00: Float = 2.0 / (right - left) // 2/(r-l)
        let m03: Float = (left + right) / (left - right) // (l+r)/(l-r)
        let m11: Float = 2.0 / (top - bottom) //  2/(t-b)
        let m13: Float = (top + bottom) / (bottom - top) // (t+b)/(b-t)
        let m22: Float = 1.0 / (zFar - zNear) // 1/(zf-zn)
        let m23: Float = zNear / (zNear - zFar) // zn/(zn-zf)
        let m33: Float = 1.0

        let P = SIMD4<Float>(m00, 0.0, 0.0, m03)
        let Q = SIMD4<Float>(0.0, m11, 0.0, m13)
        let R = SIMD4<Float>(0.0, 0.0, m22, m23)
        let S = SIMD4<Float>(0.0, 0.0, 0.0, m33)

        return Self(P, Q, R, S)
    }

    // @inlinable
    // public static func orthographic3(left: Float, right: Float, top: Float, bottom: Float, zNear: Float, zFar: Float) -> Self {
    //     let sLength: Float = 1.0 / (right - left)
    //     let sHeight: Float = 1.0 / (top - bottom)
    //     let sDepth: Float = 1.0 / (zFar - zNear)

    //     let P = SIMD<Float>(2.0 * sLength, 0.0, 0.0, 0.0)
    //     let Q = SIMD<Float>(0.0, 2.0 * sHeight, 0.0, 0.0)
    //     let R = SIMD<Float>(0.0, 0.0, sDepth, 0.0)
    //     let S = SIMD<Float>(0.0, 0.0, -zNear * sDepth, 1.0)

    //     return Self(P, Q, R, S)
    // }
}
