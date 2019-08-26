//
//  Quat4f.swift
//
//
//  Created by Christian Treffs on 23.07.19.
//

#if canImport(simd)
import func Darwin.C.copysign

import func simd.simd_axis
import func simd.simd_conjugate

import func simd.simd_inverse
import func simd.simd_length

import func simd.simd_normalize
import func simd.simd_quaternion

import struct simd.quaternion.simd_quatf

#endif

extension Quat4f {
    public init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
        #if canImport(simd)
        self.init(ix: x, iy: y, iz: z, r: w)
        #else
        self.init([x, y, z, w])
        #endif
    }
}

#if canImport(simd)
extension Quat4f: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Float...) {
        precondition(elements.count == 4, "Quaternion needs to be initialized with exactly 4 elements")
        self.init(ix: elements[0], iy: elements[1], iz: elements[2], r: elements[3])
    }
}
#endif

#if canImport(simd)
extension Quat4f {
    @inlinable public var x: Float { return self.imag.x }
    @inlinable public var y: Float { return self.imag.y }
    @inlinable public var z: Float { return self.imag.z }
    @inlinable public var w: Float { return self.real }
}
#endif

extension Quat4f {
    /// Constructs a quaternion from a four-element vector.
    /// - Parameter vector: A four-element vector.
    ///
    /// Note that the imaginary (vector) part of the quaternion comes
    /// from lanes 0, 1, and 2 of the vector, and the real (scalar) part comes from
    /// lane 3.
    public init(_ vector: Vec4f) {
        self = simd_quaternion(vector)
    }

    /*
     /// Construct a quaternion that rotates from one vector to another.
     /// - Parameter from: A normalized three-element vector.
     /// - Parameter to: A normalized three-element vector.
     ///
     /// The rotation axis is `simd_cross(from, to)`. If `from` and
     /// `to` point in opposite directions (to within machine precision), an
     ///  arbitrary rotation axis is chosen, and the angle is pi radians.
     public init(from: Vec3f, to: Vec3f) {
     self = simd_quaternion(from, to)
     }*/

    /// Construct a quaternion from a 4x4 rotation `matrix`.
    /// - Parameter matrix: A rotation matrix
    ///
    /// The last row and column of the matrix are ignored. This
    /// function is equivalent to calling simd_quaternion with the upper-left 3x3
    /// submatrix
    public init(rotation matrix: Mat4x4f) {
        self = simd_quaternion(matrix)
    }

    /*
     public init(yaw: Float, pitch: Float, roll: Float) {
     let atCos: Float = cos(roll / 2)
     let atSin: Float = sin(roll / 2)
     let leftCos: Float = cos(pitch / 2)
     let leftSin: Float = sin(pitch / 2)
     let upCos: Float = cos(yaw / 2)
     let upSin: Float = sin(yaw / 2)
     let atLeftCos: Float = atCos * leftCos
     let atLeftSin: Float = atSin * leftSin

     let X: Float = atSin * leftCos * upCos + atCos * leftSin * upSin
     let Y: Float = atCos * leftSin * upCos - atSin * leftCos * upSin
     let Z: Float = atLeftCos * upSin + atLeftSin * upCos
     let W: Float = atLeftCos * upCos - atLeftSin * upSin

     self.init(ix: X, iy: Y, iz: Z, r: W)
     }
     */

    /*
     public init(yaw: Float, pitch: Float, roll: Float) {
     self = Quat4f(angle: yaw, axis: .axisY) * Quat4f(angle: pitch, axis: .axisX) * Quat4f(angle: roll, axis: .axisZ)
     }*/

