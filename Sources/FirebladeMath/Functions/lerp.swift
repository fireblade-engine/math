//
//  lerp.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 10.09.19.
//

public extension FloatingPoint {
    @inlinable
    func lerped(from rangeIn: ClosedRange<Self>, to rangeOut: ClosedRange<Self>) -> Self {
        let x: Self = self
        let x0: Self = rangeIn.lowerBound
        let x1: Self = rangeIn.upperBound
        let y0: Self = rangeOut.lowerBound
        let y1: Self = rangeOut.upperBound
        let frac: Self = (y1 - y0) / (x1 - x0)
        let y: Self = y0 + (x - x0) * frac
        return y
    }

    @inlinable
    mutating func lerp(from rangeIn: ClosedRange<Self>, to rangeOut: ClosedRange<Self>) {
        let x: Self = self
        let x0: Self = rangeIn.lowerBound
        let x1: Self = rangeIn.upperBound
        let y0: Self = rangeOut.lowerBound
        let y1: Self = rangeOut.upperBound
        let frac: Self = (y1 - y0) / (x1 - x0)
        self = y0 + (x - x0) * frac
    }
}
