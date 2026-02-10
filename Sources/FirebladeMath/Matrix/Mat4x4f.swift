#if FRB_MATH_USE_SIMD
import simd
#endif

extension Mat4x4f {
    public init(rotation angleRadians: Float, axis: SIMD3<Float>) {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        let v = normalize(axis)
        let icos = cos(angleRadians)
        let icosp = 1.0 - icos
        let isin = sin(angleRadians)

        self.init(
            Vector(icos + icosp * v.x * v.x,
                   icosp * v.x * v.y + v.z * isin,
                   icosp * v.x * v.z - v.y * isin,
                   0),
            Vector(icosp * v.x * v.y - v.z * isin,
                   icos + icosp * v.y * v.y,
                   icosp * v.y * v.z + v.x * isin,
                   0),
            Vector(icosp * v.x * v.z + v.y * isin,
                   icosp * v.y * v.z - v.x * isin,
                   icos + icosp * v.z * v.z,
                   0),
            Vector(0, 0, 0, 1)
        )
    }

    @inlinable public var scale: SIMD3<Float> {
        let sx = length(storage.columns.0)
        let sy = length(storage.columns.1)
        let sz = length(storage.columns.2)
        return SIMD3<Float>(sx, sy, sz)
    }

    public init(upperLeft matrix3x3: Mat3x3f) {
        self.init(Vector(matrix3x3.columns.0, 0),
                  Vector(matrix3x3.columns.1, 0),
                  Vector(matrix3x3.columns.2, 0),
                  Vector(0, 0, 0, 1))
    }

    @inlinable public var upperLeft: Mat3x3f {
        Mat3x3f(SIMD3<Float>(columns.0.x, columns.0.y, columns.0.z),
                SIMD3<Float>(columns.1.x, columns.1.y, columns.1.z),
                SIMD3<Float>(columns.2.x, columns.2.y, columns.2.z))
    }

    @inlinable public var translation: SIMD3<Float> {
        get {
            let c3 = columns.3
            return SIMD3<Float>(c3[0], c3[1], c3[2])
        }
        set {
            self[3, 0] = newValue.x
            self[3, 1] = newValue.y
            self[3, 2] = newValue.z
        }
    }

    @inlinable public var rotation: SIMD4<Float> {
        let quat = Quat4f(rotation: self)
        return SIMD4<Float>(quat.x, quat.y, quat.z, quat.w)
    }

    public init(translation tVec: SIMD3<Float> = .zero, scale sVec: SIMD3<Float> = .one) {
        self.init(diagonal: Vector(sVec.x, sVec.y, sVec.z, 1.0))
        translation = tVec
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
        self = multiply(self, Mat4x4f(translation: .zero, scale: vec))
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
        let ev = eyePosition
        let cv = lookAtPosition
        let uv = up

        let n = normalize(ev - cv)
        let u = normalize(cross(uv, n))
        let v = cross(n, u)

        return Mat4x4f(
            Vector(u.x, v.x, n.x, 0.0),
            Vector(u.y, v.y, n.y, 0.0),
            Vector(u.z, v.z, n.z, 0.0),
            Vector(dot(-u, ev), dot(-v, ev), dot(-n, ev), 1.0)
        )
    }

    @inlinable
    public static func lookAt(eye: Vec3f, center: Vec3f, up: Vec3f) -> Mat4x4f {
        look(from: eye, at: center, up: up)
    }

    @inlinable
    public static func rotation(angle: Float, axis: Vec3f) -> Mat4x4f {
        Mat4x4f(rotation: angle, axis: axis)
    }

    @inlinable
    public static func translation(x: Float, y: Float, z: Float) -> Mat4x4f {
        Mat4x4f(translation: Vec3f(x, y, z))
    }

    @inlinable
    public static func scaling(x: Float, y: Float, z: Float) -> Mat4x4f {
        Mat4x4f(translation: .zero, scale: Vec3f(x, y, z))
    }

    @inlinable
    public func transformPoint(_ point: Vec3f) -> Vec3f {
        let p4 = Vec4f(point.x, point.y, point.z, 1.0)
        let res = multiply(self, p4)
        return Vec3f(res.x, res.y, res.z)
    }

    @inlinable
    public func transformDirection(_ dir: Vec3f) -> Vec3f {
        let d4 = Vec4f(dir.x, dir.y, dir.z, 0.0)
        let res = multiply(self, d4)
        return Vec3f(res.x, res.y, res.z)
    }

    /// Around x-axis
    @inlinable
    public mutating func pitch(by angle: Float) {
        rotate(by: angle, axis: Vec3f(1, 0, 0))
    }

    /// Around y-axis
    @inlinable
    public mutating func yaw(by angle: Float) {
        rotate(by: angle, axis: Vec3f(0, 1, 0))
    }

    /// Around z-axis
    @inlinable
    public mutating func roll(by angle: Float) {
        rotate(by: angle, axis: Vec3f(0, 0, 1))
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
