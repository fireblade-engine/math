//
//  SwiftStandardLibraryRedundancyTests.swift
//  FirebladeMathTests
//

import FirebladeMath
import Testing

struct SwiftStandardLibraryRedundancyTests {
    // MARK: - Core Global Functions

    @Test
    @available(*, deprecated, message: "Testing deprecated API")
    func testAbsRedundancy() {
        let doubleVal: Double = -123.45
        let floatVal: Float = -123.45

        #expect(FirebladeMath.abs(doubleVal) == Swift.abs(doubleVal))
        #expect(FirebladeMath.abs(doubleVal) == doubleVal.magnitude)
        #expect(FirebladeMath.abs(floatVal) == Swift.abs(floatVal))
        #expect(FirebladeMath.abs(floatVal) == floatVal.magnitude)
    }

    @Test
    @available(*, deprecated, message: "Testing deprecated API")
    func testMinRedundancy() {
        let doubleA: Double = 12.34
        let doubleB: Double = 56.78
        let floatA: Float = 12.34
        let floatB: Float = 56.78

        #expect(FirebladeMath.min(doubleA, doubleB) == Swift.min(doubleA, doubleB))
        #expect(FirebladeMath.min(floatA, floatB) == Swift.min(floatA, floatB))
    }

    @Test
    @available(*, deprecated, message: "Testing deprecated API")
    func testMaxRedundancy() {
        let doubleA: Double = 12.34
        let doubleB: Double = 56.78
        let floatA: Float = 12.34
        let floatB: Float = 56.78

        #expect(FirebladeMath.max(doubleA, doubleB) == Swift.max(doubleA, doubleB))
        #expect(FirebladeMath.max(floatA, floatB) == Swift.max(floatA, floatB))
    }

    // MARK: - FloatingPoint Protocol Methods

    @Test func testSqrtRedundancy() {
        let doubleVal: Double = 144.0
        let floatVal: Float = 144.0

        #expect(FirebladeMath.sqrt(doubleVal) == doubleVal.squareRoot())
        #expect(FirebladeMath.sqrt(floatVal) == floatVal.squareRoot())
    }

    @Test func testFloorRedundancy() {
        let doubleVal: Double = 123.45
        let floatVal: Float = 123.45

        #expect(FirebladeMath.floor(doubleVal) == doubleVal.rounded(.down))
        #expect(FirebladeMath.floor(floatVal) == floatVal.rounded(.down))
    }

    @Test func testCeilRedundancy() {
        let doubleVal: Double = 123.45
        let floatVal: Float = 123.45

        #expect(FirebladeMath.ceil(doubleVal) == doubleVal.rounded(.up))
        #expect(FirebladeMath.ceil(floatVal) == floatVal.rounded(.up))
    }

    @Test func testCopySignRedundancy() {
        let doubleMagnitude: Double = 10.0
        let doubleSign: Double = -1.0
        let floatMagnitude: Float = 10.0
        let floatSign: Float = -1.0

        let expectedDouble = Double(signOf: doubleSign, magnitudeOf: doubleMagnitude)
        let expectedFloat = Float(signOf: floatSign, magnitudeOf: floatMagnitude)

        #expect(FirebladeMath.copysign(doubleMagnitude, doubleSign) == expectedDouble)
        #expect(FirebladeMath.copysign(floatMagnitude, floatSign) == expectedFloat)
    }

    @Test func testModRedundancy() {
        let doubleX: Double = 123.0
        let doubleY: Double = 5.0
        let floatX: Float = 123.0
        let floatY: Float = 5.0

        #expect(FirebladeMath.mod(doubleX, doubleY) == doubleX.truncatingRemainder(dividingBy: doubleY))
        #expect(FirebladeMath.mod(floatX, floatY) == floatX.truncatingRemainder(dividingBy: floatY))
    }

    @Test func testIsInfiniteRedundancy() {
        let doubleInf = Double.infinity
        let floatInf = Float.infinity
        let doubleFinite = 123.45
        let floatFinite: Float = 123.45

        #expect(FirebladeMath.isInfinite(doubleInf) == doubleInf.isInfinite)
        #expect(FirebladeMath.isInfinite(floatInf) == floatInf.isInfinite)
        #expect(FirebladeMath.isInfinite(doubleFinite) == doubleFinite.isInfinite)
        #expect(FirebladeMath.isInfinite(floatFinite) == floatFinite.isInfinite)
    }

