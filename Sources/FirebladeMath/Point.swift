/// A point in a 2D coordinate system.
@frozen
public struct Point<Value: Numeric> {
    /// The x-coordinate of the point.
    public var x: Value
    /// The y-coordinate of the point.
    public var y: Value

    /// Creates a new point with the specified coordinates.
    /// - Parameters:
    ///   - x: The x-coordinate.
    ///   - y: The y-coordinate.
    public init(x: Value, y: Value) {
        self.x = x
        self.y = y
    }
}

extension Point {
    /// Creates a new point with the specified coordinates.
    /// - Parameters:
    ///   - x: The x-coordinate.
    ///   - y: The y-coordinate.
    public init(_ x: Value, _ y: Value) {
        self.init(x: x, y: y)
    }
}

extension Point: Equatable where Value: Equatable {}
extension Point: Hashable where Value: Hashable {}
extension Point: Codable where Value: Codable {}

extension Point where Value == Float {
    /// Creates a point from a 2D float vector.
    /// - Parameter vector: The vector containing the x and y coordinates.
    public init(_ vector: Vec2f) {
        self.init(x: vector.x, y: vector.y)
    }
}

extension Vec2f {
    /// Creates a 2D float vector from a point.
    /// - Parameter point: The point containing the x and y coordinates.
    public init(_ point: Point<Float>) {
        self.init(x: point.x, y: point.y)
    }
}

extension Point where Value == Int {
    /// Creates a point from a 2D integer vector.
    /// - Parameter vector: The vector containing the x and y coordinates.
    public init(_ vector: Vec2i) {
        self.init(x: vector.x, y: vector.y)
    }
}

extension Vec2i {
    /// Creates a 2D integer vector from a point.
    /// - Parameter point: The point containing the x and y coordinates.
    public init(_ point: Point<Int>) {
        self.init(x: point.x, y: point.y)
    }
}

extension Point where Value == Double {
    /// Creates a point from a 2D double vector.
    /// - Parameter vector: The vector containing the x and y coordinates.
    public init(_ vector: Vec2d) {
        self.init(x: vector.x, y: vector.y)
    }
}

extension Vec2d {
    /// Creates a 2D double vector from a point.
    /// - Parameter point: The point containing the x and y coordinates.
    public init(_ point: Point<Double>) {
        self.init(x: point.x, y: point.y)
    }
}

extension Point where Value == UInt {
    /// Creates a point from a 2D unsigned integer vector.
    /// - Parameter vector: The vector containing the x and y coordinates.
    public init(_ vector: Vec2u) {
        self.init(x: vector.x, y: vector.y)
    }
}

extension Vec2u {
    /// Creates a 2D unsigned integer vector from a point.
    /// - Parameter point: The point containing the x and y coordinates.
    public init(_ point: Point<UInt>) {
        self.init(x: point.x, y: point.y)
    }
}