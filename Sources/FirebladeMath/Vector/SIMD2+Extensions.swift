extension SIMD2: @retroactive Sequence {}

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
