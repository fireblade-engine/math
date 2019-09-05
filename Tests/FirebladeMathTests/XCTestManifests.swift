#if !canImport(ObjectiveC)
import XCTest

extension FunctionTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FunctionTests = [
        ("test_abs", test_abs),
        ("test_acos", test_acos),
        ("test_acosh", test_acosh),
        ("test_asin", test_asin),
        ("test_asinh", test_asinh),
        ("test_atan", test_atan),
        ("test_atan2", test_atan2),
        ("test_atanh", test_atanh),
        ("test_ceil", test_ceil),
        ("test_clamp", test_clamp),
        ("test_cos", test_cos),
        ("test_cosh", test_cosh),
        ("test_degrees", test_degrees),
        ("test_distance", test_distance),
        ("test_dot", test_dot),
        ("test_exp", test_exp),
        ("test_exp2", test_exp2),
        ("test_faceforward", test_faceforward),
        ("test_floor", test_floor),
        ("test_fract", test_fract),
        ("test_hypot", test_hypot),
        ("test_isInfinite", test_isInfinite),
        ("test_isNegativeInfinity", test_isNegativeInfinity),
        ("test_isNegativeZero", test_isNegativeZero),
        ("test_isPositiveInfinity", test_isPositiveInfinity),
        ("test_isPositiveZero", test_isPositiveZero),
        ("test_length", test_length),
        ("test_log", test_log),
        ("test_log10", test_log10),
        ("test_log2", test_log2),
        ("test_max", test_max),
        ("test_min", test_min),
        ("test_mix", test_mix),
        ("test_mod", test_mod),
        ("test_normalize", test_normalize),
        ("test_pow", test_pow),
        ("test_pow2", test_pow2),
        ("test_radians", test_radians),
        ("test_reflect", test_reflect),
        ("test_refract", test_refract),
        ("test_rsqrt", test_rsqrt),
        ("test_sign", test_sign),
        ("test_sin", test_sin),
        ("test_sinh", test_sinh),
        ("test_smoothstep", test_smoothstep),
        ("test_sqrt", test_sqrt),
        ("test_step", test_step),
        ("test_tan", test_tan),
        ("test_tanh", test_tanh),
        ("test_trunc", test_trunc)
    ]
}

extension Mat4x4fTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__Mat4x4fTests = [
        ("testEquality", testEquality),
        ("testIdentity", testIdentity),
        ("testInitArrayValues", testInitArrayValues),
        ("testInitDiagonal", testInitDiagonal),
        ("testInitVectorColumns", testInitVectorColumns),
        ("testLookAt", testLookAt),
        ("testOrthographic", testOrthographic),
        ("testPerspective", testPerspective),
        ("testQuaternionInit", testQuaternionInit),
        ("testRotateMatrixByAngleAroundAxes", testRotateMatrixByAngleAroundAxes),
        ("testRotationInitX", testRotationInitX),
        ("testRotationInitXZ", testRotationInitXZ),
        ("testRotationInitY", testRotationInitY),
        ("testRotationInitZ", testRotationInitZ),
        ("testScaleInit", testScaleInit),
        ("testScaleMatrixByVector", testScaleMatrixByVector),
        ("testTranslateMatrixByVector", testTranslateMatrixByVector),
        ("testTranslationInit", testTranslationInit),
        ("testUpperLeft", testUpperLeft)
    ]
}

extension Quat4fTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__Quat4fTests = [
        ("testAdd", testAdd),
        ("testAngle", testAngle),
        ("testAngleAxisX", testAngleAxisX),
        ("testAngleAxisXY", testAngleAxisXY),
        ("testAngleAxisY", testAngleAxisY),
        ("testAngleAxisZ", testAngleAxisZ),
        ("testArrayInit", testArrayInit),
        ("testArrayLiteralInit", testArrayLiteralInit),
        ("testAxis", testAxis),
        ("testConjugate", testConjugate),
        ("testElementsInit", testElementsInit),
        ("testEquality", testEquality),
        ("testIdentity", testIdentity),
        ("testInverse", testInverse),
        ("testLength", testLength),
        ("testMultipy", testMultipy),
        ("testNormalize", testNormalize),
        ("testSubtract", testSubtract),
        ("testVectorInit", testVectorInit)
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FunctionTests.__allTests__FunctionTests),
        testCase(Mat4x4fTests.__allTests__Mat4x4fTests),
        testCase(Quat4fTests.__allTests__Quat4fTests)
    ]
}
#endif
