//
//  SIMD3.swift
//
//
//  Created by Christian Treffs on 25.08.19.
//

extension SIMD3: Sequence {
    public __consuming func makeIterator() -> IndexingIterator<[Scalar]> {
        return [x, y, z].makeIterator()
    }
}

extension SIMD3 where Scalar: FirebladeMath.FloatingPointScalar {
    @inlinable public var isNaN: Bool {
        return x.isNaN || y.isNaN || z.isNaN
    }

    @inlinable public var length: Scalar {
        return FirebladeMath.length(self)
    }

    @inlinable public var normalized: SIMD3<Scalar> {
        return FirebladeMath.normalize(self)
    }
}
