/// A structure that contains the location and dimensions of a rectangle.
@frozen
public struct Rect<Value: Numeric> {
    /// The origin of the rectangle.
    public var origin: Point<Value>
    /// The size of the rectangle.
    public var size: Size<Value>

    /// The x-coordinate of the rectangle's origin.
    public var x: Value {
        get { origin.x }
        set { origin.x = newValue }
    }

    /// The y-coordinate of the rectangle's origin.
    public var y: Value {
        get { origin.y }
        set { origin.y = newValue }
    }

    /// The width of the rectangle.
    public var width: Value {
        get { size.width }
        set { size.width = newValue }
    }

    /// The height of the rectangle.
    public var height: Value {
        get { size.height }
        set { size.height = newValue }
    }

    /// Creates a rectangle with the specified origin and size.
    /// - Parameters:
    ///   - origin: The origin point.
    ///   - size: The dimensions.
    public init(origin: Point<Value>, size: Size<Value>) {
        self.origin = origin
        self.size = size
    }
}

extension Rect {
    /// Creates a rectangle with the specified coordinates and dimensions.
    /// - Parameters:
    ///   - x: The x-coordinate.
    ///   - y: The y-coordinate.
    ///   - width: The width.
    ///   - height: The height.
    public init(x: Value, y: Value, width: Value, height: Value) {
        self.init(origin: Point(x: x, y: y),
                  size: Size(width: width, height: height))
    }

    /// Creates a rectangle with the specified coordinates and dimensions.
    /// - Parameters:
    ///   - x: The x-coordinate.
    ///   - y: The y-coordinate.
    ///   - width: The width.
    ///   - height: The height.
    public init(_ x: Value, _ y: Value, _ width: Value, _ height: Value) {
        self.init(x: x, y: y, width: width, height: height)
    }
}

extension Rect: Equatable where Value: Equatable {}
extension Rect: Hashable where Value: Hashable {}
extension Rect: Codable where Value: Codable {}

extension Rect {
    /// The minimum x-coordinate of the rectangle.
    public var minX: Value {
        origin.x
    }

    /// The minimum y-coordinate of the rectangle.
    public var minY: Value {
        origin.y
    }

    /// The maximum x-coordinate of the rectangle.
    public var maxX: Value {
        origin.x + size.width
    }

    /// The maximum y-coordinate of the rectangle.
    public var maxY: Value {
        origin.y + size.height
    }

    /// The top-left corner of the rectangle.
    public var topLeft: Point<Value> {
        Point(minX, maxY)
    }

    /// The top-right corner of the rectangle.
    public var topRight: Point<Value> {
        Point(maxX, maxY)
    }

    /// The bottom-left corner of the rectangle.
    public var bottomLeft: Point<Value> {
        Point(minX, minY)
    }

    /// The bottom-right corner of the rectangle.
    public var bottomRight: Point<Value> {
        Point(maxX, minY)
    }
}

extension Rect where Value: FloatingPoint {
    /// The x-coordinate of the rectangle's center.
    public var midX: Value {
        origin.x + size.width / Value(2)
    }

    /// The y-coordinate of the rectangle's center.
    public var midY: Value {
        origin.y + size.height / Value(2)
    }
}

extension Rect where Value: Comparable {
    /// Returns a Boolean value indicating whether the rectangle contains the specified point.
    /// - Parameter point: The point to check.
    /// - Returns: `true` if the point is inside or on the edge of the rectangle; otherwise, `false`.
    @inlinable
    public func contains(_ point: Point<Value>) -> Bool {
        point.x >= minX && point.x <= maxX && point.y >= minY && point.y <= maxY
    }
}
