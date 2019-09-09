//
//  File.swift
//
//
//  Created by Christian Treffs on 09.09.19.
//

extension Mat3x3f {
    public init(rotation angleRadians: Float, axis: SIMD3<Float>) {
        let quat = Quat4f(angle: angleRadians, axis: axis)
        self = matrix3x3(from: quat)
    }
}
