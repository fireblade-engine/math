//
//  Point.swift
//
//
//  Created by Christian Treffs on 02.09.20.
//

@frozen
public struct Point<Value> where Value: Numeric {
    public var x: Value
    public var y: Value

    public init(x: Value, y: Value) {
        self.x = x
        self.y = y
    }
}

extension Point {
    public init(_ x: Value, _ y: Value) {
        self.init(x: x, y: y)
    }
}

extension Point: Equatable where Value: Equatable { }
extension Point: Hashable where Value: Hashable { }
extension Point: Codable where Value: Codable { }

extension Point where Value == Float {
    public init(_ vector: Vec2f) {
        self.init(x: vector.x, y: vector.y)
    }
}

extension Vec2f {
    public init(_ point: Point<Float>) {
        self.init(x: point.x, y: point.y)
    }
}

extension Point where Value == Int {
    public init(_ vector: Vec2i) {
        self.init(x: vector.x, y: vector.y)
    }
}

extension Vec2i {
    public init(_ point: Point<Int>) {
        self.init(x: point.x, y: point.y)
    }
}

extension Point where Value == Double {
    public init(_ vector: Vec2d) {
        self.init(x: vector.x, y: vector.y)
    }
}
extension Vec2d {
    public init(_ point: Point<Double>) {
        self.init(x: point.x, y: point.y)
    }
}

extension Point where Value == UInt {
    public init(_ vector: Vec2u) {
        self.init(x: vector.x, y: vector.y)
    }
}

extension Vec2u {
    public init(_ point: Point<UInt>) {
        self.init(x: point.x, y: point.y)
    }
}