    @Test func testIsNegativeInfinityRedundancy() {
        let doubleNegInf = -Double.infinity
        let doublePosInf = Double.infinity
        let floatNegInf = -Float.infinity
        let floatPosInf = Float.infinity

        #expect(FirebladeMath.isNegativeInfinity(doubleNegInf) == (doubleNegInf.isInfinite && doubleNegInf.sign == .minus))
        #expect(FirebladeMath.isNegativeInfinity(doublePosInf) == (doublePosInf.isInfinite && doublePosInf.sign == .minus))
        #expect(FirebladeMath.isNegativeInfinity(floatNegInf) == (floatNegInf.isInfinite && floatNegInf.sign == .minus))
        #expect(FirebladeMath.isNegativeInfinity(floatPosInf) == (floatPosInf.isInfinite && floatPosInf.sign == .minus))
    }

    @Test func testIsPositiveInfinityRedundancy() {
        let doubleNegInf = -Double.infinity
        let doublePosInf = Double.infinity
        let floatNegInf = -Float.infinity
        let floatPosInf = Float.infinity

        #expect(FirebladeMath.isPositiveInfinity(doubleNegInf) == (doubleNegInf.isInfinite && doubleNegInf.sign == .plus))
        #expect(FirebladeMath.isPositiveInfinity(doublePosInf) == (doublePosInf.isInfinite && doublePosInf.sign == .plus))
        #expect(FirebladeMath.isPositiveInfinity(floatNegInf) == (floatNegInf.isInfinite && floatNegInf.sign == .plus))
        #expect(FirebladeMath.isPositiveInfinity(floatPosInf) == (floatPosInf.isInfinite && floatPosInf.sign == .plus))
    }

    @Test func testIsNegativeZeroRedundancy() {
        let doubleNegZero = -0.0
        let doublePosZero = 0.0
        let floatNegZero: Float = -0.0
        let floatPosZero: Float = 0.0

        #expect(FirebladeMath.isNegativeZero(doubleNegZero) == (doubleNegZero.isZero && doubleNegZero.sign == .minus))
        #expect(FirebladeMath.isNegativeZero(doublePosZero) == (doublePosZero.isZero && doublePosZero.sign == .minus))
        #expect(FirebladeMath.isNegativeZero(floatNegZero) == (floatNegZero.isZero && floatNegZero.sign == .minus))
        #expect(FirebladeMath.isNegativeZero(floatPosZero) == (floatPosZero.isZero && floatPosZero.sign == .minus))
    }

    @Test func testIsPositiveZeroRedundancy() {
        let doubleNegZero = -0.0
        let doublePosZero = 0.0
        let floatNegZero: Float = -0.0
        let floatPosZero: Float = 0.0

        #expect(FirebladeMath.isPositiveZero(doubleNegZero) == (doubleNegZero.isZero && doubleNegZero.sign == .plus))
        #expect(FirebladeMath.isPositiveZero(doublePosZero) == (doublePosZero.isZero && doublePosZero.sign == .plus))
        #expect(FirebladeMath.isPositiveZero(floatNegZero) == (floatNegZero.isZero && floatNegZero.sign == .plus))
        #expect(FirebladeMath.isPositiveZero(floatPosZero) == (floatPosZero.isZero && floatPosZero.sign == .plus))
    }

    // MARK: - SIMD Vector Features

    @Test func testSIMDSequenceAndCollectionRedundancy() {
        let simd2 = SIMD2<Float>(1.0, 2.0)
        let simd3 = SIMD3<Double>(3.0, 4.0, 5.0)
        let simd4 = SIMD4<Float>(6.0, 7.0, 8.0, 9.0)

        // Swift Standard Library natively constructs Arrays from SIMD vectors via Sequence/Collection
        #expect(Array(simd2) == simd2.elements)
        #expect(Array(simd3) == simd3.elements)
        #expect(Array(simd4) == simd4.elements)
    }

    @Test func testSIMDClampedRedundancy() {
        let simd2 = SIMD2<Float>(10.0, -5.0)
        let minBound = SIMD2<Float>(0.0, 0.0)
        let maxBound = SIMD2<Float>(5.0, 5.0)

        // Native Swift.SIMD method
        #expect(simd2.clamped(lowerBound: minBound, upperBound: maxBound) == SIMD2<Float>(5.0, 0.0))

        let scalarVal: Float = 10.0
        #expect(FirebladeMath.clamp(scalarVal, 0.0, 5.0) == 5.0)
    }

