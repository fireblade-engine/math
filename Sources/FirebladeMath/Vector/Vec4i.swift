//
//  Vec4i.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

public typealias Vec4i = SIMD4<Int>

extension Vec4i {
    public static let zero = Vec4i(repeating: 0)
    public static let one = Vec4i(repeating: 1)
}
