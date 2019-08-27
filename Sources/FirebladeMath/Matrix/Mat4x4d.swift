//
//  Mat4x4d.swift
//
//
//  Created by Christian Treffs on 22.07.19.
//

extension Mat4x4d {
    public init(_ values: [Double]) {
        precondition(values.count == 16, "Matrix needs exactly 16 values.")
        self.init([
            Vec4d(values[0...3]),
            Vec4d(values[4...7]),
            Vec4d(values[8...11]),
            Vec4d(values[12...15])
        ])
    }
}

#if !canImport(simd)
extension Mat4x4d {
    public init(_ columns: [Vec4d]) {
        self.init(columns[0],
                  columns[1],
                  columns[2],
                  columns[3])
    }
}
#endif

extension Mat4x4d {
    /*
     @inlinable public static func look(from eyePosition: Vec3d, at lookAtPosition: Vec3d, up: Vec3d) -> Mat4x4d {
     // see: https://github.com/EpicGames/UnrealEngine/blob/master/Engine/Source/Runtime/Core/Public/Math/Matrix.inl#L814

     let zAxis: Vec3d = normalize( eyePosition - lookAtPosition )
     let xAxis: Vec3d = normalize( cross(up, zAxis) )
     let yAxis: Vec3d = normalize( cross(zAxis, xAxis) )

     let dotX: Double = -dot(xAxis, eyePosition)
     let dotY: Double = -dot(yAxis, eyePosition)
     let dotZ: Double = -dot(zAxis, eyePosition)

     return Mat4x4d(
     columns:
     (
     Vec4d(xAxis.x, yAxis.x, zAxis.x, 0.0),
     Vec4d(xAxis.y, yAxis.y, zAxis.y, 0.0),
     Vec4d(xAxis.z, yAxis.z, zAxis.z, 0.0),
     Vec4d(dotX, dotY, dotZ, 1.0)
     )
     )
     }
     */
}
