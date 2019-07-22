//
//  Mat3x3f.swift
//  
//
//  Created by Christian Treffs on 22.07.19.
//

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
}
