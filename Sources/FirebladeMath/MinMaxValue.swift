//
//  MinMaxValue.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 10.09.19.
//

public struct MinMaxValue<T> where T: FloatingPoint & Codable {
    public var min: T = 0
    public var max: T = 0

    public mutating func value(_ value: T) {
        if value < min {
            min = value
        }
        if value > max {
            max = value
        }
    }

    public var range: ClosedRange<T> {
        return min...max
    }
}

extension MinMaxValue: Equatable { }
extension MinMaxValue: Hashable { }
extension MinMaxValue: Codable { }
