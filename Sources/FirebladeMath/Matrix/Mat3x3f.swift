//
//  Mat3x3f.swift
//  
//
//  Created by Christian Treffs on 22.07.19.
//

import struct simd.matrix.simd_float3x3
import func simd.normalize

public typealias Mat3x3f = simd_float3x3

extension Mat3x3f {
    public init(_ array: [Float]) {
        precondition(array.count == 9, "Matrix need exactly 9 values")
        self.init(SIMD3<Float>(array[0], array[1], array[2]),
                  SIMD3<Float>(array[3], array[4], array[5]),
                  SIMD3<Float>(array[6], array[7], array[8]))
    }

    public init(_ matrix3x3d: Mat3x3d) {
        self.init(Vec3f(matrix3x3d.columns.0),
                  Vec3f(matrix3x3d.columns.1),
                  Vec3f(matrix3x3d.columns.2))
    }

    public init(rotation angleRadians: Float, axis: Vec3f) {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        let v: Vec3f = normalize(axis)
        let _cos: Float = cos(angleRadians)
        let _cosp: Float = 1.0 - _cos
        let _sin: Float = sin(angleRadians)

        self.init(
            Vec3f( _cos + _cosp * v.x * v.x,
                   _cosp * v.x * v.y + v.z * _sin,
                   _cosp * v.x * v.z - v.y * _sin),
            Vec3f( _cosp * v.x * v.y - v.z * _sin,
                   _cos + _cosp * v.y * v.y,
                   _cosp * v.y * v.z + v.x * _sin),
            Vec3f( _cosp * v.x * v.z + v.y * _sin,
                   _cosp * v.y * v.z - v.x * _sin,
                   _cos + _cosp * v.z * v.z)
        )
    }

    public init(eulerAngles angles: Vec3f) {
        // see: https://en.wikipedia.org/wiki/Rotation_formalisms_in_three_dimensions#Conversion_formulae_between_formalisms
        // right handed coordinate system

        let sinϕ: Float = sin(angles.x)
        let sinθ: Float = sin(angles.y)
        let sinψ: Float = sin(angles.z)

        let cosϕ: Float = cos(angles.x)
        let cosθ: Float = cos(angles.y)
        let cosψ: Float = cos(angles.z)

        let m00: Float = cosθ * cosψ

        let m01: Float = -cosϕ * sinψ + sinϕ * sinθ * cosψ
        let m02: Float = sinϕ * sinψ + cosϕ * sinθ * cosψ

        let m10: Float = cosθ * sinψ
        let m11: Float = cosϕ * cosψ + sinϕ * sinθ * sinψ
        let m12: Float = -sinϕ * cosψ + cosϕ * sinθ * sinψ

        let m20: Float = -sinθ
        let m21: Float = sinϕ * cosθ
        let m22: Float = cosϕ * cosθ

        self.init(Vec3f(m00, m10, m20),
                  Vec3f(m01, m11, m21),
                  Vec3f(m02, m12, m22))
    }

    @inlinable public var rotationAngles: Vec3f {
        let rotX = atan2( self[1][2], self[2][2])
        let rotY = atan2(-self[0][2], hypot(self[1][2], self[2][2]))
        let rotZ = atan2( self[0][1], self[0][0])
        return Vec3f(rotX, rotY, rotZ)
    }
}

extension Mat3x3f: IdentitiyProviding {
    public static let identity = Mat3x3f(diagonal: .one)
}

// MARK: - euler
extension Mat3x3f {
    @inlinable public var eulerAnglesXYZ: Vec3f {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreMatrix3.cpp#L995
        let yaw: Float
        let pitch: Float = radians(asin(self[0][2]))
        let roll: Float
        if pitch < radians(.halfPi) {
            if ( pitch > radians(-.halfPi) ) {
                yaw = atan2(-self[1][2], self[2][2])
                roll = atan2(-self[0][1], self[0][0])
            } else {
                // WARNING.  Not a unique solution.
                let fRmY: Float = atan2(self[1][0], self[1][1])
                roll = radians(0.0)  // any angle works
                yaw = roll - fRmY
            }
        } else {
            // WARNING.  Not a unique solution.
            let fRpY: Float = atan2(self[1][0], self[1][1])
            roll = radians(0.0)  // any angle works
            yaw = fRpY - roll
        }

        return Vec3f(yaw, pitch, roll)
    }

