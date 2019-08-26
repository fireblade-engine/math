//
//  SIMD4+Extensions.swift
//
//
//  Created by Christian Treffs on 25.08.19.
//

extension SIMD4: Sequence {
    public __consuming func makeIterator() -> IndexingIterator<[Scalar]> {
        return [x, y, z, w].makeIterator()
    }
}

extension SIMD4 {
    @inlinable public var xyz: SIMD3<Scalar> {
        return SIMD3<Scalar>(x, y, z)
    }
}

extension SIMD4 where Scalar: FirebladeMath.FloatingPointScalar {
    @inlinable public var isNaN: Bool {
        return x.isNaN || y.isNaN || z.isNaN || w.isNaN
    }

    @inlinable public var length: Scalar {
        return FirebladeMath.length(self)
    }

    @inlinable public var normalized: SIMD4<Scalar> {
        return FirebladeMath.normalize(self)
    }
}

#if swift(<5.1)
extension SIMD4 {
    public init(_ vec: SIMD3<Scalar>, _ w: Scalar) {
        self.init(vec.x, vec.y, vec.z, w)
    }
}
#endif
