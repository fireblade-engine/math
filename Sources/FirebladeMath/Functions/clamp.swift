//
//  clamp.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if USE_SIMD
import func simd.simd_clamp
#endif

/// x clamped to the range [min, max].
/// Note that if you want to clamp all lanes to the same range, you can use a scalar value for min and max.
/// - Parameters:
///   - x: value to be clamped
///   - min: min range bound
///   - max: max range bound
/// - Returns: x clamped to the range [min, max]
public func clamp(_ x: Double, _ minVal: Double, _ maxVal: Double) -> Double {
    #if USE_SIMD
    return simd_clamp(x, minVal, maxVal)
    #else
    return min(max(x, minVal), maxVal)
    #endif
}

/// x clamped to the range [min, max].
/// Note that if you want to clamp all lanes to the same range, you can use a scalar value for min and max.
/// - Parameters:
///   - x: value to be clamped
///   - min: min range bound
///   - max: max range bound
/// - Returns: x clamped to the range [min, max]
public func clamp(_ x: Float, _ minVal: Float, _ maxVal: Float) -> Float {
    #if USE_SIMD
    return simd_clamp(x, minVal, maxVal)
    #else
    return min(max(x, minVal), maxVal)
    #endif
}

extension Comparable {
    @inlinable
    public func clamped(to range: ClosedRange<Self>) -> Self {
        if self < range.lowerBound {
            return range.lowerBound
        }
        if self > range.upperBound {
            return range.upperBound
        }
        return self
    }

    @inlinable
    public mutating func clamp(to range: ClosedRange<Self>) {
        if self < range.lowerBound {
            self = range.lowerBound
        }
        if self > range.upperBound {
            self = range.upperBound
        }
    }
}
