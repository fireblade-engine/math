//
//  Mat4x4f.swift
//
//
//  Created by Christian Treffs on 06.09.19.
//

extension Mat4x4f {
    /*public init(rotation angleRadians: Float, axis: SIMD3<Float>) {
     let quat = Quat4f(angle: angleRadians, axis: axis)
     self = matrix4x4(from: quat)
     }*/

    public init(rotation angleRadians: Float, axis: SIMD3<Float>) {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        let v: SIMD3<Float> = normalize(axis)
        let icos: Storage.Value = cos(angleRadians)
        let icosp: Storage.Value = 1.0 - icos
        let isin: Storage.Value = sin(angleRadians)

        self.init(
            Vector( icos + icosp * v.x * v.x,
                    icosp * v.x * v.y + v.z * isin,
                    icosp * v.x * v.z - v.y * isin,
                    0),
            Vector( icosp * v.x * v.y - v.z * isin,
                    icos + icosp * v.y * v.y,
                    icosp * v.y * v.z + v.x * isin,
                    0),
            Vector( icosp * v.x * v.z + v.y * isin,
                    icosp * v.y * v.z - v.x * isin,
                    icos + icosp * v.z * v.z,
                    0),
            Vector(0, 0, 0, 1)
        )
    }

    @inlinable public var scale: SIMD3<Float> {
        get {
            let sx = storage.columns.0.length
            let sy = storage.columns.1.length
            let sz = storage.columns.2.length
            return SIMD3<Float>(sx, sy, sz)
        }
        set {
            fatalError("CAN NOT SET SCALE YET")
        }
    }

    public init(upperLeft matrix3x3: Mat3x3f) {
        self.init(Vector(matrix3x3.columns.0, 0),
                  Vector(matrix3x3.columns.1, 0),
                  Vector(matrix3x3.columns.2, 0),
                  Vector(0, 0, 0, 1))
    }

    @inlinable public var upperLeft: Mat3x3f {
        Mat3x3f(SIMD3<Float>(columns.0.xyz),
                SIMD3<Float>(columns.1.xyz),
                SIMD3<Float>(columns.2.xyz))
    }

    @inlinable public var translation: SIMD3<Float> {
        get {
            SIMD3<Float>(columns.3[0],
                         columns.3[1],
                         columns.3[2])
        }
        set {
            storage[3, 0] = newValue.x
            storage[3, 1] = newValue.y
            storage[3, 2] = newValue.z
        }
    }

