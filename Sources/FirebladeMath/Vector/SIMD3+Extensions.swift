extension SIMD3: @retroactive Sequence {}

extension SIMD3 where Scalar: FloatingPoint {
    @inlinable public var isNaN: Bool {
        x.isNaN || y.isNaN || z.isNaN
    }
}

extension SIMD3 where Scalar == Double {
    @inlinable public var length: Scalar {
        FirebladeMath.length(self)
    }

    @inlinable public var normalized: SIMD3<Scalar> {
        FirebladeMath.normalize(self)
    }

    @inlinable
    public func normalize() -> SIMD3<Scalar> {
        FirebladeMath.normalize(self)
    }

    @inlinable
    public func cross(_ other: SIMD3<Scalar>) -> SIMD3<Scalar> {
        FirebladeMath.cross(self, other)
    }

    @inlinable
    public func dot(_ other: SIMD3<Scalar>) -> Scalar {
        FirebladeMath.dot(self, other)
    }
}

extension SIMD3 where Scalar == Float {
    @inlinable public var length: Scalar {
        FirebladeMath.length(self)
    }

    @inlinable public var normalized: SIMD3<Scalar> {
        FirebladeMath.normalize(self)
    }

    @inlinable
    public func normalize() -> SIMD3<Scalar> {
        FirebladeMath.normalize(self)
    }

    @inlinable
    public func cross(_ other: SIMD3<Scalar>) -> SIMD3<Scalar> {
        FirebladeMath.cross(self, other)
    }

    @inlinable
    public func dot(_ other: SIMD3<Scalar>) -> Scalar {
        FirebladeMath.dot(self, other)
    }
}
