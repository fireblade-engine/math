//
//  Mat4x4f+Transforms.swift
//  FirebladeGFX
//
//  Created by Christian Treffs on 27.01.18.
//  Copyright © 2018 Fireblade. All rights reserved.
//

import simd

// SEE: https://github.com/g-truc/glm/blob/master/glm/gtc/matrix_transform.inl
public extension Mat4x4f {

	/// Creates a perspective projection matrix
	///
	/// - Parameters:
	///   - fovy: field of view
	///   - aspect: aspect ratio
	///   - zNear: near plane
	///   - zFar: far plane
	/// - Returns: perspective projection matrix
	static func perspectiveProjection(fovy: AngleRadians, aspect: Float, zNear: Float, zFar: Float) -> Mat4x4f {
		assert(aspect > 0.0)
		assert(zNear > 0.0)
		assert(zFar > zNear)
		assert(fovy > AngleRadians(0.0))
		//TODO: Float.pi - FLT_EPSILON
		//TODO: precondition(fovy <= Angle<T>(radians: T.pi - T.epsilon))

		switch COORDINATE_SYSTEM {
		case .leftHanded:
			return perspectiveProjectionLH(fovy: fovy, aspect: aspect, zNear: zNear, zFar: zFar)
		case .rightHanded:
			return perspectiveProjectionRH(fovy: fovy, aspect: aspect, zNear: zNear, zFar: zFar)
		}
	}

	static func rotation(radians: Float, axis: Vec3f) -> Mat4x4f {
		let unitAxis: Vec3f = normalize(axis)
		let ct: Float = cos(radians)
		let st: Float = sin(radians)
		let ci = 1 - ct
		let x = unitAxis.x, y = unitAxis.y, z = unitAxis.z
		return Mat4x4f.init(columns:(Vec4f(    ct + x * x * ci, y * x * ci + z * st, z * x * ci - y * st, 0),
									 Vec4f(x * y * ci - z * st, ct + y * y * ci, z * y * ci + x * st, 0),
									 Vec4f(x * z * ci + y * st, y * z * ci - x * st, ct + z * z * ci, 0),
									 Vec4f(                  0, 0, 0, 1)))
	}

	static func translation(_ position: Vec3f) -> Mat4x4f {
		return Mat4x4f.init(columns:(Vec4f(1, 0, 0, 0),
									 Vec4f(0, 1, 0, 0),
									 Vec4f(0, 0, 1, 0),
									 Vec4f(position.x, position.y, position.z, 1)))
	}
}

// MARK: - private

private extension Mat4x4f {
	static func perspectiveProjectionLH(fovy: AngleRadians, aspect: Float, zNear: Float, zFar: Float) -> Mat4x4f {
		var m: Mat4x4f = Mat4x4f(0.0)

		let tanHalfFovy: Float = tan(fovy * 0.5)

		m[0][0] = 1.0 / (aspect * tanHalfFovy)
		m[1][1] = 1.0 / tanHalfFovy
		m[2][3] = 1.0

		switch DEPTH_CLIP_SPACE {
		case .zeroToOne:
			m[2][2] = zFar / (zFar - zNear)
			m[3][2] = -(zFar * zNear) / (zFar - zNear)
		case .negOneToOne:
			m[2][2] = (zFar + zNear) / (zFar - zNear)
			m[3][2] = -(zFar * zNear * 2.0) / (zFar - zNear)
		}

		return m
	}

	static func perspectiveProjectionRH(fovy: AngleRadians, aspect: Float, zNear: Float, zFar: Float) -> Mat4x4f {
		var m: Mat4x4f = Mat4x4f(0.0)

		let tanHalfFovy: Float = tan(fovy * 0.5)

		m[0][0] = 1.0 / (aspect * tanHalfFovy)
		m[1][1] = 1.0 / tanHalfFovy
		m[2][3] = -1.0

		switch DEPTH_CLIP_SPACE {
		case .zeroToOne:
			m[2][2] = zFar / (zNear - zFar)
			m[3][2] = -(zFar * zNear) / (zFar - zNear)
		case .negOneToOne:
			m[2][2] = -(zFar + zNear) / (zFar - zNear)
			m[3][2] = -(zFar * zNear * 2.0) / (zFar - zNear)
		}

		return m
	}
}

// FIXME: --- refactor
func matrix_perspective_right_hand(fovyRadians fovy: Float, aspectRatio: Float, nearZ: Float, farZ: Float) -> matrix_float4x4 {
	let ys = 1 / tanf(fovy * 0.5)
	let xs = ys / aspectRatio
	let zs = farZ / (nearZ - farZ)
	return matrix_float4x4.init(columns:(vector_float4(xs, 0, 0, 0),
										 vector_float4( 0, ys, 0, 0),
										 vector_float4( 0, 0, zs, -1),
										 vector_float4( 0, 0, zs * nearZ, 0)))
}

func radians_from_degrees(_ degrees: Float) -> Float {
	return (degrees / 180) * .pi
}
