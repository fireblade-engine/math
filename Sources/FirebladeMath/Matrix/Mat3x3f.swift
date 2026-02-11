extension Mat3x3f {
    /// Creates a 3x3 rotation matrix.
    /// - Parameters:
    ///   - angleRadians: The angle of rotation in radians.
    ///   - axis: The axis of rotation.
    public init(rotation angleRadians: Float, axis: SIMD3<Float>) {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        let v = normalize(axis)
        let icos = cos(angleRadians)
        let icosp = 1.0 - icos
        let isin = sin(angleRadians)

        self.init(
            Vector(icos + icosp * v.x * v.x,
                   icosp * v.x * v.y + v.z * isin,
                   icosp * v.x * v.z - v.y * isin),
            Vector(icosp * v.x * v.y - v.z * isin,
                   icos + icosp * v.y * v.y,
                   icosp * v.y * v.z + v.x * isin),
            Vector(icosp * v.x * v.z + v.y * isin,
                   icosp * v.y * v.z - v.x * isin,
                   icos + icosp * v.z * v.z)
        )
    }

    /// Returns the Euler angles (pitch, yaw, roll) for this matrix in radians.
    /// - Returns: A 3D vector where x is pitch, y is yaw, and z is roll.
    @inlinable public var eulerAngles: Vec3f {
        // https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreMatrix3.cpp#L995
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
        } else { // = +1
            // Not a unique solution: thetaZ + thetaX = atan2(self[1,0],self[1,1])
            thetaY = +.pi / 2
            thetaX = atan2(self[1, 0], self[1, 1])
            thetaZ = 0
        }

        return Vec3f(thetaX, thetaY, thetaZ)
    }
}
