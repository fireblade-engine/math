//
//  Size.swift
//
//
//  Created by Christian Treffs on 02.09.20.
//

@frozen
public struct Size<Value> where Value: Numeric {
    public var width: Value
    public var height: Value
}

extension Size where Value == Float {
    public init(_ vector: Vec2f) {
        self.init(width: vector.x, height: vector.y)
    }
}

extension Size where Value == Int {
    public init(_ vector: Vec2i) {
        self.init(width: vector.x, height: vector.y)
    }
}

extension Size where Value == Double {
    public init(_ vector: Vec2d) {
        self.init(width: vector.x, height: vector.y)
    }
}

extension Size where Value == UInt {
    public init(_ vector: Vec2u) {
        self.init(width: vector.x, height: vector.y)
    }
}

extension Size: Equatable where Value: Equatable { }
extension Size: Hashable where Value: Hashable { }
extension Size: Codable where Value: Codable { }

extension Vec2f {
    public init(_ size: Size<Float>) {
        self.init(x: size.width, y: size.height)
    }
}
