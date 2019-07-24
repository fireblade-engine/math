//
//  Mat3x3f.swift
//  
//
//  Created by Christian Treffs on 22.07.19.
//

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
        let cos: Float = cosf(angleRadians)
        let cosp: Float = 1.0 - cos
        let sin: Float = sinf(angleRadians)

        self.init(
            Vec3f( cos + cosp * v.x * v.x,
                   cosp * v.x * v.y + v.z * sin,
                   cosp * v.x * v.z - v.y * sin),
            Vec3f( cosp * v.x * v.y - v.z * sin,
                   cos + cosp * v.y * v.y,
                   cosp * v.y * v.z + v.x * sin),
            Vec3f( cosp * v.x * v.z + v.y * sin,
                   cosp * v.y * v.z - v.x * sin,
                   cos + cosp * v.z * v.z)
        )
    }

    public init(eulerAngles angles: Vec3f) {
        let ϕ: Float = angles.x // x
        let θ: Float = angles.y // y
        let ψ: Float = angles.z // z

        let m00: Float = cos(θ) * cos(ψ)

        let m01: Float = -cos(ϕ) * sin(ψ) + sin(ϕ) * sin(θ) * cos(ψ)
        let m02: Float = sin(ϕ) * sin(ψ) + cos(ϕ) * sin(θ) * cos(ψ)

        let m10: Float = cos(θ) * sin(ψ)
        let m11: Float = cos(ϕ) * cos(ψ) + sin(ϕ) * sin(θ) * sin(ψ)
        let m12: Float = -sin(ϕ) * cos(ψ) + cos(ϕ) * sin(θ) * sin(ψ)

        let m20: Float = -sin(θ)
        let m21: Float = sin(ϕ) * cos(θ)
        let m22: Float = cos(ϕ) * cos(θ)

        self.init(Vec3f(m00, m10, m20),
                  Vec3f(m01, m11, m21),
                  Vec3f(m02, m12, m22))
    }
    /*
    public init(eulerAngles angles: Vec3f) {
        let A       = cos(angles.x)
        let B       = sin(angles.x)
        let C       = cos(angles.y)
        let D       = sin(angles.y)
        let E       = cos(angles.z)
        let F       = sin(angles.z)
        let AD      =   A * D
        let BD      =   B * D
        
        
        self.init(
            Vec3f(C * E,
                  -C * F,
                  -D),
            Vec3f(BD * E + A * F,
                  BD * F + A * E,
                  B * C),
            Vec3f(AD * E + B * F,
                  -AD * F + B * E,
                  -A * C)
        )
    }*/

    /*
    public init(yaw: Float, pitch: Float, roll: Float) {
        
        
        
        
        let n = angles
        let yaw = n.y + radians(90)
        let pitch = n.x - radians(90)
        let roll = n.z
        let sy = sin(yaw);
        let cy = cos(yaw);
        let sp = sin(pitch)
        let cp = cos(pitch)
        let sr = sin(roll);
        let cr = cos(roll);

        self.init(
        Vec3f(cr*cy + sr*sp*sy,
              cp*sy,
              -sr*cy + cr*sp*sy),

        Vec3f(-cr*sy + sr*sp*cy,
              cp*cy,
              sr*sy + cr*sp*cy),

        Vec3f(sr*cp,
              -sp,
              cr*cp)
        )
    }*/

    @inlinable public var rotationEuler: Vec3f {
        let rotX = atan2( self[1][2], self[2][2])
        let rotY = atan2(-self[0][2], hypot(self[1][2], self[2][2]))
        let rotZ = atan2( self[0][1], self[0][0])
        return Vec3f(rotX, rotY, rotZ)
    }
}

extension Mat3x3f: IdentitiyProviding {
    public static let identity = Mat3x3f(diagonal: .one)
}
