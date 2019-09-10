//
//  Rect.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 10.09.19.
//

public struct Rect2D {
    /// x coord of lower left corner
    public var x: Int
    /// y coord of lower left corner
    public var y: Int
    public var width: Int
    public var height: Int

    public static let zero = Rect2D(x: 0, y: 0, width: 0, height: 0)

    public init(x: Int, y: Int, width: Int, height: Int) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }

    public init(_ x: Int, _ y: Int, _ width: Int, _ height: Int) {
        self.init(x: x, y: y, width: width, height: height)
    }
}

extension Rect2D: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Int...) {
        precondition(elements.count == 4, "Rect2D needs exactly 4 elements.")
        self.init(x: elements[0], y: elements[1], width: elements[2], height: elements[3])
    }
}

extension Rect2D: Equatable { }
extension Rect2D: Hashable { }
extension Rect2D: Codable { }
