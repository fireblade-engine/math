//
//  VectorRepresenting.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

public protocol VectorRepresenting {
    associatedtype ScalarElement: FirebladeMath.Scalar

    init(_ values: [ScalarElement])
}

extension SIMD2: VectorRepresenting where Scalar: FirebladeMath.Scalar {
    public typealias ScalarElement = Scalar
}

extension SIMD3: VectorRepresenting where Scalar: FirebladeMath.Scalar {
    public typealias ScalarElement = Scalar
}

extension SIMD4: VectorRepresenting where Scalar: FirebladeMath.Scalar {
    public typealias ScalarElement = Scalar
}