    @inlinable public var eulerAnglesXZY: Vec3f {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreMatrix3.cpp#L1030
        let yaw: Float
        let pitch: Float = asin(-self[0][1])
        let roll: Float
        if ( pitch < radians(.halfPi) ) {
            if ( pitch > radians(-.halfPi) ) {
                yaw = atan2(self[2][1], self[1][1])
                roll = atan2(self[0][2], self[0][0])
            } else {
                // WARNING.  Not a unique solution.
                let fRmY: Float = atan2(-self[2][0], self[2][2])
                roll = radians(0.0)  // any angle works
                yaw = roll - fRmY
            }
        } else {
            // WARNING.  Not a unique solution.
            let fRpY: Float = atan2(-self[2][0], self[2][2])
            roll = radians(0.0)  // any angle works
            yaw = fRpY - roll
        }
        return Vec3f(yaw, pitch, roll)
    }

    @inlinable public var eulerAnglesYXZ: Vec3f {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreMatrix3.cpp#L1065
        let yaw: Float
        let pitch: Float = asin(-self[1][2])
        let roll: Float
        if ( pitch < radians(.halfPi) ) {
            if ( pitch > radians(-.halfPi) ) {
                yaw = atan2(self[0][2], self[2][2])
                roll = atan2(self[1][0], self[1][1])
            } else {
                // WARNING.  Not a unique solution.
                let fRmY: Float = atan2(-self[0][1], self[0][0])
                roll = radians(0.0)  // any angle works
                yaw = roll - fRmY
            }
        } else {
            // WARNING.  Not a unique solution.
            let fRpY: Float = atan2(-self[0][1], self[0][0])
            roll = radians(0.0)  // any angle works
            yaw = fRpY - roll
        }
        return Vec3f(yaw, pitch, roll)
    }

    @inlinable public var eulerAnglesZXY: Vec3f {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreMatrix3.cpp#L1135
        let yaw: Float
        let pitch: Float = asin(self[2][1])
        let roll: Float
        if ( pitch < radians(.halfPi) ) {
            if ( pitch > radians(-.halfPi) ) {
                yaw = atan2(-self[0][1], self[1][1])
                roll = atan2(-self[2][0], self[2][2])
            } else {
                // WARNING.  Not a unique solution.
                let fRmY: Float = atan2(self[0][2], self[0][0])
                roll = radians(0.0)  // any angle works
                yaw = roll - fRmY
            }
        } else {
            // WARNING.  Not a unique solution.
            let fRpY: Float = atan2(self[0][2], self[0][0])
            roll = radians(0.0)  // any angle works
            yaw = fRpY - roll
        }
        return Vec3f(yaw, pitch, roll)
    }

    @inlinable public var eulerAnglesZYX: Vec3f {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreMatrix3.cpp#L1170
        let yaw: Float
        let pitch: Float = asin(-self[2][0])
        let roll: Float
        if ( pitch < radians(.halfPi) ) {
            if ( pitch > radians(-.halfPi) ) {
                yaw = atan2(self[1][0], self[0][0])
                roll = atan2(self[2][1], self[2][2])
            } else {
                // WARNING.  Not a unique solution.
                let fRmY: Float = atan2(-self[0][1], self[0][2])
                roll = radians(0.0);  // any angle works
                yaw = roll - fRmY
            }
        } else {
            // WARNING.  Not a unique solution.
            let fRpY: Float = atan2(-self[0][1], self[0][2])
            roll = radians(0.0);  // any angle works
            yaw = fRpY - roll
        }

        return Vec3f(yaw, pitch, roll)
    }
}