    public init(yaw: Float, pitch: Float, roll: Float) {
        /// https://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles
        // Abbreviations for the various angular functions
        let cy: Float = cos(roll * 0.5)
        let sy: Float = sin(roll * 0.5)
        let cp: Float = cos(yaw * 0.5)
        let sp: Float = sin(yaw * 0.5)
        let cr: Float = cos(pitch * 0.5)
        let sr: Float = sin(pitch * 0.5)

        let w: Float = cy * cp * cr + sy * sp * sr
        let x: Float = cy * cp * sr - sy * sp * cr
        let y: Float = sy * cp * sr + cy * sp * cr
        let z: Float = sy * cp * cr - cy * sp * sr

        self.init(x, y, z, w)
    }
}
extension Quat4f {
    /// Calculate the local yaw element of this quaternion in radians.
    ///
    /// Returns the 'intuitive' result that is, if you projected the local Z of the quaternion onto the ZX plane,
    /// the angle between it and global Z is returned.
    /// The co-domain of the returned value is from -180 to 180 degrees.
    ///
    /// Yaw would be left/right rotation around the Y axis (vertical) on the XZ plane.
    /// Yaw is used when driving a car.
    @inlinable public var yaw: Float {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L508
        //let fTx: Float  = 2.0*x
        //let fTy: Float  = 2.0*y
        //let fTz: Float  = 2.0*z
        //let fTwy: Float = fTy*w
        //let fTxx: Float = fTx*x
        //let fTxz: Float = fTz*x
        //let fTyy: Float = fTy*y
        //return atan2(fTxz+fTwy, 1.0-(fTxx+fTyy))

        return asin(-2 * (x * z - w * y))
    }

    /// Calculate the local pitch element of this quaternion in radians.
    ///
    /// Returns the 'intuitive' result that is, if you projected the local Y of the quaternion onto the YZ plane,
    /// the angle between it and global Y is returned.
    /// The co-domain of the returned value is from -180 to 180 degrees.
    ///
    /// Pitch is up/down rotation around the X axis (horizontal, pointing right) on the YZ plane.
    /// Pitch is used when flying a jet down or up, or when driving up hill or down.
    @inlinable public var pitch: Float {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L484
        //let fTx: Float  = 2.0*x
        //let fTz: Float  = 2.0*z
        //let fTwx: Float = fTx*w
        //let fTxx: Float = fTx*x
        //let fTyz: Float = fTz*y
        //let fTzz: Float = fTz*z
        //return atan2(fTyz+fTwx, 1.0-(fTxx+fTzz))

        return atan2(2.0 * (y * z + w * x), w * w - x * x - y * y + z * z)
    }

    /// Calculate the local roll element of this quaternion in radians.
    ///
    /// Returns the 'intuitive' result that is, if you projected the local X of the quaternion onto the XY plane,
    /// the angle between it and global X is returned.
    /// The co-domain of the returned value is from -180 to 180 degrees.
    ///
    /// Roll is tilt rotation around the Z axis (pointing towards you) on the XY plane.
    /// Roll is literally what happens to your car when you take a curve too fast!
    @inlinable public var roll: Float {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L459
        //let fTy: Float  = 2.0*y
        //let fTz: Float  = 2.0*z
        //let fTwz: Float = fTz*w
        //let fTxy: Float = fTy*x
        //let fTyy: Float = fTy*y
        //let fTzz: Float = fTz*z
        //return atan2(fTxy+fTwz, 1.0-(fTyy+fTzz))

        return atan2(2.0 * (x * y + w * z), w * w + x * x - y * y - z * z)
    }

    /// x: yaw, y: pitch, z: roll
    @inlinable public var eulerAngles: Vec3f {
        /// https://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles

        let sinr_cosp: Float = +2.0 * (w * x + y * z)
        let cosr_cosp: Float = +1.0 - 2.0 * (x * x + y * y)
        let pitch: Float = atan2(sinr_cosp, cosr_cosp)

        // y-axis rotation
        let sinp: Float = +2.0 * (w * y - z * x)
        let yaw: Float
        if abs(sinp) >= 1 {
            yaw = copysign(.pi / 2.0, sinp) // use 90 degrees if out of range
        } else {
            yaw = asin(sinp)
        }

        // z-axis rotation
        let siny_cosp: Float = +2.0 * (w * z + x * y)
        let cosy_cosp: Float = +1.0 - 2.0 * (y * y + z * z)
        let roll = atan2(siny_cosp, cosy_cosp)

        return Vec3f(yaw, pitch, roll)
    }
}

