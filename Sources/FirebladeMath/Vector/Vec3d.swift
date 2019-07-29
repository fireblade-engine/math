//
//  Vec3d.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

import simd.vector

public typealias Vec3d = SIMD3<Double>

extension Vec3d {
    public static let zero = Vec3d(repeating: 0)
    public static let one = Vec3d(repeating: 1)
}

extension Vec3d {
    public static let axisX: Vec3d = [1, 0, 0]
    public static let axisY: Vec3d = [0, 1, 0]
    public static let axisZ: Vec3d = [0, 0, 1]
}
