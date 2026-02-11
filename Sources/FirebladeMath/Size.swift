/// A structure that contains width and height values.
@frozen
public struct Size<Value: Numeric> {
    /// The width value.
    public var width: Value
    /// The height value.
    public var height: Value

    /// Creates a size with the specified width and height.
    /// - Parameters:
    ///   - width: The width.
    ///   - height: The height.
    public init(width: Value, height: Value) {
        self.width = width
        self.height = height
    }
}

extension Size {
    /// Creates a size with the specified width and height.
    /// - Parameters:
    ///   - width: The width.
    ///   - height: The height.
    public init(_ width: Value, _ height: Value) {
        self.init(width: width, height: height)
    }
}

extension Size: Equatable where Value: Equatable {}
extension Size: Hashable where Value: Hashable {}
extension Size: Codable where Value: Codable {}

extension Size where Value: FloatingPoint & ExpressibleByFloatLiteral {
    /// The center point of the size, assuming a (0,0) origin.
    public var center: Point<Value> {
        Point(x: width * 0.5, y: height * 0.5)
    }
}

extension Size where Value == Float {
    /// Creates a size from a 2D float vector.
    /// - Parameter vector: The vector containing width and height.
    public init(_ vector: Vec2f) {
        self.init(width: vector.x, height: vector.y)
    }
}

extension Vec2f {
    /// Creates a 2D float vector from a size.
    /// - Parameter size: The size containing width and height.
    public init(_ size: Size<Float>) {
        self.init(x: size.width, y: size.height)
    }
}

extension Size where Value == Int {
    /// Creates a size from a 2D integer vector.
    /// - Parameter vector: The vector containing width and height.
    public init(_ vector: Vec2i) {
        self.init(width: vector.x, height: vector.y)
    }
}

extension Vec2i {
    /// Creates a 2D integer vector from a size.
    /// - Parameter size: The size containing width and height.
    public init(_ size: Size<Int>) {
        self.init(x: size.width, y: size.height)
    }
}

extension Size where Value == Double {
    /// Creates a size from a 2D double vector.
    /// - Parameter vector: The vector containing width and height.
    public init(_ vector: Vec2d) {
        self.init(width: vector.x, height: vector.y)
    }
}

extension Vec2d {
    /// Creates a 2D double vector from a size.
    /// - Parameter size: The size containing width and height.
    public init(_ size: Size<Double>) {
        self.init(x: size.width, y: size.height)
    }
}

extension Size where Value == UInt {
    /// Creates a size from a 2D unsigned integer vector.
    /// - Parameter vector: The vector containing width and height.
    public init(_ vector: Vec2u) {
        self.init(width: vector.x, height: vector.y)
    }
}

extension Vec2u {
    /// Creates a 2D unsigned integer vector from a size.
    /// - Parameter size: The size containing width and height.
    public init(_ size: Size<UInt>) {
        self.init(x: size.width, y: size.height)
    }
}