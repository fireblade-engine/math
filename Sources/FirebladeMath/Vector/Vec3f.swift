//
//  Vec3f.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

import simd.vector

public typealias Vec3f = SIMD3<Float>

extension Vec3f {
    public static let zero = Vec3f(repeating: 0)
    public static let one = Vec3f(repeating: 1)
}

extension Vec3f {
    public static let axisX: Vec3f = [1, 0, 0]
    public static let axisY: Vec3f = [0, 1, 0]
    public static let axisZ: Vec3f = [0, 0, 1]
}
