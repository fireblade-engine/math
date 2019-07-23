//
//  Mat4x4d.swift
//  
//
//  Created by Christian Treffs on 22.07.19.
//

public typealias Mat4x4d = simd_double4x4

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

extension Mat4x4d: IdentitiyProviding {
    public static let identity = Mat4x4d(diagonal: .one)
}
