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

    @inline(__always) public var eulerAnglesXYZ: Vec3f {
        // /// https://www.geometrictools.com/Documentation/EulerAngles.pdf
        let thetaX: Float
        let thetaY: Float
        let thetaZ: Float

        if self[0, 2] < +1 {
            if self[0, 2] > -1 {
                thetaY = asin(self[0, 2])
                thetaX = atan2(-self[1, 2], self[2, 2])
                thetaZ = atan2(-self[0, 1], self[0, 0])
            } else { // = -1
                // Not a unique solution: thetaZ - thetaX = atan2(self[1,0], self[1,1])
                thetaY = -.pi / 2
                thetaX = -atan2(self[1, 0], self[1, 1])
                thetaZ = 0
            }
        } else { // self[0,2] = +1
            // Not a unique solution: thetaZ + thetaX = atan2(self[1,0],self[1,1])
            thetaY = +.pi / 2
            thetaX = atan2(self[1, 0], self[1, 1])
            thetaZ = 0
        }

        return Vec3f(thetaX, thetaY, thetaZ)
    }
}
