//
//  Mat4x4f.swift
//  
//
//  Created by Christian Treffs on 22.07.19.
//

import simd

public typealias Mat4x4f = simd_float4x4

extension Mat4x4f {
    public init(_ array: [Float]) {
        precondition(array.count == 16, "Matrix need exactly 16 values")
        self.init(SIMD4<Float>(array[0], array[1], array[2], array[3]),
                  SIMD4<Float>(array[4], array[5], array[6], array[7]),
                  SIMD4<Float>(array[8], array[9], array[10], array[11]),
                  SIMD4<Float>(array[12], array[13], array[14], array[15]))
    }

    public init(columns columnA: Vec4f, _ columnB: Vec4f, _ columnC: Vec4f, _ columnD: Vec4f) {
        self.init(columnA, columnB, columnC, columnD)
    }

    public init(translation tVec: Vec3f = .zero, scale sVec: Vec3f = .one) {
        self.init([sVec.x, 0, 0, 0,
                   0, sVec.y, 0, 0,
                   0, 0, sVec.z, 0,
                   tVec.x, tVec.y, tVec.z, 1])
    }

    public init(rotation angleRadians: Float, axis: Vec3f) {
        self.init(upperLeft: Mat3x3f(rotation: angleRadians, axis: axis))
    }

    public init(orientation quaternion: Quat4f) {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        let nQuat: Vec4f = quaternion.normalized.vector

        let x: Float = nQuat[0]
        let y: Float = nQuat[1]
        let z: Float = nQuat[2]
        let w: Float = nQuat[3]

        let _2x: Float = x + x
        let _2y: Float = y + y
        let _2z: Float = z + z
        let _2w: Float = w + w

        self.init(
            Vec4f(1.0 - _2y * y - _2z * z,
                  _2x * y + _2w * z,
                  _2x * z - _2w * y,
                  0.0),
            Vec4f(_2x * y - _2w * z,
                  1.0 - _2x * x - _2z * z,
                  _2y * z + _2w * x,
                  0.0),
            Vec4f(_2x * z + _2w * y,
                  _2y * z - _2w * x,
                  1.0 - _2x * x - _2y * y,
                  0.0),
            Vec4f(0.0, 0.0, 0.0, 1.0)
        )
    }

    public init(upperLeft matrix3x3: Mat3x3f) {
        self.init(Vec4f(matrix3x3.columns.0, 0),
                  Vec4f(matrix3x3.columns.1, 0),
                  Vec4f(matrix3x3.columns.2, 0),
                  Vec4f(0, 0, 0, 1))
    }

    public init(_ matrix4x4: Mat4x4d) {
        self.init(Vec4f(matrix4x4.columns.0),
                  Vec4f(matrix4x4.columns.1),
                  Vec4f(matrix4x4.columns.2),
                  Vec4f(matrix4x4.columns.3))
    }
}

// MARK: - computed properties
extension Mat4x4f {
    @inlinable public var upperLeft: Mat3x3f {
        return Mat3x3f(Vec3f(columns.0.xyz),
                       Vec3f(columns.1.xyz),
                       Vec3f(columns.2.xyz))
    }

    @inlinable public var inverted: Mat4x4f {
        return simd.simd_inverse(self)
    }

    @inlinable public var determinant: Float {
        return simd.simd_determinant(self)
    }

    @inlinable public var scale: Vec3f {
        let sx = columns.0.length
        let sy = columns.1.length
        let sz = columns.2.length

        return Vec3f(sx, sy, sz)
    }

    @inlinable public var translation: Vec3f {
        return Vec3f(columns.3[0], columns.3[1], columns.3[2])
    }
}

// MARK: - mutating operations
extension Mat4x4f {
    @discardableResult
    @inlinable public mutating func translate(by vec: Vec3f) -> Mat4x4f {
        self *= Mat4x4f(translation: vec)
        return self
    }

    @discardableResult
    @inlinable public mutating func scale(by vec: Vec3f) -> Mat4x4f {
        self *= Mat4x4f(scale: vec)
        return self
    }

    @discardableResult
    @inlinable public mutating func rotate(by angleRadians: Float, axis: Vec3f) -> Mat4x4f {
        self *= Mat4x4f(rotation: angleRadians, axis: axis)
        return self
    }
}

// MARK: - static functions
extension Mat4x4f: IdentitiyProviding {
    public static let identity = Mat4x4f(diagonal: .one)
}

