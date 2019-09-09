//
//  Mat4x4f.swift
//
//
//  Created by Christian Treffs on 06.09.19.
//

extension Mat4x4f {
    @inlinable public var scale: SIMD3<Float> {
        let sx = storage.columns.0.length
        let sy = storage.columns.1.length
        let sz = storage.columns.2.length

        return SIMD3<Float>(sx, sy, sz)
    }

    @inlinable public var translation: SIMD3<Float> {
        return SIMD3<Float>(columns.3[0],
                            columns.3[1],
                            columns.3[2])
    }

    public init(translation tVec: SIMD3<Float> = .zero, scale sVec: SIMD3<Float> = .one) {
        let values: [Float] = [sVec.x, 0, 0, 0,
                               0, sVec.y, 0, 0,
                               0, 0, sVec.z, 0,
                               tVec.x, tVec.y, tVec.z, 1]
        self.init(values)
    }

    @discardableResult
    @inlinable
    public mutating func translate(by vec: SIMD3<Float>) -> Mat4x4f {
        self = multiply(self, Mat4x4f(translation: vec))
        return self
    }

    @discardableResult
    @inlinable
    public mutating func scale(by vec: SIMD3<Float>) -> Mat4x4f {
        self = multiply(self, Mat4x4f(scale: vec))
        return self
    }

    @discardableResult
    @inlinable
    public mutating func rotate(by angleRadians: Float, axis: SIMD3<Float>) -> Mat4x4f {
        self = multiply(self, Mat4x4f(rotation: angleRadians, axis: axis))
        return self
    }

    @inlinable
    public static func look(from eyePosition: SIMD3<Float>, at lookAtPosition: SIMD3<Float>, up: SIMD3<Float>) -> Mat4x4f {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        let ev: SIMD3<Float> = eyePosition
        let cv: SIMD3<Float> = lookAtPosition
        let uv: SIMD3<Float> = up

        let n: SIMD3<Float> = normalize(ev - cv)
        let u: SIMD3<Float> = normalize(cross(uv, n))
        let v: SIMD3<Float> = cross(n, u)

        return Mat4x4f(
            Vector(u.x, v.x, n.x, 0.0),
            Vector(u.y, v.y, n.y, 0.0),
            Vector(u.z, v.z, n.z, 0.0),
            Vector(dot(-u, ev), dot(-v, ev), dot(-n, ev), 1.0)
        )
    }

    @inlinable
    public static func perspective(fovy fovyRadians: Float, width: Float, height: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        precondition(fovyRadians > Float(0.0), "Field of view must be greater than 0.0")
        precondition(width > Float(0.0), "Width must be greater than 0.0")
        precondition(height > Float(0.0), "Height must be greater than 0.0")
        precondition(zNear > Float(0.0), "zNear must be greater than 0.0")
        precondition(zFar > zNear, "zFar must be greater than zNear and greater than 0.0")

        let aspect: Float = width / height
        let cotan: Float = 1.0 / tan(fovyRadians / 2.0)

        let m00: Float = cotan / aspect
        let m11: Float = cotan
        let m22: Float = (zFar + zNear) / (zNear - zFar)
        let m23: Float = -1.0
        let m32: Float = (2.0 * zFar * zNear) / (zNear - zFar)
        let m33: Float = 0.0

        return Mat4x4f(
            Vector(m00, 0.0, 0.0, 0.0),
            Vector(0.0, m11, 0.0, 0.0),
            Vector(0.0, 0.0, m22, m23),
            Vector(0.0, 0.0, m32, m33))
    }

    /// Returns a 4x4 orthographic projection matrix.
    /// - Parameter left: The left coordinate of the projection volume in eye coordinates.
    /// - Parameter right: The right coordinate of the projection volume in eye coordinates.
    /// - Parameter bottom: The bottom coordinate of the projection volume in eye coordinates.
    /// - Parameter top: The top coordinate of the projection volume in eye coordinates.
    /// - Parameter zNear: The near coordinate of the projection volume in eye coordinates.
    /// - Parameter zFar: The far coordinate of the projection volume in eye coordinates.
    @inlinable
    public static func orthographic(left: Float, right: Float, bottom: Float, top: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        let ral: Float = right + left
        let rsl: Float = right - left
        let tab: Float = top + bottom
        let tsb: Float = top - bottom
        let fan: Float = zFar + zNear
        let fsn: Float = zFar - zNear

        return Mat4x4f(
            SIMD4<Float>(2.0 / rsl, 0.0, 0.0, 0.0),
            SIMD4<Float>(0.0, 2.0 / tsb, 0.0, 0.0),
            SIMD4<Float>(0.0, 0.0, -2.0 / fsn, 0.0),
            SIMD4<Float>(-ral / rsl, -tab / tsb, -fan / fsn, 1.0)
        )
    }
}
