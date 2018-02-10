//
//  Types.swift
//  FirebladeGFX
//
//  Created by Christian Treffs on 27.01.18.
//  Copyright © 2018 Fireblade. All rights reserved.
//

import simd

public let COORDINATE_SYSTEM: CoordinateSystem = .rightHanded
public let DEPTH_CLIP_SPACE: DepthClipSpaceCoordinates = .zeroToOne

public typealias Vec2f = float2
public typealias Vec3f = float3
public typealias Vec4f = float4

public typealias Mat3x3f = float3x3
public typealias Mat4x4f = float4x4

public typealias AngleDegree = Float
public typealias AngleRadians = Float

public enum CoordinateSystem {
	case leftHanded
	case rightHanded
}

/*OpenGL uses different clip-space coordinates than Metal (in GL, z goes from -1 to 1, while in Metal z goes from 0 to 1), so using GLKMatrix4MakePerspective doesn't give you a matrix that properly transforms from eye space to clip space.*/
public enum DepthClipSpaceCoordinates {
	case zeroToOne // Metal default: [0 - 1]
	case negOneToOne // OpenGL default: [-1 - 1]
}
