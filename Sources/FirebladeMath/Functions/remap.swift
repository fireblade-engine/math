extension FloatingPoint {
    @inlinable
    public func remaped(clampingIn rangeClamp: ClosedRange<Self>,
                        to rangeOut: ClosedRange<Self>) -> Self
    {
        var v = clamped(to: rangeClamp)
        v = v.lerped(from: rangeClamp, to: rangeOut)
        return v
    }

    @inlinable
    public mutating func remap(clampingIn rangeClamp: ClosedRange<Self>,
                               to rangeOut: ClosedRange<Self>)
    {
        clamp(to: rangeClamp)
        lerp(from: rangeClamp, to: rangeOut)
    }
}
