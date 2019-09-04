//
//  Mat3x3f.swift
//
//
//  Created by Christian Treffs on 22.07.19.
//

extension Mat3x3f {
    public init(_ values: [Float]) {
        precondition(values.count == 9, "Matrix needs exactly 9 values")
        self.init([Vec3f(values[0...2]),
                   Vec3f(values[3...5]),
                   Vec3f(values[6...8])])
    }
}

extension Mat3x3f: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Float...) {
        self.init(elements)
    }
}

extension Mat3x3f: Sequence {
    public __consuming func makeIterator() -> IndexingIterator<[Float]> {
        return [columns.0, columns.1, columns.2].flatMap { $0 }.makeIterator()
    }

    @inlinable public var elements: [Float] {
        return [Float](self)
    }
}

extension Mat3x3f {
    public init(rotation angleRadians: Float, axis: Vec3f) {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        let v: Vec3f = normalize(axis)
        let icos: Float = cos(angleRadians)
        let icosp: Float = 1.0 - icos
        let isin: Float = sin(angleRadians)

        self.init(
            Vec3f( icos + icosp * v.x * v.x,
                   icosp * v.x * v.y + v.z * isin,
                   icosp * v.x * v.z - v.y * isin),
            Vec3f( icosp * v.x * v.y - v.z * isin,
                   icos + icosp * v.y * v.y,
                   icosp * v.y * v.z + v.x * isin),
            Vec3f( icosp * v.x * v.z + v.y * isin,
                   icosp * v.y * v.z - v.x * isin,
                   icos + icosp * v.z * v.z)
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
        if pitch < radians(.halfPi) {
            if pitch > radians(-.halfPi) {
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
        if  pitch < radians(.halfPi) {
            if pitch > radians(-.halfPi) {
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
        if  pitch < radians(.halfPi) {
            if pitch > radians(-.halfPi) {
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
        if pitch < radians(.halfPi) {
            if pitch > radians(-.halfPi) {
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
