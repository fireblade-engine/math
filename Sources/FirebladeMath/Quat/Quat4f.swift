extension Quat4f {
    /// The length of the quaternion `q`.
    @inlinable public var length: Float {
        FirebladeMath.length(self)
    }

    /// Returns the axis about which a quaternion rotates.
    @inlinable public var axis: Vec3f {
        FirebladeMath.axis(self)
    }

    @inlinable public var angle: Float {
        FirebladeMath.angle(self)
    }

    /// Returns the conjugate of the quaternion `q`.
    @inlinable public var conjugate: Quat4f {
        FirebladeMath.conjugate(self)
    }

    /// Returns the inverse of the quaternion `q`.
    @inlinable public var inverse: Quat4f {
        FirebladeMath.inverse(self)
    }

    @inlinable public var normalized: Quat4f {
        FirebladeMath.normalize(self)
    }

    @inlinable public var isNaN: Bool {
        x.isNaN || y.isNaN || z.isNaN || w.isNaN
    }

    public init(angle angleRadians: Float, axis: SIMD3<Float>) {
        self = quaternion(angle: angleRadians, axis: axis)
    }

    public init(rotation matrix: Mat3x3f) {
        self = quaternion(matrix: matrix)
    }

    public init(rotation matrix: Mat4x4f) {
        self = quaternion(matrix: matrix)
    }

    public init(from: SIMD3<Float>, to: SIMD3<Float>) {
        self = quaternion(from: from, to: to)
    }

    /// Returns the rotation angle of the quaternion.
    ///
    /// NOTE: DO NOT USE simd_angle() or .angle on the quaternion since it will always produce `3.1415927`
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
