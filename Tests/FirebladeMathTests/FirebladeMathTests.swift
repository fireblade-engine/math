@testable import FirebladeMath
import XCTest

class FirebladeMathTests: XCTestCase {

	func testMat4x4fMultiplicationOperator() {

        let resMat: Mat4x4f = Mat4x4f(diagonal: Vec4f(repeating: 2)) * Mat4x4f(diagonal: Vec4f(repeating: 3))

		XCTAssert(resMat != Mat4x4f(diagonal: Vec4f.one))
	}
    
    func testVectorSequences() {
        let vec2 = Vec2f(1,2)
        let vec3 = Vec3f(3,4,5)
        let vec4 = Vec4f(6,7,8,9)
        
        let rVec2 = Vec2f(vec2.map { $0 })
        let rVec3 = Vec3f(vec3.map { $0 })
        let rVec4 = Vec4f(vec4.map { $0 })
        
        XCTAssertEqual(rVec2, vec2)
        XCTAssertEqual(rVec3, vec3)
        XCTAssertEqual(rVec4, vec4)
    }
}
