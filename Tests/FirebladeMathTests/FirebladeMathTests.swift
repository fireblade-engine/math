@testable import FirebladeMath
import XCTest

/*

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
        let refMat = unsafeBitCast(GLKMatrix4MakeScale(1.2, 3.4, 5.6), to: Mat4x4f.self)
        let mat = Mat4x4f(scale: Vec3f(1.2, 3.4, 5.6))
        XCTAssertEqual(mat, refMat)
        
        XCTAssertEqual(mat.scale, Vec3f(1.2, 3.4, 5.6))
    }
    
    func testTranslation() {
        let refMat = unsafeBitCast(GLKMatrix4MakeTranslation(1.2, 3.4, 5.6), to: Mat4x4f.self)
        let mat = Mat4x4f(translation: Vec3f(1.2, 3.4, 5.6))
        XCTAssertEqual(mat, refMat)
        
        XCTAssertEqual(mat.translation, Vec3f(1.2, 3.4, 5.6))
    }
    
    func testRotation() {
        let refMat = unsafeBitCast(GLKMatrix4MakeRotation(radians(33), 1, 0, 0), to: Mat4x4f.self)
        let mat = Mat4x4f(eulerAngles: Vec3f(radians(33), 0, 0))
        let mat2 = Mat4x4f(angle: radians(33), axis: .axisX)
        
        XCTAssertEqual(mat, refMat)
        XCTAssertEqual(mat2, refMat)
        
        XCTAssertEqual(mat.eulerAngles, Vec3f(radians(33), 0, 0))
        XCTAssertEqual(mat2.eulerAngles, Vec3f(radians(33), 0, 0))
    }
    
    func testAxis() {
        XCTAssertEqual(Vec3f.axisX, Vec3f(1,0,0))
        XCTAssertEqual(Vec3f.axisY, Vec3f(0,1,0))
        XCTAssertEqual(Vec3f.axisZ, Vec3f(0,0,1))
    }
    
    
    func testQuat() {
        let refMat = unsafeBitCast(GLKMatrix4MakeRotation(radians(33), 1, 0, 0), to: Mat4x4f.self)
        let mat = Mat4x4f(Quat4f(angle: radians(33), axis: .axisX))
        XCTAssertEqual(mat, refMat)
    }
}


*/
