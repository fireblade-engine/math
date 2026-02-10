@frozen
public struct Size<Value: Numeric> {
    public var width: Value
    public var height: Value

    public init(width: Value, height: Value) {
        self.width = width
        self.height = height
    }
}

extension Size {
    public init(_ width: Value, _ height: Value) {
        self.init(width: width, height: height)
    }
}

extension Size: Equatable where Value: Equatable {}
extension Size: Hashable where Value: Hashable {}
extension Size: Codable where Value: Codable {}

extension Size where Value: FloatingPoint & ExpressibleByFloatLiteral {
    public var center: Point<Value> {
        Point(x: width * 0.5, y: height * 0.5)
    }
}

extension Size where Value == Float {
    public init(_ vector: Vec2f) {
        self.init(width: vector.x, height: vector.y)
    }
}

extension Vec2f {
    public init(_ size: Size<Float>) {
        self.init(x: size.width, y: size.height)
    }
}

extension Size where Value == Int {
    public init(_ vector: Vec2i) {
        self.init(width: vector.x, height: vector.y)
    }
}

extension Vec2i {
    public init(_ size: Size<Int>) {
        self.init(x: size.width, y: size.height)
    }
}

extension Size where Value == Double {
    public init(_ vector: Vec2d) {
        self.init(width: vector.x, height: vector.y)
    }
}

extension Vec2d {
    public init(_ size: Size<Double>) {
        self.init(x: size.width, y: size.height)
    }
}

extension Size where Value == UInt {
    public init(_ vector: Vec2u) {
        self.init(width: vector.x, height: vector.y)
    }
}

extension Vec2u {
    public init(_ size: Size<UInt>) {
        self.init(x: size.width, y: size.height)
    }
}
