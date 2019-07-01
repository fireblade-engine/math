@testable import FirebladeMath
import XCTest
import GLKit


class FirebladeMathTests: XCTestCase {

	/*func testMat4x4fMultiplicationOperator() {

        
        let resMat: Mat4x4f = Mat4x4f(diagonal: Vec4f(repeating: 2)) * Mat4x4f(diagonal: Vec4f(repeating: 3))

		XCTAssert(resMat != Mat4x4f(diagonal: Vec4f.one))
	}*/
    
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
    
    func testScale() {
        var mat = Mat4x4f.identity
        
        mat.orientation *= .init(angle: radians(90), axis: .axisX)
        
        XCTAssertEqual(mat.scale.x, 1.0, accuracy: 1.0e-9)
        XCTAssertEqual(mat.scale.y, 1.0, accuracy: 1.0e-9)
        XCTAssertEqual(mat.scale.z, 1.0, accuracy: 1.0e-9)
    }
    
    func testScaling() {
        let refMat = unsafeBitCast(GLKMatrix4MakeScale(1.2, 3.4, 5.6), to: float4x4.self)
        let mat = Mat4x4f.init(translation: .zero, scale: Vec3f(1.2, 3.4, 5.6), orientation: .identity)
        XCTAssertEqual(mat, refMat)
    }
    
    func testTranslation() {
        let refMat = unsafeBitCast(GLKMatrix4MakeTranslation(1.2, 3.4, 5.6), to: float4x4.self)
        let mat = Mat4x4f(translation: Vec3f(1.2, 3.4, 5.6), scale: .one, orientation: .identity)
        XCTAssertEqual(mat, refMat)
    }
    
    func testRotation() {
        let a = Mat4x4f(rotationEuler: Vec3f(33, 0, 0))
        let b = Mat4x4f(orientation: Quat4f(angle: radians(33), axis: .axisX))
        
        XCTAssertEqual(a, b)
    }
    
    func testRotationX() {
        let refMat = unsafeBitCast(GLKMatrix4RotateX(GLKMatrix4Identity, 35), to: float4x4.self)
        let mat = Mat4x4f(translation: .zero, scale: .one, orientation: Quat4f(angle: radians(35), axis: .axisX))
        XCTAssertEqual(mat, refMat)
    }
    
    
}


