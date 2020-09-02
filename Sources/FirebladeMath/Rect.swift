//
//  Rect.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 10.09.19.
//

/// Frame, Rectange, Bounds, Region, Area
@frozen
public struct Rect<Value> where Value: Numeric {
    public var origin: Point<Value>
    public var size: Size<Value>

    public var x: Value {
        get { origin.x }
        set { origin.x = newValue }
    }
    public var y: Value {
        get { origin.y }
        set { origin.y = newValue }
    }
    public var width: Value {
        get { size.width }
        set { size.width = newValue }
    }
    public var height: Value {
        get { size.height }
        set { size.height = newValue }
    }

    public init(origin: Point<Value>, size: Size<Value>) {
        self.origin = origin
        self.size = size
    }
}

extension Rect {
    public init(x: Value, y: Value, width: Value, height: Value) {
        self.init(origin: Point(x: x, y: y),
                  size: Size(width: width, height: height))
    }

    public init(_ x: Value, _ y: Value, _ width: Value, _ height: Value) {
        self.init(x: x, y: y, width: width, height: height)
    }
}

extension Rect: Equatable where Value: Equatable { }
extension Rect: Hashable where Value: Hashable { }
extension Rect: Codable where Value: Codable { }

extension Rect {
    public var minX: Value { origin.x }
    public var minY: Value { origin.y }

    public var maxX: Value { origin.x + size.width }
    public var maxY: Value { origin.y + size.height }

    public var topLeft: Point<Value> { Point(minX, maxY) }
    public var topRight: Point<Value> { Point(maxX, maxY) }
    public var bottomLeft: Point<Value> { Point(minX, minY) }
    public var bottomRight: Point<Value> { Point(maxX, minY) }
}

extension Rect where Value: FloatingPoint {
    public var midX: Value { origin.x + size.width / Value(2) }
    public var midY: Value { origin.y + size.height / Value(2) }
}

extension Rect where Value: Comparable {
    @inlinable
    public func contains(_ point: Point<Value>) -> Bool {
        point.x >= minX && point.x <= maxX && point.y >= minY && point.y <= maxY
    }
}
