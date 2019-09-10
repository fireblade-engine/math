//
//  remap.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 10.09.19.
//

extension FloatingPoint {
    @inlinable
    func remaped(clampingIn rangeClamp: ClosedRange<Self>,
                 to rangeOut: ClosedRange<Self>) -> Self {
        var v = self.clamped(to: rangeClamp)
        v = v.lerped(from: rangeClamp, to: rangeOut)
        return v
    }

    @inlinable
    mutating func remap(clampingIn rangeClamp: ClosedRange<Self>,
                        to rangeOut: ClosedRange<Self>) {
        self.clamp(to: rangeClamp)
        self.lerp(from: rangeClamp, to: rangeOut)
    }
}
