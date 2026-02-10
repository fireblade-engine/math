#if FRB_MATH_USE_SIMD
import simd
#endif

extension Mat3x3d {
    public init(rotation angleRadians: Double, axis: SIMD3<Double>) {
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

    /// x: pitch, y: yaw, z: roll
    /// Returns the euler angles for this matrix.
    ///
    /// - Returns: euler angles.
    @inlinable public var eulerAngles: Vec3d {
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
        } else { // = +1
            thetaY = +.pi / 2
            thetaX = atan2(self[1, 0], self[1, 1])
            thetaZ = 0
        }

        return Vec3d(thetaX, thetaY, thetaZ)
    }
}
