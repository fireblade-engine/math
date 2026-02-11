extension Quat4f {
    /// The Euclidean length of the quaternion.
    @inlinable public var length: Float {
        FirebladeMath.length(self)
    }

    /// The axis of rotation of the quaternion.
    @inlinable public var axis: Vec3f {
        FirebladeMath.axis(self)
    }

    /// The angle of rotation of the quaternion in radians.
    @inlinable public var angle: Float {
        FirebladeMath.angle(self)
    }

    /// The conjugate of the quaternion.
    @inlinable public var conjugate: Quat4f {
        FirebladeMath.conjugate(self)
    }

    /// The inverse of the quaternion.
    @inlinable public var inverse: Quat4f {
        FirebladeMath.inverse(self)
    }

    /// A normalized copy of the quaternion.
    @inlinable public var normalized: Quat4f {
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
    public init(angle angleRadians: Float, axis: SIMD3<Float>) {
        self = quaternion(angle: angleRadians, axis: axis)
    }

    /// Creates a quaternion from a 3x3 rotation matrix.
    /// - Parameter matrix: The 3x3 rotation matrix.
    public init(rotation matrix: Mat3x3f) {
        self = quaternion(matrix: matrix)
    }

    /// Creates a quaternion from a 4x4 rotation matrix.
    /// - Parameter matrix: The 4x4 rotation matrix.
    public init(rotation matrix: Mat4x4f) {
        self = quaternion(matrix: matrix)
    }

    /// Creates a quaternion that represents the rotation from one vector to another.
    /// - Parameters:
    ///   - from: The starting vector.
    ///   - to: The target vector.
    public init(from: SIMD3<Float>, to: SIMD3<Float>) {
        self = quaternion(from: from, to: to)
    }

    /// The rotation angle of the quaternion in radians.
    ///
    /// NOTE: DO NOT USE `simd_angle()` or `.angle` on the quaternion since it will always produce `3.1415927`
    @inlinable public var rotationAngle: Float {
        // https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L126

        // The quaternion representing the rotation is
        //   q = cos(A/2)+sin(A/2)*(x*i+y*j+z*k)
        let angle: Float
        let fSqrLength: Float = x * x + y * y + z * z
        if fSqrLength > 0.0 {
            angle = 2.0 * acos(w)
        } else {
            // angle is 0 (mod 2*pi), so any axis will do
            angle = 0.0
        }

        return angle
    }
}