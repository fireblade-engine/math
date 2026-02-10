import Testing
import Foundation
@testable import FirebladeMath

@Suite struct PointTests {
    @Test func initialization() {
        let point = Point(x: 10, y: 20)
        #expect(point.x == 10)
        #expect(point.y == 20)

        let point2 = Point(30, 40)
        #expect(point2.x == 30)
        #expect(point2.y == 40)
    }

    @Test func equality() {
        let p1 = Point(x: 1, y: 2)
        let p2 = Point(x: 1, y: 2)
        let p3 = Point(x: 3, y: 4)

        #expect(p1 == p2)
        #expect(p1 != p3)
    }

    @Test func hashable() {
        let p1 = Point(x: 1, y: 2)
        let p2 = Point(x: 1, y: 2)
        
        var set = Set<Point<Int>>()
        set.insert(p1)
        
        #expect(set.contains(p2))
    }

    @Test func codable() throws {
        let point = Point(x: 5, y: 10)
        let encoder = JSONEncoder()
        let data = try encoder.encode(point)
        
        let decoder = JSONDecoder()
        let decodedPoint = try decoder.decode(Point<Int>.self, from: data)
        
        #expect(decodedPoint == point)
    }

    @Test func floatConversion() {
        let vec = Vec2f(1.5, 2.5)
        let point = Point(vec)
        #expect(point.x == 1.5)
        #expect(point.y == 2.5)

        let vecBack = Vec2f(point)
        #expect(vecBack == vec)
    }

    @Test func intConversion() {
        let vec = Vec2i(10, 20)
        let point = Point(vec)
        #expect(point.x == 10)
        #expect(point.y == 20)

        let vecBack = Vec2i(point)
        #expect(vecBack == vec)
    }

    @Test func doubleConversion() {
        let vec = Vec2d(1.1, 2.2)
        let point = Point(vec)
        #expect(point.x == 1.1)
        #expect(point.y == 2.2)

        let vecBack = Vec2d(point)
        #expect(vecBack == vec)
    }

    @Test func uintConversion() {
        let vec = Vec2u(5, 15)
        let point = Point(vec)
        #expect(point.x == 5)
        #expect(point.y == 15)

        let vecBack = Vec2u(point)
        #expect(vecBack == vec)
    }
}
