import Testing
import Foundation
@testable import FirebladeMath

@Suite struct SizeTests {
    @Test func initialization() {
        let size = Size(width: 100, height: 200)
        #expect(size.width == 100)
        #expect(size.height == 200)

        let size2 = Size(300, 400)
        #expect(size2.width == 300)
        #expect(size2.height == 400)
    }

    @Test func equality() {
        let s1 = Size(width: 10, height: 20)
        let s2 = Size(width: 10, height: 20)
        let s3 = Size(width: 30, height: 40)

        #expect(s1 == s2)
        #expect(s1 != s3)
    }

    @Test func hashable() {
        let s1 = Size(width: 10, height: 20)
        let s2 = Size(width: 10, height: 20)
        
        var set = Set<Size<Int>>()
        set.insert(s1)
        
        #expect(set.contains(s2))
    }

    @Test func codable() throws {
        let size = Size(width: 50, height: 150)
        let encoder = JSONEncoder()
        let data = try encoder.encode(size)
        
        let decoder = JSONDecoder()
        let decodedSize = try decoder.decode(Size<Int>.self, from: data)
        
        #expect(decodedSize == size)
    }

    @Test func centerCalculation() {
        let sizeF = Size<Float>(width: 100.0, height: 50.0)
        #expect(sizeF.center == Point(50.0, 25.0))

        let sizeD = Size<Double>(width: 10.0, height: 20.0)
        #expect(sizeD.center == Point(5.0, 10.0))
    }

    @Test func floatConversion() {
        let vec = Vec2f(100.0, 200.0)
        let size = Size(vec)
        #expect(size.width == 100.0)
        #expect(size.height == 200.0)

        let vecBack = Vec2f(size)
        #expect(vecBack == vec)
    }

    @Test func intConversion() {
        let vec = Vec2i(10, 20)
        let size = Size(vec)
        #expect(size.width == 10)
        #expect(size.height == 20)

        let vecBack = Vec2i(size)
        #expect(vecBack == vec)
    }

    @Test func doubleConversion() {
        let vec = Vec2d(1.1, 2.2)
        let size = Size(vec)
        #expect(size.width == 1.1)
        #expect(size.height == 2.2)

        let vecBack = Vec2d(size)
        #expect(vecBack == vec)
    }

    @Test func uintConversion() {
        let vec = Vec2u(5, 15)
        let size = Size(vec)
        #expect(size.width == 5)
        #expect(size.height == 15)

        let vecBack = Vec2u(size)
        #expect(vecBack == vec)
    }
}
