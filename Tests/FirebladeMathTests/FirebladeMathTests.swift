import XCTest
@testable import FirebladeMath

class FirebladeMathTests: XCTestCase {

	func testMat4x4fMultiplicationOperator() {

		let resMat: Mat4x4f = Mat4x4f(diagonal: Vec4f(2)) * Mat4x4f(diagonal: Vec4f(3))

		XCTAssert(resMat != Mat4x4f.init(diagonal: Vec4f(1)))
	}
}
