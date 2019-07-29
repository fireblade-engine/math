//
//  Vec4u.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

public typealias Vec4u = SIMD4<UInt>

extension Vec4u {
    public static let zero = Vec4u(repeating: 0)
    public static let one = Vec4u(repeating: 1)
}
