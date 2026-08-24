extension Float {
    /// Remaps this value from one range to another, clamping the input to the input range.
    /// - Parameters:
    ///   - rangeClamp: The input range to clamp to.
    ///   - rangeOut: The output range to map to.
    /// - Returns: The remapped value.
    @inlinable
    public func remaped(clampingIn rangeClamp: ClosedRange<Float>, to rangeOut: ClosedRange<Float>) -> Float {
        var v: Float = clamped(to: rangeClamp)
        v = v.lerped(from: rangeClamp, to: rangeOut)
        return v
    }

    /// Remaps this value from one range to another in place, clamping the input to the input range.
    /// - Parameters:
    ///   - rangeClamp: The input range to clamp to.
    ///   - rangeOut: The output range to map to.
    @inlinable
    public mutating func remap(clampingIn rangeClamp: ClosedRange<Float>, to rangeOut: ClosedRange<Float>) {
        clamp(to: rangeClamp)
        lerp(from: rangeClamp, to: rangeOut)
    }
}

extension Double {
    /// Remaps this value from one range to another, clamping the input to the input range.
    /// - Parameters:
    ///   - rangeClamp: The input range to clamp to.
    ///   - rangeOut: The output range to map to.
    /// - Returns: The remapped value.
    @inlinable
    public func remaped(clampingIn rangeClamp: ClosedRange<Double>, to rangeOut: ClosedRange<Double>) -> Double {
        var v: Double = clamped(to: rangeClamp)
        v = v.lerped(from: rangeClamp, to: rangeOut)
        return v
    }

    /// Remaps this value from one range to another in place, clamping the input to the input range.
    /// - Parameters:
    ///   - rangeClamp: The input range to clamp to.
    ///   - rangeOut: The output range to map to.
    @inlinable
    public mutating func remap(clampingIn rangeClamp: ClosedRange<Double>, to rangeOut: ClosedRange<Double>) {
        clamp(to: rangeClamp)
        lerp(from: rangeClamp, to: rangeOut)
    }
}
