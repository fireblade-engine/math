//
//  SIMD2+Extensions.swift
//
//
//  Created by Christian Treffs on 25.08.19.
//

extension SIMD2: Sequence {
    public __consuming func makeIterator() -> IndexingIterator<[Scalar]> {
        [x, y].makeIterator()
    }
}

extension SIMD2 where Scalar: FloatingPoint {
    @inlinable public var isNaN: Bool {
        x.isNaN || y.isNaN
    }
}

extension SIMD2 where Scalar == Double {
    @inlinable public var length: Scalar {
        FirebladeMath.length(self)
    }

    @inlinable public var normalized: SIMD2<Scalar> {
        normalize(self)
    }
}

extension SIMD2 where Scalar == Float {
    @inlinable public var length: Scalar {
        FirebladeMath.length(self)
    }

    @inlinable public var normalized: SIMD2<Scalar> {
        normalize(self)
    }
}
