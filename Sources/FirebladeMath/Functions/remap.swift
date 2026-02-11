extension FloatingPoint {
    /// Remaps this value from one range to another, clamping the input to the input range.
    /// - Parameters:
    ///   - rangeClamp: The input range to clamp to.
    ///   - rangeOut: The output range to map to.
    /// - Returns: The remapped value.
    @inlinable
    public func remaped(clampingIn rangeClamp: ClosedRange<Self>,
                        to rangeOut: ClosedRange<Self>) -> Self {
        var v = clamped(to: rangeClamp)
        v = v.lerped(from: rangeClamp, to: rangeOut)
        return v
    }

    /// Remaps this value from one range to another in place, clamping the input to the input range.
    /// - Parameters:
    ///   - rangeClamp: The input range to clamp to.
    ///   - rangeOut: The output range to map to.
    @inlinable
    public mutating func remap(clampingIn rangeClamp: ClosedRange<Self>,
                               to rangeOut: ClosedRange<Self>) {
        clamp(to: rangeClamp)
        lerp(from: rangeClamp, to: rangeOut)
    }
}