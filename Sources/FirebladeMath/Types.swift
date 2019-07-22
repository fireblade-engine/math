//
//  Types.swift
//  FirebladeGFX
//
//  Created by Christian Treffs on 27.01.18.
//  Copyright © 2018 Fireblade. All rights reserved.
//

@_exported import simd

public let kCoordinateSystem: CoordinateSystem = .rightHanded
public let kDepthClipSpace: DepthClipSpaceCoordinates = .zeroToOne

public let kDegreeToRadians64 = Float64.pi / 180.0
public let kDegreeToRadians32 = Float32(kDegreeToRadians64)

public let kRadiansToDegree64: Float64 = 180.0 / Float64.pi
public let kRadiansToDegree32 = Float32(kRadiansToDegree64)

public typealias Mat3x3d = simd_double3x3
public typealias Mat3x3f = simd_float3x3

public typealias Mat4x4d = simd_double4x4
public typealias Mat4x4f = simd_float4x4

public typealias Quat4d = simd_quatd
public typealias Quat4f = simd_quatf

public typealias Vec2d = SIMD2<Double>
public typealias Vec2f = SIMD2<Float>
public typealias Vec2i = SIMD2<Int>
public typealias Vec2u = SIMD2<UInt>

public typealias Vec3d = SIMD3<Double>
public typealias Vec3f = SIMD3<Float>
public typealias Vec3i = SIMD3<Int>
public typealias Vec3u = SIMD3<UInt>

public typealias Vec4d = SIMD4<Double>
public typealias Vec4f = SIMD4<Float>
public typealias Vec4i = SIMD4<Int>
public typealias Vec4u = SIMD4<UInt>

public enum CoordinateSystem {
    case leftHanded
    case rightHanded
}

/// OpenGL uses different clip space coordinates than Metal.
/// In OpenGL, z goes from -1 to 1, while in Metal z goes from 0 to 1).
///
/// - zeroToOne: clip space [0...1] (Metal default)
/// - negOneToOne: clip space [-1...1] (OpenGL default)
public enum DepthClipSpaceCoordinates {
    /// clip space [0...1] (Metal default)
    case zeroToOne
    /// clip space [-1...1] (OpenGL default)
    case negOneToOne
}