    @inlinable public var rotation: SIMD4<Float> {
        get {
            SIMD4<Float>(Quat4f(rotation: self))
        }
        set {
            fatalError("CAN NOT SET ROTATION YET")
        }
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

    @inlinable public var inverted: Mat4x4f {
        inverse(self)
    }

    @inlinable public var transposed: Mat4x4f {
        transpose(self)
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
        let aspect: Float = width / height
        return Self.perspective(fovy: fovyRadians, aspect: aspect, zNear: zNear, zFar: zFar)
    }

    @inlinable
    public static func perspective(fovy fovyRadians: Float, aspect: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        //precondition(fovyRadians > Float(0.0), "Field of view must be greater than 0.0")
        //precondition(width > Float(0.0), "Width must be greater than 0.0")
        //precondition(height > Float(0.0), "Height must be greater than 0.0")
        //precondition(zNear > Float(0.0), "zNear must be greater than 0.0")
        //precondition(zFar > zNear, "zFar must be greater than zNear and greater than 0.0")

        let cotan: Float = 1.0 / tan(fovyRadians / 2.0)

        let m00: Float = cotan / aspect
        let m11: Float = cotan
        let m22: Float = (zFar + zNear) / (zNear - zFar)
        let m23: Float = -1.0
        let m32: Float = (2.0 * zFar * zNear) / (zNear - zFar)
        let m33: Float = 0.0

        return Mat4x4f(
            .init(m00, 0.0, 0.0, 0.0),
            .init(0.0, m11, 0.0, 0.0),
            .init(0.0, 0.0, m22, m23),
            .init(0.0, 0.0, m32, m33))
    }

    /// Returns a 4x4 orthographic projection matrix.
    /// - Parameter left: The left coordinate of the projection volume in eye coordinates.
    /// - Parameter right: The right coordinate of the projection volume in eye coordinates.
    /// - Parameter top: The top coordinate of the projection volume in eye coordinates.
    /// - Parameter bottom: The bottom coordinate of the projection volume in eye coordinates.
    /// - Parameter zNear: The near coordinate of the projection volume in eye coordinates.
    /// - Parameter zFar: The far coordinate of the projection volume in eye coordinates.
    @inlinable
    public static func orthographic(left: Float, right: Float, top: Float, bottom: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        // https://blog.demofox.org/2017/03/31/orthogonal-projection-matrix-plainly-explained/

        let rsl = right - left
        let tsb = top - bottom
        let fsn = zFar - zNear
        let lsr = left - right
        let bst = bottom - top

        let ral = right + left
        let tab = top + bottom

        let P = Vec4f(2.0 / rsl, 0.0, 0.0, 0.0)
        let Q = Vec4f(0.0, 2.0 / tsb, 0.0, 0.0)
        let R = Vec4f(0.0, 0.0, 1 / fsn, 0.0)
        let S = Vec4f(ral / lsr, tab / bst, zNear / fsn, 1.0)

        return Mat4x4f(P, Q, R, S)
    }

    // https://metashapes.com/blog/opengl-metal-projection-matrix-problem/

    /// Returns a 4x4 orthographic projection matrix.
    /// - Parameter left: The left coordinate of the projection volume in eye coordinates.
    /// - Parameter right: The right coordinate of the projection volume in eye coordinates.
    /// - Parameter top: The top coordinate of the projection volume in eye coordinates.
    /// - Parameter bottom: The bottom coordinate of the projection volume in eye coordinates.
    /// - Parameter zNear: The near coordinate of the projection volume in eye coordinates.
    /// - Parameter zFar: The far coordinate of the projection volume in eye coordinates.
    @inlinable
    public static func orthographic2(left: Float, right: Float, top: Float, bottom: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        let rsl = right - left
        let tsb = top - bottom
        let fsn = zFar - zNear
        let rpl = right + left
        let tpb = top + bottom

        let P = Vec4f(2.0 / rsl, 0.0, 0.0, -rpl / rsl)
        let Q = Vec4f(0.0, 2.0 / tsb, 0.0, -tpb / tsb)
        let R = Vec4f(0.0, 0.0, -1.0 / fsn, -zNear / fsn)
        let S = Vec4f(0.0, 0.0, 0.0, 1.0)

        return Mat4x4f(P, Q, R, S)
    }

    public static func orthographic3(left: Float, right: Float, top: Float, bottom: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        let sLength: Float = 1.0 / (right - left)
        let sHeight: Float = 1.0 / (top - bottom)
        let sDepth: Float = 1.0 / (zFar - zNear)

        let P = Vec4f(2.0 * sLength, 0.0, 0.0, 0.0)
        let Q = Vec4f(0.0, 2.0 * sHeight, 0.0, 0.0)
        let R = Vec4f(0.0, 0.0, sDepth, 0.0)
        let S = Vec4f(0.0, 0.0, -zNear * sDepth, 1.0)

        return Mat4x4f(P, Q, R, S)
    }

    // Around x-axis
    @inlinable
    public mutating func pitch(by angle: Float) {
        self.rotate(by: angle, axis: .axisX)
    }

    /// Around y-axis
    @inlinable
    public mutating func yaw(by angle: Float) {
        self.rotate(by: angle, axis: .axisY)
    }

    /// Around z-axis
    @inlinable
    public mutating func roll(by angle: Float) {
        self.rotate(by: angle, axis: .axisZ)
    }

    /// Along x-axis
    @inlinable public var right: Vec3f {
        get {
            Vec3f(self[0, 0],
                  self[1, 0],
                  self[2, 0])
        }
        set {
            self[0, 0] = newValue.x
            self[1, 0] = newValue.y
            self[2, 0] = newValue.z
        }
    }

    /// Along y-axis
    @inlinable public var up: Vec3f {
        get {
            Vec3f(self[0, 1],
                  self[1, 1],
                  self[2, 1])
        }
        set {
            self[0, 1] = newValue.x
            self[1, 1] = newValue.y
            self[2, 1] = newValue.z
        }
    }

    /// Along z-axis
    @inlinable public var forward: Vec3f {
        get {
            Vec3f(self[0, 2],
                  self[1, 2],
                  self[2, 2])
        }
        set {
            self[0, 2] = newValue.x
            self[1, 2] = newValue.y
            self[2, 2] = newValue.z
        }
    }
}
