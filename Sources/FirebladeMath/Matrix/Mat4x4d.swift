#if FRB_MATH_USE_SIMD
import simd
#endif

extension Mat4x4d {
    /// Creates a 4x4 rotation matrix.
    /// - Parameters:
    ///   - angleRadians: The angle of rotation in radians.
    ///   - axis: The axis of rotation.
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

    /// The scale factor of the matrix.
    @inlinable public var scale: SIMD3<Double> {
        let sx = length(storage.columns.0)
        let sy = length(storage.columns.1)
        let sz = length(storage.columns.2)
        return SIMD3<Double>(sx, sy, sz)
    }

    /// Creates a 4x4 matrix from a 3x3 upper-left matrix.
    /// - Parameter matrix3x3: The 3x3 matrix.
    public init(upperLeft matrix3x3: Mat3x3d) {
        self.init(Vector(matrix3x3.columns.0, 0),
                  Vector(matrix3x3.columns.1, 0),
                  Vector(matrix3x3.columns.2, 0),
                  Vector(0, 0, 0, 1))
    }

    /// The upper-left 3x3 matrix.
    @inlinable public var upperLeft: Mat3x3d {
        Mat3x3d(SIMD3<Double>(columns.0.x, columns.0.y, columns.0.z),
                SIMD3<Double>(columns.1.x, columns.1.y, columns.1.z),
                SIMD3<Double>(columns.2.x, columns.2.y, columns.2.z))
    }

    /// The translation vector of the matrix.
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

    /// Creates a 4x4 matrix with the specified translation and scale.
    /// - Parameters:
    ///   - tVec: The translation vector.
    ///   - sVec: The scale vector.
    public init(translation tVec: SIMD3<Double> = .zero, scale sVec: SIMD3<Double> = .one) {
        self.init(diagonal: Vector(sVec.x, sVec.y, sVec.z, 1.0))
        translation = tVec
    }

    /// The inverted matrix.
    @inlinable public var inverted: Mat4x4d {
        inverse(self)
    }

    /// The transposed matrix.
    @inlinable public var transposed: Mat4x4d {
        transpose(self)
    }

    /// Creates a 4x4 view matrix for a camera at `eyePosition` looking at `lookAtPosition`.
    /// - Parameters:
    ///   - eyePosition: The position of the camera.
    ///   - lookAtPosition: The position to look at.
    ///   - up: The up vector.
    /// - Returns: The view matrix.
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

    /// Transforms a 3D point by the matrix.
    /// - Parameter point: The 3D point to transform.
    /// - Returns: The transformed point.
    @inlinable
    public func transformPoint(_ point: Vec3d) -> Vec3d {
        let p4 = Vec4d(point.x, point.y, point.z, 1.0)
        let res = multiply(self, p4)
        return Vec3d(res.x, res.y, res.z)
    }

    /// Transforms a 3D direction vector by the matrix.
    /// - Parameter dir: The 3D direction vector to transform.
    /// - Returns: The transformed direction vector.
    @inlinable
    public func transformDirection(_ dir: Vec3d) -> Vec3d {
        let d4 = Vec4d(dir.x, dir.y, dir.z, 0.0)
        let res = multiply(self, d4)
        return Vec3d(res.x, res.y, res.z)
    }

    /// The right direction vector (positive x-axis) in view space.
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

    /// The up direction vector (positive y-axis) in view space.
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

    /// The forward direction vector (positive z-axis) in view space.
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

    /// Returns the Euler angles (pitch, yaw, roll) for this matrix in radians.
    /// - Returns: A 3D vector where x is pitch, y is yaw, and z is roll.
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