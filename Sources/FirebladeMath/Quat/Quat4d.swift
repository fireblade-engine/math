//
//  Quat4d.swift
//
//
//  Created by Christian Treffs on 01.11.20.
//

extension Quat4d {
    @inlinable public init(_ quat: Quat4f) {
        self.init(Double(quat.x), Double(quat.y), Double(quat.z), Double(quat.w))
    }

    @inlinable public var normalized: Quat4d {
        normalize(self)
    }

    /// The length of the quaternion `q`.
    @inlinable public var length: Double {
        FirebladeMath.length(self)
    }

    /// Returns the axis about which a quaternion rotates.
    @inlinable public var axis: Vec3d {
        FirebladeMath.axis(self)
    }

    @inlinable public var angle: Double {
        FirebladeMath.angle(self)
    }

    @inlinable public var inverse: Quat4d {
        FirebladeMath.inverse(self)
    }

    @inlinable public var conjugate: Quat4d {
        FirebladeMath.conjugate(self)
    }

    @inlinable public var isNaN: Bool {
        x.isNaN || y.isNaN || z.isNaN || w.isNaN
    }

    public init(angle angleRadians: Double, axis: SIMD3<Double>) {
        self = quaternion(angle: angleRadians, axis: axis)
    }

    public init(rotation matrix: Mat3x3d) {
        self = quaternion(matrix: matrix)
    }

    public init(rotation matrix: Mat4x4d) {
        self = quaternion(matrix: matrix)
    }

    public init(from: SIMD3<Double>, to: SIMD3<Double>) {
        self = quaternion(from: from, to: to)
    }

    public init(yaw: Double, pitch: Double, roll: Double) {
        /// https://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles
        // Abbreviations for the various angular functions
        let cy: Double = cos(roll * 0.5)
        let sy: Double = sin(roll * 0.5)
        let cp: Double = cos(yaw * 0.5)
        let sp: Double = sin(yaw * 0.5)
        let cr: Double = cos(pitch * 0.5)
        let sr: Double = sin(pitch * 0.5)

        let w: Double = cy * cp * cr + sy * sp * sr
        let x: Double = cy * cp * sr - sy * sp * cr
        let y: Double = sy * cp * sr + cy * sp * cr
        let z: Double = sy * cp * cr - cy * sp * sr
        self.init(x, y, z, w)
    }

    /// Calculate the local yaw element of this quaternion in radians.
    ///
    /// Returns the 'intuitive' result that is, if you projected the local Z of the quaternion onto the ZX plane,
    /// the angle between it and global Z is returned.
    /// The co-domain of the returned value is from -180 to 180 degrees.
    ///
    /// Yaw would be left/right rotation around the Y axis (vertical) on the XZ plane.
    /// Yaw is used when driving a car.
    @inlinable public var yaw: Double {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L508
        asin(-2 * (x * z - w * y))
    }

    /// Calculate the local pitch element of this quaternion in radians.
    ///
    /// Returns the 'intuitive' result that is, if you projected the local Y of the quaternion onto the YZ plane,
    /// the angle between it and global Y is returned.
    /// The co-domain of the returned value is from -180 to 180 degrees.
    ///
    /// Pitch is up/down rotation around the X axis (horizontal, pointing right) on the YZ plane.
    /// Pitch is used when flying a jet down or up, or when driving up hill or down.
    @inlinable public var pitch: Double {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L484
        atan2(2.0 * (y * z + w * x), w * w - x * x - y * y + z * z)
    }

    /// Calculate the local roll element of this quaternion in radians.
    ///
    /// Returns the 'intuitive' result that is, if you projected the local X of the quaternion onto the XY plane,
    /// the angle between it and global X is returned.
    /// The co-domain of the returned value is from -180 to 180 degrees.
    ///
    /// Roll is tilt rotation around the Z axis (pointing towards you) on the XY plane.
    /// Roll is literally what happens to your car when you take a curve too fast!
    @inlinable public var roll: Double {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L459
        atan2(2.0 * (x * y + w * z), w * w + x * x - y * y - z * z)
    }

    /// x: yaw, y: pitch, z: roll
    @inlinable public var eulerAngles: Vec3d {
        /// https://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles

        let sinrcosp: Double = +2.0 * (w * x + y * z)
        let cosrcosp: Double = +1.0 - 2.0 * (x * x + y * y)
        let pitch: Double = atan2(sinrcosp, cosrcosp)

        // y-axis rotation
        let sinp: Double = +2.0 * (w * y - z * x)
        let yaw: Double
        if abs(sinp) >= 1 {
            yaw = copysign(.pi / 2.0, sinp) // use 90 degrees if out of range
        } else {
            yaw = asin(sinp)
        }

        // z-axis rotation
        let sinycosp: Double = +2.0 * (w * z + x * y)
        let cosycosp: Double = +1.0 - 2.0 * (y * y + z * z)
        let roll = atan2(sinycosp, cosycosp)

        return Vec3d(yaw, pitch, roll)
    }

    /// Returns the rotation angle of the quaternion in radians.
    ///
    /// NOTE: DO NOT USE simd_angle() or .angle on the quaternion since it will always produce `3.1415927`
    @inlinable public var rotationAngle: Double {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L126

        // The quaternion representing the rotation is
        //   q = cos(A/2)+sin(A/2)*(x*i+y*j+z*k)
        let angle: Double
        let fSqrLength: Double = x * x + y * y + z * z
        if  fSqrLength > 0.0 {
            angle = 2.0 * acos(w)
        } else {
            // angle is 0 (mod 2*pi), so any axis will do
            angle = radians(0.0)
        }

        return angle
    }

    /// The (multiplicative) inverse of the quaternion `q`.
    /*@inlinable public var inverse: Quat4d {
     return simd_inverse(self)
     }*/
}
