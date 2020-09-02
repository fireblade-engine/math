//
//  SIMD4+Extensions.swift
//
//
//  Created by Christian Treffs on 25.08.19.
//

extension SIMD4: Sequence {
    public __consuming func makeIterator() -> IndexingIterator<[Scalar]> {
        [x, y, z, w].makeIterator()
    }
}

extension SIMD4 {
    @inlinable public var xyz: SIMD3<Scalar> {
        SIMD3<Scalar>(x, y, z)
    }
}

extension SIMD4 where Scalar: FloatingPoint {
    @inlinable public var isNaN: Bool {
        x.isNaN || y.isNaN || z.isNaN || w.isNaN
    }
}

extension SIMD4 where Scalar == Double {
    @inlinable public var length: Scalar {
        FirebladeMath.length(self)
    }

    @inlinable public var normalized: SIMD4<Scalar> {
        FirebladeMath.normalize(self)
    }
}

extension SIMD4 where Scalar == Float {
    @inlinable public var length: Scalar {
        FirebladeMath.length(self)
    }

    @inlinable public var normalized: SIMD4<Scalar> {
        FirebladeMath.normalize(self)
    }
}