    @Test func testSIMDDotProductRedundancy() {
        let v1 = SIMD3<Double>(1.0, 2.0, 3.0)
        let v2 = SIMD3<Double>(4.0, 5.0, 6.0)

        // Native SIMD sum for dot product
        let stdLibDot = (v1 * v2).sum()
        #expect(FirebladeMath.dot(v1, v2) == stdLibDot)
    }

    @Test func testSIMDIsNaNRedundancy() {
        let validVec = SIMD3<Float>(1.0, 2.0, 3.0)
        let nanVec = SIMD3<Float>(1.0, Float.nan, 3.0)

        let stdLibValidIsNaN = validVec.x.isNaN || validVec.y.isNaN || validVec.z.isNaN
        let stdLibNanIsNaN = nanVec.x.isNaN || nanVec.y.isNaN || nanVec.z.isNaN

        #expect(validVec.isNaN == stdLibValidIsNaN)
        #expect(nanVec.isNaN == stdLibNanIsNaN)
    }

    // MARK: - Standard Math Overlays

    @Test func testTrigonometricFunctionsRedundancy() {
        let d: Double = 0.5
        let f: Float = 0.5

        #expect(FirebladeMath.sin(d) == sin(d))
        #expect(FirebladeMath.sin(f) == sin(f))
        #expect(FirebladeMath.cos(d) == cos(d))
        #expect(FirebladeMath.cos(f) == cos(f))
        #expect(FirebladeMath.tan(d) == tan(d))
        #expect(FirebladeMath.tan(f) == tan(f))
        #expect(FirebladeMath.asin(d) == asin(d))
        #expect(FirebladeMath.asin(f) == asin(f))
        #expect(FirebladeMath.acos(d) == acos(d))
        #expect(FirebladeMath.acos(f) == acos(f))
        #expect(FirebladeMath.atan(d) == atan(d))
        #expect(FirebladeMath.atan(f) == atan(f))
        #expect(FirebladeMath.atan2(d, d) == atan2(d, d))
        #expect(FirebladeMath.atan2(f, f) == atan2(f, f))
    }

    @Test func testHyperbolicFunctionsRedundancy() {
        let d: Double = 0.5
        let f: Float = 0.5

        #expect(FirebladeMath.sinh(d) == sinh(d))
        #expect(FirebladeMath.sinh(f) == sinh(f))
        #expect(FirebladeMath.cosh(d) == cosh(d))
        #expect(FirebladeMath.cosh(f) == cosh(f))
        #expect(FirebladeMath.tanh(d) == tanh(d))
        #expect(FirebladeMath.tanh(f) == tanh(f))
        #expect(FirebladeMath.asinh(d) == asinh(d))
        #expect(FirebladeMath.asinh(f) == asinh(f))
        #expect(FirebladeMath.acosh(123.0 as Double) == acosh(123.0 as Double))
        #expect(FirebladeMath.acosh(123.0 as Float) == acosh(123.0 as Float))
        #expect(FirebladeMath.atanh(d) == atanh(d))
        #expect(FirebladeMath.atanh(f) == atanh(f))
    }

    @Test func testExponentialAndLogarithmicFunctionsRedundancy() {
        let d: Double = 2.0
        let f: Float = 2.0

        #expect(FirebladeMath.exp(d) == exp(d))
        #expect(FirebladeMath.exp(f) == exp(f))
        #expect(FirebladeMath.exp2(d) == exp2(d))
        #expect(FirebladeMath.exp2(f) == exp2(f))
        #expect(FirebladeMath.log(d) == log(d))
        #expect(FirebladeMath.log(f) == log(f))
        #expect(FirebladeMath.log2(d) == log2(d))
        #expect(FirebladeMath.log2(f) == log2(f))
        #expect(FirebladeMath.log10(d) == log10(d))
        #expect(FirebladeMath.log10(f) == log10(f))
        #expect(FirebladeMath.pow(d, 3.0) == pow(d, 3.0))
        #expect(FirebladeMath.pow(f, 3.0) == pow(f, 3.0))
        #expect(FirebladeMath.pow2(d) == exp2(d))
        #expect(FirebladeMath.pow2(f) == exp2(f))
        #expect(FirebladeMath.hypot(3.0 as Double, 4.0 as Double) == hypot(3.0 as Double, 4.0 as Double))
        #expect(FirebladeMath.hypot(3.0 as Float, 4.0 as Float) == hypot(3.0 as Float, 4.0 as Float))
    }
}