extension Quat4f {
    /// Returns the rotation angle of the quaternion in radians.
    ///
    /// NOTE: DO NOT USE simd_angle() or .angle on the quaternion since it will always produce `3.1415927`
    @inlinable public var rotationAngle: Float {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L126

        // The quaternion representing the rotation is
        //   q = cos(A/2)+sin(A/2)*(x*i+y*j+z*k)
        let angle: Float
        let fSqrLength: Float = x * x + y * y + z * z
        if ( fSqrLength > 0.0 ) {
            angle = 2.0 * acos(w)
        } else {
            // angle is 0 (mod 2*pi), so any axis will do
            angle = radians(0.0)
        }

        return angle
    }

    /// The normalized axis (a 3-element vector) around which the action of the quaternion `q` rotates.
    @inlinable public var axis: Vec3f {
        return simd_axis(self)
    }

    @inlinable public var rotationAxis: Vec3f {
        return self.axis
    }

    /// The conjugate of the quaternion `q`.
    @inlinable public var conjugate: Quat4f {
        return simd_conjugate(self)
    }

    /// The (multiplicative) inverse of the quaternion `q`.
    /*@inlinable public var inverse: Quat4f {
     return simd_inverse(self)
     }*/

    /// The length of the quaternion `q`.
    @inlinable public var length: Float {
        return simd_length(self)
    }

    @inlinable public var isNaN: Bool {
        return x.isNaN || y.isNaN || z.isNaN || w.isNaN
    }
}

// MARK: - operators
extension Quat4f {
    /*
     simd_act(_ q: simd_quatf, _ v: simd_float3) -> simd_float3
     simd_add(_ p: simd_quatf, _ q: simd_quatf) -> simd_quatf
     simd_angle(_ q: simd_quatf) -> Float
     simd_axis(_ q: simd_quatf) -> simd_float3
     simd_bezier(_ q0: simd_quatf, _ q1: simd_quatf, _ q2: simd_quatf, _ q3: simd_quatf, _ t: Float) -> simd_quatf
     simd_conjugate(_ q: simd_quatf) -> simd_quatf
     simd_dot(_ p: simd_quatf, _ q: simd_quatf) -> Float
     simd_imag(_ q: simd_quatf) -> simd_float3
     simd_inverse(_ q: simd_quatf) -> simd_quatf
     simd_length(_ q: simd_quatf) -> Float
     simd_mul(_ a: Float, _ q: simd_quatf) -> simd_quatf
     simd_mul(_ p: simd_quatf, _ q: simd_quatf) -> simd_quatf
     simd_mul(_ q: simd_quatf, _ a: Float) -> simd_quatf
     simd_negate(_ q: simd_quatf) -> simd_quatf
     simd_normalize(_ q: simd_quatf) -> simd_quatf
     simd_quaternion(_ angle: Float, _ axis: simd_float3) -> simd_quatf
     simd_quaternion(_ from: simd_float3, _ to: simd_float3) -> simd_quatf
     simd_quaternion(_ ix: Float, _ iy: Float, _ iz: Float, _ r: Float) -> simd_quatf
     simd_quaternion(_ matrix: simd_float3x3) -> simd_quatf
     simd_quaternion(_ matrix: simd_float4x4) -> simd_quatf
     simd_quaternion(_ xyzr: simd_float4) -> simd_quatf
     simd_quaternion(_ xyzr: UnsafePointer<Float>!) -> simd_quatf
     simd_real(_ q: simd_quatf) -> Float
     simd_slerp(_ q0: simd_quatf, _ q1: simd_quatf, _ t: Float) -> simd_quatf
     simd_slerp_longest(_ q0: simd_quatf, _ q1: simd_quatf, _ t: Float) -> simd_quatf
     simd_spline(_ q0: simd_quatf, _ q1: simd_quatf, _ q2: simd_quatf, _ q3: simd_quatf, _ t: Float) -> simd_quatf
     simd_sub(_ p: simd_quatf, _ q: simd_quatf) -> simd_quatf
     */
}
