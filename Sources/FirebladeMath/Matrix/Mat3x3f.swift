//
//  Mat3x3f.swift
//
//
//  Created by Christian Treffs on 09.09.19.
//

extension Mat3x3f {
    public init(rotation angleRadians: Float, axis: SIMD3<Float>) {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        let v: Vector = normalize(axis)
        let icos: Storage.Value = cos(angleRadians)
        let icosp: Storage.Value = 1.0 - icos
        let isin: Storage.Value = sin(angleRadians)

        self.init(
            Vector( icos + icosp * v.x * v.x,
                    icosp * v.x * v.y + v.z * isin,
                    icosp * v.x * v.z - v.y * isin),
            Vector( icosp * v.x * v.y - v.z * isin,
                    icos + icosp * v.y * v.y,
                    icosp * v.y * v.z + v.x * isin),
            Vector( icosp * v.x * v.z + v.y * isin,
                    icosp * v.y * v.z - v.x * isin,
                    icos + icosp * v.z * v.z)
        )
    }

    @inlinable public var transposed: Mat3x3f {
        transpose(self)
    }

    @inline(__always) public var eulerAnglesXYZ: Vec3f {
        // /// https://www.geometrictools.com/Documentation/EulerAngles.pdf
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
        } else { // self[0,2] = +1
            // Not a unique solution: thetaZ + thetaX = atan2(self[1,0],self[1,1])
            thetaY = +.pi / 2
            thetaX = atan2(self[1, 0], self[1, 1])
            thetaZ = 0
        }

        return Vec3f(thetaX, thetaY, thetaZ)
    }

    /*public init(rotation angleRadians: Float, axis: SIMD3<Float>) {
     let quat = Quat4f(angle: angleRadians, axis: axis)
     self = matrix3x3(from: quat)
     }*/
}
