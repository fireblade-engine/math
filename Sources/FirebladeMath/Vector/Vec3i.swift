//
//  Vec3i.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

public typealias Vec3i = SIMD3<Int>

extension Vec3i {
    public static let zero = Vec3i(repeating: 0)
    public static let one = Vec3i(repeating: 1)
}
