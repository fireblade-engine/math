#if FRB_MATH_USE_SIMD
import simd
#endif

extension Mat4x4d {
    public init(rotation angleRadians: Double, axis: SIMD3<Double>) {
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

    @inlinable public var scale: SIMD3<Double> {
        let sx = length(storage.columns.0)
        let sy = length(storage.columns.1)
        let sz = length(storage.columns.2)
        return SIMD3<Double>(sx, sy, sz)
    }

    public init(upperLeft matrix3x3: Mat3x3d) {
        self.init(Vector(matrix3x3.columns.0, 0),
                  Vector(matrix3x3.columns.1, 0),
                  Vector(matrix3x3.columns.2, 0),
                  Vector(0, 0, 0, 1))
    }

    @inlinable public var upperLeft: Mat3x3d {
        Mat3x3d(SIMD3<Double>(columns.0.x, columns.0.y, columns.0.z),
                SIMD3<Double>(columns.1.x, columns.1.y, columns.1.z),
                SIMD3<Double>(columns.2.x, columns.2.y, columns.2.z))
    }

    @inlinable public var translation: SIMD3<Double> {
        get {
            let c3 = columns.3
            return SIMD3<Double>(c3[0], c3[1], c3[2])
        }
        set {
            self[3, 0] = newValue.x
            self[3, 1] = newValue.y
            self[3, 2] = newValue.z
        }
    }

    public init(translation tVec: SIMD3<Double> = .zero, scale sVec: SIMD3<Double> = .one) {
        self.init(diagonal: Vector(sVec.x, sVec.y, sVec.z, 1.0))
        translation = tVec
    }

    @inlinable public var inverted: Mat4x4d {
        inverse(self)
    }

    @inlinable public var transposed: Mat4x4d {
        transpose(self)
    }

    @inlinable
    public static func look(from eyePosition: SIMD3<Double>, at lookAtPosition: SIMD3<Double>, up: SIMD3<Double>) -> Mat4x4d {
        let ev = eyePosition
        let cv = lookAtPosition
        let uv = up

        let n = normalize(ev - cv)
        let u = normalize(cross(uv, n))
        let v = cross(n, u)

        return Mat4x4d(
            Vector(u.x, v.x, n.x, 0.0),
            Vector(u.y, v.y, n.y, 0.0),
            Vector(u.z, v.z, n.z, 0.0),
            Vector(dot(-u, ev), dot(-v, ev), dot(-n, ev), 1.0)
        )
    }

    @inlinable
    public func transformPoint(_ point: Vec3d) -> Vec3d {
        let p4 = Vec4d(point.x, point.y, point.z, 1.0)
        let res = multiply(self, p4)
        return Vec3d(res.x, res.y, res.z)
    }

    @inlinable
    public func transformDirection(_ dir: Vec3d) -> Vec3d {
        let d4 = Vec4d(dir.x, dir.y, dir.z, 0.0)
        let res = multiply(self, d4)
        return Vec3d(res.x, res.y, res.z)
    }

    /// Along x-axis
    @inlinable public var right: Vec3d {
        get {
            Vec3d(self[0, 0],
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
    @inlinable public var up: Vec3d {
        get {
            Vec3d(self[0, 1],
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
    @inlinable public var forward: Vec3d {
        get {
            Vec3d(self[0, 2],
                  self[1, 2],
                  self[2, 2])
        }
        set {
            self[0, 2] = newValue.x
            self[1, 2] = newValue.y
            self[2, 2] = newValue.z
        }
    }

    @inline(__always) public var eulerAnglesXYZ: Vec3d {
        let thetaX: Double
        let thetaY: Double
        let thetaZ: Double

        if self[0, 2] < +1 {
            if self[0, 2] > -1 {
                thetaY = asin(self[0, 2])
                thetaX = atan2(-self[1, 2], self[2, 2])
                thetaZ = atan2(-self[0, 1], self[0, 0])
            } else { // = -1
                thetaY = -.pi / 2
                thetaX = -atan2(self[1, 0], self[1, 1])
                thetaZ = 0
            }
        } else { // self[0,2] = +1
            thetaY = +.pi / 2
            thetaX = atan2(self[1, 0], self[1, 1])
            thetaZ = 0
        }

        return Vec3d(thetaX, thetaY, thetaZ)
    }
}
