//
//  saturate.swift
//
//
//  Created by Christian Treffs on 02.09.20.
//

/// Returns x, where 0.0 ≤ x ≤ 1.0
public func saturate<Value>(_ x: Value) -> Value where Value: BinaryFloatingPoint {
    clamp(x, min: 0.0, max: 1.0)
}
