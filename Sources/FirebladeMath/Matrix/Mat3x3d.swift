//
//  Mat3x3d.swift
//
//
//  Created by Christian Treffs on 22.07.19.
//

#if canImport(simd)
import struct simd.matrix.simd_double3x3
public typealias Mat3x3d = simd_double3x3
#else
import struct SGLMath.Matrix3x3
public typealias Mat3x3d = SGLMath.Matrix3x3<Float64>
#endif

extension Mat3x3d {
    /*/// Create rotation matrix using an angle and a rotation axis.
     ///
     /// - Parameter angleRadians: angle to rotate about (provide in radians).
     /// - Parameter axis: axis to rotate about (will be normalized).
     public init(rotation angleRadians: Double, axis: Vec3d) {
     /// see: https://en.wikipedia.org/wiki/Rodrigues%27_rotation_formula#Matrix_notation
     let k = normalize(axis)

     let K = Mat3x3d([0.0,   k.z, -k.y],
     [-k.z,  0,    k.x],
     [k.y,  -k.x,  0])

     let K2: Mat3x3d = K * K

     let θ: Double = Double(angleRadians)
     let sinθ: Double = simd.sin(θ)
     let cosθ: Double = simd.cos(θ)

     let I: Mat3x3d = Mat3x3d(diagonal: [1,1,1])
     let A: Mat3x3d = sinθ * K
     let B: Mat3x3d = (1-cosθ) * K2

     self = I + A + B
     }

     */
}
