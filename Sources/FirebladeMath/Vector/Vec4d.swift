//
//  Vec4d.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

import simd.vector

public typealias Vec4d = SIMD4<Double>

extension Vec4d {
    public static let zero = Vec4d(repeating: 0)
    public static let one = Vec4d(repeating: 1)
}
