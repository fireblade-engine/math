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

public let kDegreeToRadians32 = Float32.pi / 180.0
public let kDegreeToRadians64 = Float64.pi / 180.0

public let kRadiansToDegree32: Float32 = 180.0 / Float32.pi
public let kRadiansToDegree64: Float64 = 180.0 / Float64.pi

public typealias Vec2u = SIMD2<UInt> //uint2
public typealias Vec3u = SIMD3<UInt> //uint3
public typealias Vec4u = SIMD4<UInt> //uint4

public typealias Vec2i = SIMD2<Int> //int2
public typealias Vec3i = SIMD3<Int> //int3
public typealias Vec4i = SIMD4<Int> //int4

public typealias Vec2f = SIMD2<Float> //float2
public typealias Vec3f = SIMD3<Float> //float3
public typealias Vec4f = SIMD4<Float> //float4

public typealias Mat2x2f = float2x2
public typealias Mat3x3f = float3x3
public typealias Mat4x4f = float4x4

public typealias Quat4f = simd_quatf

public typealias AngleDegree = Float
public typealias AngleRadians = Float

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
