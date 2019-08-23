#if !canImport(ObjectiveC)
import XCTest

extension EqualityCheckTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__EqualityCheckTests = [
        ("testSimd_float4x4EqualsCATransform3D", testSimd_float4x4EqualsCATransform3D),
        ("testSimd_float4x4EqualsGLMatrix4", testSimd_float4x4EqualsGLMatrix4),
    ]
}

extension Mat4x4fTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__Mat4x4fTests = [
        ("testArrayInit", testArrayInit),
        ("testDiagonal", testDiagonal),
        ("testEuler", testEuler),
        ("testGetScale", testGetScale),
        ("testGetTranslation", testGetTranslation),
        ("testIdentity", testIdentity),
        ("testLookAt", testLookAt),
        ("testOrthographic", testOrthographic),
        ("testPerspective", testPerspective),
        ("testQuaternionInit", testQuaternionInit),
        ("testRotateBy", testRotateBy),
        ("testRotationInit", testRotationInit),
        ("testScaleBy", testScaleBy),
        ("testScaleInit", testScaleInit),
        ("testTranslateBy", testTranslateBy),
        ("testTranslationInit", testTranslationInit),
        ("testUpperLeft", testUpperLeft),
        ("testVectorColumnsInit", testVectorColumnsInit),
    ]
}

extension Quat4fTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__Quat4fTests = [
        ("testAngleAndAxis", testAngleAndAxis),
        ("testGetYawPitchRoll", testGetYawPitchRoll),
        ("testInitYawPitchRoll", testInitYawPitchRoll),
        ("testSIMDQuatAngleBug", testSIMDQuatAngleBug),
        ("testVectorInit", testVectorInit),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(EqualityCheckTests.__allTests__EqualityCheckTests),
        testCase(Mat4x4fTests.__allTests__Mat4x4fTests),
        testCase(Quat4fTests.__allTests__Quat4fTests),
    ]
}
#endif