extension Mat4x4f {
    @inlinable public static func look(from eyePosition: Vec3f, at lookAtPosition: Vec3f, up: Vec3f) -> Mat4x4f {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        let ev: Vec3f = eyePosition
        let cv: Vec3f = lookAtPosition
        let uv: Vec3f = up

        let n: Vec3f = normalize(ev - cv)
        let u: Vec3f = normalize(cross(uv, n))
        let v: Vec3f = cross(n, u)

        return Mat4x4f(
            Vec4f(u.x, v.x, n.x, 0.0),
            Vec4f(u.y, v.y, n.y, 0.0),
            Vec4f(u.z, v.z, n.z, 0.0),
            Vec4f(dot(-u, ev), dot(-v, ev), dot(-n, ev), 1.0)
        )
    }

    @inlinable public static func perspective(fovy fovyRadians: Float, width: Float, height: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        precondition(fovyRadians > 0.0, "Field of view must be greater than 0.0")
        precondition(width > 0.0, "Width must be greater than 0.0")
        precondition(height > 0.0, "Height must be greater than 0.0")
        precondition(zNear > 0.0, "zNear must be greater than 0.0")
        precondition(zFar > zNear, "zFar must be greater than zNear and greater than 0.0")

        let aspect: Float = width / height
        let cotan: Float = 1.0 / tanf(fovyRadians / 2.0)

        let m00: Float = cotan / aspect
        let m11: Float = cotan
        let m22: Float = (zFar + zNear) / (zNear - zFar)
        let m23: Float = -1.0
        let m32: Float = (2.0 * zFar * zNear) / (zNear - zFar)
        let m33: Float = 0.0

        return Mat4x4f(Vec4f(m00, 0.0, 0.0, 0.0),
                       Vec4f(0.0, m11, 0.0, 0.0),
                       Vec4f(0.0, 0.0, m22, m23),
                       Vec4f(0.0, 0.0, m32, m33))
    }

    /// Returns a 4x4 orthographic projection matrix.
    /// - Parameter left: The left coordinate of the projection volume in eye coordinates.
    /// - Parameter right: The right coordinate of the projection volume in eye coordinates.
    /// - Parameter bottom: The bottom coordinate of the projection volume in eye coordinates.
    /// - Parameter top: The top coordinate of the projection volume in eye coordinates.
    /// - Parameter zNear: The near coordinate of the projection volume in eye coordinates.
    /// - Parameter zFar: The far coordinate of the projection volume in eye coordinates.
    @inlinable public static func orthographic(left: Float, right: Float, bottom: Float, top: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        let ral: Float = right + left
        let rsl: Float = right - left
        let tab: Float = top + bottom
        let tsb: Float = top - bottom
        let fan: Float = zFar + zNear
        let fsn: Float = zFar - zNear

        return Mat4x4f(
            Vec4f(2.0 / rsl, 0.0, 0.0, 0.0),
            Vec4f(0.0, 2.0 / tsb, 0.0, 0.0),
            Vec4f(0.0, 0.0, -2.0 / fsn, 0.0),
            Vec4f(-ral / rsl, -tab / tsb, -fan / fsn, 1.0)
        )
    }
}

// MARK: - unused
extension Mat4x4f {
    /*
     @inlinable public static func projectionPerspective2(fovy fovyRadians: Float, width: Float, height: Float, zNear: Float, zFar: Float) -> Mat4x4f {
     // see: https://github.com/EpicGames/UnrealEngine/blob/master/Engine/Source/Runtime/Core/Public/Math/PerspectiveMatrix.h#L81
     
     precondition(fovyRadians > 0.0, "Field of view must be greater than 0.0")
     precondition(width > 0.0, "Width must be greater than 0.0")
     precondition(height > 0.0, "Height must be greater than 0.0")
     precondition(zNear > 0.0, "zNear must be greater than 0.0")
     precondition(zFar > zNear, "zFar must be greater than zNear and greater than 0.0")
     
     let cotan: Float = tanf(fovyRadians / 2.0)
     
     
     let m00: Float = 1.0 / cotan
     let m11: Float = width / cotan / height
     let m22: Float = zFar / (zFar - zNear)
     let m23: Float = 1.0
     let m32: Float = -zNear * zFar / (zFar - zNear)
     let m33: Float = 0.0
     
     
     return Mat4x4f(Vec4f(m00, 0, 0, 0),
     Vec4f(0, m11, 0, 0),
     Vec4f(0, 0, m22, m23),
     Vec4f(0, 0, m32, m33))
     }
     
     */
}
