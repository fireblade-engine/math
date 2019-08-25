//
//  Vector4.swift
//  
//
//  Created by Christian Treffs on 23.08.19.
//

extension SIMD {
    @inlinable public var elements: [Scalar] {
        return (0..<scalarCount).map { self[$0] }
    }
}
