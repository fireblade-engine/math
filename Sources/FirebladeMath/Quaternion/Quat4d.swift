//
//  Quad4d.swift
//
//
//  Created by Christian Treffs on 23.07.19.
//

extension Quat4d {
    public init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
        #if canImport(simd)
        self.init(ix: x, iy: y, iz: z, r: w)
        #else
        self.init([x, y, z, w])
        #endif
    }
}

extension Quat4d: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Double...) {
        precondition(elements.count == 4, "Quaternion needs to be initialized with exactly 4 elements")
        #if canImport(simd)
        self.init(ix: elements[0], iy: elements[1], iz: elements[2], r: elements[3])
        #else
        self.init(elements)
        #endif
    }
}
