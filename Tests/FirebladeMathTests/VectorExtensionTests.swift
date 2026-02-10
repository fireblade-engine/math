import Testing
import Foundation
@testable import FirebladeMath

@Suite struct VectorExtensionTests {
    // MARK: - SIMD2
    
    @Test func simd2FloatProperties() {
        let v = SIMD2<Float>(3, 4)
        #expect(v.length == 5)
        #expect(v.normalized == SIMD2<Float>(0.6, 0.8))
        
        #expect(SIMD2<Float>(.nan, 0).isNaN)
        #expect(SIMD2<Float>(0, .nan).isNaN)
        #expect(!SIMD2<Float>(0, 0).isNaN)
    }

    @Test func simd2DoubleProperties() {
        let v = SIMD2<Double>(3, 4)
        #expect(v.length == 5)
        
        let normalized = v.normalized
        let expected = SIMD2<Double>(0.6, 0.8)
        
        #expect(abs(normalized.x - expected.x) < 1e-15)
        #expect(abs(normalized.y - expected.y) < 1e-15)
    }
    
    // MARK: - SIMD3
    
    @Test func simd3FloatProperties() {
        let v = SIMD3<Float>(1, 0, 0)
        #expect(v.length == 1)
        #expect(v.normalized == v)
        #expect(v.normalize() == v)
        
        #expect(SIMD3<Float>(.nan, 0, 0).isNaN)
        #expect(SIMD3<Float>(0, .nan, 0).isNaN)
        #expect(SIMD3<Float>(0, 0, .nan).isNaN)
        #expect(!SIMD3<Float>(0, 0, 0).isNaN)
        
        let a = SIMD3<Float>(1, 0, 0)
        let b = SIMD3<Float>(0, 1, 0)
        #expect(a.cross(b) == SIMD3<Float>(0, 0, 1))
        #expect(a.dot(b) == 0)
    }

    @Test func simd3DoubleProperties() {
        let v = SIMD3<Double>(0, 2, 0)
        #expect(v.length == 2)
        #expect(v.normalized == SIMD3<Double>(0, 1, 0))
        #expect(v.normalize() == SIMD3<Double>(0, 1, 0))
        
        let a = SIMD3<Double>(1, 0, 0)
        let b = SIMD3<Double>(0, 1, 0)
        #expect(a.cross(b) == SIMD3<Double>(0, 0, 1))
        #expect(a.dot(b) == 0)
    }
    
    // MARK: - SIMD4
    
    @Test func simd4FloatProperties() {
        let v = SIMD4<Float>(0, 0, 0, 2)
        #expect(v.length == 2)
        #expect(v.normalized == SIMD4<Float>(0, 0, 0, 1))
        #expect(v.xyz == SIMD3<Float>(0, 0, 0))
        
        #expect(SIMD4<Float>(.nan, 0, 0, 0).isNaN)
        #expect(SIMD4<Float>(0, .nan, 0, 0).isNaN)
        #expect(SIMD4<Float>(0, 0, .nan, 0).isNaN)
        #expect(SIMD4<Float>(0, 0, 0, .nan).isNaN)
        #expect(!SIMD4<Float>(0, 0, 0, 0).isNaN)
    }

    @Test func simd4DoubleProperties() {
        let v = SIMD4<Double>(0, 0, 4, 0)
        #expect(v.length == 4)
        #expect(v.normalized == SIMD4<Double>(0, 0, 1, 0))
    }
    
    @Test func sequenceConformance() {
        let v2 = SIMD2<Float>(1, 2)
        #expect(Array(v2) == [1, 2])
        
        let v3 = SIMD3<Float>(1, 2, 3)
        #expect(Array(v3) == [1, 2, 3])
        
        let v4 = SIMD4<Float>(1, 2, 3, 4)
        #expect(Array(v4) == [1, 2, 3, 4])
    }
}
