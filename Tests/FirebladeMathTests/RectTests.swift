import Testing
import Foundation
@testable import FirebladeMath

@Suite struct RectTests {
    @Test func initialization() {
        let origin = Point(x: 10, y: 20)
        let size = Size(width: 100, height: 200)
        let rect = Rect(origin: origin, size: size)
        
        #expect(rect.origin == origin)
        #expect(rect.size == size)
        
        #expect(rect.x == 10)
        #expect(rect.y == 20)
        #expect(rect.width == 100)
        #expect(rect.height == 200)

        let rect2 = Rect(x: 30, y: 40, width: 300, height: 400)
        #expect(rect2.x == 30)
        #expect(rect2.y == 40)
        #expect(rect2.width == 300)
        #expect(rect2.height == 400)
        
        let rect3 = Rect(1, 2, 3, 4)
        #expect(rect3.x == 1)
        #expect(rect3.y == 2)
        #expect(rect3.width == 3)
        #expect(rect3.height == 4)
    }
    
    @Test func gettersSetters() {
        var rect = Rect(x: 0, y: 0, width: 10, height: 10)
        rect.x = 5
        rect.y = 5
        rect.width = 20
        rect.height = 30
        
        #expect(rect.origin.x == 5)
        #expect(rect.origin.y == 5)
        #expect(rect.size.width == 20)
        #expect(rect.size.height == 30)
    }

    @Test func equality() {
        let r1 = Rect(x: 0, y: 0, width: 10, height: 10)
        let r2 = Rect(x: 0, y: 0, width: 10, height: 10)
        let r3 = Rect(x: 1, y: 0, width: 10, height: 10)

        #expect(r1 == r2)
        #expect(r1 != r3)
    }

    @Test func hashable() {
        let r1 = Rect(x: 0, y: 0, width: 10, height: 10)
        let r2 = Rect(x: 0, y: 0, width: 10, height: 10)
        
        var set = Set<Rect<Int>>()
        set.insert(r1)
        
        #expect(set.contains(r2))
    }

    @Test func codable() throws {
        let rect = Rect(x: 5, y: 5, width: 50, height: 50)
        let encoder = JSONEncoder()
        let data = try encoder.encode(rect)
        
        let decoder = JSONDecoder()
        let decodedRect = try decoder.decode(Rect<Int>.self, from: data)
        
        #expect(decodedRect == rect)
    }
    
    @Test func geometry() {
        let rect = Rect(x: 10, y: 20, width: 100, height: 200)
        
        #expect(rect.minX == 10)
        #expect(rect.minY == 20)
        #expect(rect.maxX == 110)
        #expect(rect.maxY == 220)
        
        #expect(rect.bottomLeft == Point(10, 20))
        #expect(rect.bottomRight == Point(110, 20))
        #expect(rect.topLeft == Point(10, 220))
        #expect(rect.topRight == Point(110, 220))
    }
    
    @Test func floatingPointGeometry() {
        let rect = Rect(x: 10.0, y: 20.0, width: 100.0, height: 200.0)
        #expect(rect.midX == 60.0)
        #expect(rect.midY == 120.0)
    }
    
    @Test func contains() {
        let rect = Rect(x: 0, y: 0, width: 10, height: 10)
        
        #expect(rect.contains(Point(x: 5, y: 5)))
        #expect(rect.contains(Point(x: 0, y: 0)))
        #expect(rect.contains(Point(x: 10, y: 10)))
        
        #expect(!rect.contains(Point(x: -1, y: 5)))
        #expect(!rect.contains(Point(x: 11, y: 5)))
        #expect(!rect.contains(Point(x: 5, y: -1)))
        #expect(!rect.contains(Point(x: 5, y: 11)))
    }
}
