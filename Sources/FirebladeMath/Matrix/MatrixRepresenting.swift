//
//  MatrixRepresenting.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if canImport(simd)

public protocol MatrixRepresenting {
    associatedtype VectorElement: VectorRepresenting

    init(diagonal: VectorElement)
    init(_ values: [VectorElement.ScalarElement])
    init(_ columns: [VectorElement])

    static var identity: Self { get }

    // TODO: var columns: [VectorElement] { get }
    // TODO: var inverted: Self { get }
    var determinant: VectorElement.ScalarElement { get }
}

extension Mat3x3d: MatrixRepresenting {
    public typealias VectorElement = Vec3d
}

extension Mat3x3f: MatrixRepresenting {
    public typealias VectorElement = Vec3f
}

extension Mat4x4d: MatrixRepresenting {
    public typealias VectorElement = Vec4d
}

extension Mat4x4f: MatrixRepresenting {
    public typealias VectorElement = Vec4f
}

#endif
