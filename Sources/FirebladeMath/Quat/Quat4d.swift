extension Quat4d {
    /// Creates a double-precision quaternion from a single-precision quaternion.
    /// - Parameter quat: The single-precision quaternion.
    @inlinable public init(_ quat: Quat4f) {
        self.init(Double(quat.x), Double(quat.y), Double(quat.z), Double(quat.w))
    }

    /// The Euclidean length of the quaternion.
    @inlinable public var length: Double {
        FirebladeMath.length(self)
    }

    /// The axis of rotation of the quaternion.
    @inlinable public var axis: Vec3d {
        FirebladeMath.axis(self)
    }

    /// The angle of rotation of the quaternion in radians.
    @inlinable public var angle: Double {
        FirebladeMath.angle(self)
    }

    /// The conjugate of the quaternion.
    @inlinable public var conjugate: Quat4d {
        FirebladeMath.conjugate(self)
    }

    /// The inverse of the quaternion.
    @inlinable public var inverse: Quat4d {
        FirebladeMath.inverse(self)
    }

    /// A normalized copy of the quaternion.
    @inlinable public var normalized: Quat4d {
        FirebladeMath.normalize(self)
    }

    /// A Boolean value indicating whether any of the quaternion's components are NaN.
    @inlinable public var isNaN: Bool {
        x.isNaN || y.isNaN || z.isNaN || w.isNaN
    }

    /// Creates a quaternion from an angle and an axis.
    /// - Parameters:
    ///   - angleRadians: The angle of rotation in radians.
    ///   - axis: The axis of rotation.
    public init(angle angleRadians: Double, axis: SIMD3<Double>) {
        self = quaternion(angle: angleRadians, axis: axis)
    }

    /// Creates a quaternion from a 3x3 rotation matrix.
    /// - Parameter matrix: The 3x3 rotation matrix.
    public init(rotation matrix: Mat3x3d) {
        self = quaternion(matrix: matrix)
    }

    /// Creates a quaternion from a 4x4 rotation matrix.
    /// - Parameter matrix: The 4x4 rotation matrix.
    public init(rotation matrix: Mat4x4d) {
        self = quaternion(matrix: matrix)
    }

    /// Creates a quaternion that represents the rotation from one vector to another.
    /// - Parameters:
    ///   - from: The starting vector.
    ///   - to: The target vector.
    public init(from: SIMD3<Double>, to: SIMD3<Double>) {
        self = quaternion(from: from, to: to)
    }

    /// Creates a quaternion from pitch, yaw, and roll angles in radians.
    /// - Parameters:
    ///   - pitch: The pitch angle in radians.
    ///   - yaw: The yaw angle in radians.
    ///   - roll: The roll angle in radians.
    public init(pitch: Double, yaw: Double, roll: Double) {
        let c1 = cos(pitch / 2)
        let s1 = sin(pitch / 2)
        let c2 = cos(yaw / 2)
        let s2 = sin(yaw / 2)
        let c3 = cos(roll / 2)
        let s3 = sin(roll / 2)

        let w = c1 * c2 * c3 + s1 * s2 * s3
        let z = c1 * c2 * s3 - s1 * s2 * c3
        let y = c1 * s2 * c3 + s1 * c2 * s3
        let x = s1 * c2 * c3 - c1 * s2 * s3

        self.init(x, y, z, w)
    }

    /// The pitch component of the Euler angles in radians.
    @inlinable public var pitch: Double {
        eulerAngles.x
    }

    /// The yaw component of the Euler angles in radians.
    @inlinable public var yaw: Double {
        eulerAngles.y
    }

    /// The roll component of the Euler angles in radians.
    @inlinable public var roll: Double {
        eulerAngles.z
    }

    /// Returns the Euler angles (pitch, yaw, roll) for this quaternion in radians.
    /// - Returns: A 3D vector where x is pitch, y is yaw, and z is roll.
    @inlinable public var eulerAngles: Vec3d {
        let q0 = w
        let q1 = z
        let q2 = y
        let q3 = x

        let e1 = atan2(2 * (q1 * q2 + q0 * q3), q0 * q0 + q1 * q1 - q2 * q2 - q3 * q3)
        let e2 = asin(-2 * (q1 * q3 - q0 * q2))
        let e3 = atan2(2 * (q2 * q3 + q0 * q1), q0 * q0 - q1 * q1 - q2 * q2 + q3 * q3)

        return Vec3d(e1, e2, e3)
    }

    /// The rotation angle of the quaternion in radians.
    ///
    /// NOTE: DO NOT USE `simd_angle()` or `.angle` on the quaternion since it will always produce `3.1415927`
    @inlinable public var rotationAngle: Double {
        // https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L126

        // The quaternion representing the rotation is
        //   q = cos(A/2)+sin(A/2)*(x*i+y*j+z*k)
        let angle: Double
        let fSqrLength: Double = x * x + y * y + z * z
        if fSqrLength > 0.0 {
            angle = 2.0 * acos(w)
        } else {
            // angle is 0 (mod 2*pi), so any axis will do
            angle = 0.0
        }

        return angle
    }
}
