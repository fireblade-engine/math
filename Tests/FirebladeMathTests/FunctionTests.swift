//
//  FunctionTests.swift
//  FirebladeMathTests
//
//  Created by Christian Treffs on 26.08.19.
//

import func XCTest.XCTAssertNotNil
import class XCTest.XCTestCase
import FirebladeMath

final class FunctionTests: XCTestCase {
    func test_abs() {
        XCTAssertNotNil(FirebladeMath.abs(Double(123)))
        XCTAssertNotNil(FirebladeMath.abs(Float(123)))
    }
    func test_acos() {
        XCTAssertNotNil(FirebladeMath.acos(Double(123)))
        XCTAssertNotNil(FirebladeMath.acos(Float(123)))
    }
    func test_acosh() {
        XCTAssertNotNil(FirebladeMath.acosh(Double(123)))
        XCTAssertNotNil(FirebladeMath.acosh(Float(123)))
    }
    func test_asin() {
        XCTAssertNotNil(FirebladeMath.asin(Double(123)))
        XCTAssertNotNil(FirebladeMath.asin(Float(123)))
    }
    func test_asinh() {
        XCTAssertNotNil(FirebladeMath.asinh(Double(123)))
        XCTAssertNotNil(FirebladeMath.asinh(Float(123)))
    }
    func test_atan() {
        XCTAssertNotNil(FirebladeMath.atan(Double(123)))
        XCTAssertNotNil(FirebladeMath.atan(Float(123)))
    }
    func test_atan2() {
        XCTAssertNotNil(FirebladeMath.atan2(Double(123), Double(123)))
        XCTAssertNotNil(FirebladeMath.atan2(Float(123), Float(123)))
    }
    func test_atanh() {
        XCTAssertNotNil(FirebladeMath.atanh(Double(123)))
        XCTAssertNotNil(FirebladeMath.atanh(Float(123)))
    }
    func test_ceil() {
        XCTAssertNotNil(FirebladeMath.ceil(Double(123)))
        XCTAssertNotNil(FirebladeMath.ceil(Float(123)))
    }
    func test_clamp() {
        XCTAssertNotNil(FirebladeMath.clamp(Double(123), Double(1), Double(1000)))
        XCTAssertNotNil(FirebladeMath.clamp(Float(123), Float(1), Float(1000)))
    }
    func test_cos() {
        XCTAssertNotNil(FirebladeMath.cos(Double(123)))
        XCTAssertNotNil(FirebladeMath.cos(Float(123)))
    }
    func test_cosh() {
        XCTAssertNotNil(FirebladeMath.cosh(Double(123)))
        XCTAssertNotNil(FirebladeMath.cosh(Float(123)))
    }
    func test_degrees() {
        XCTAssertNotNil(FirebladeMath.degrees(Double(123)))
        XCTAssertNotNil(FirebladeMath.degrees(Float(123)))
    }
    func test_distance() {
        XCTAssertNotNil(FirebladeMath.distance(Double(123), Double(123)))
        XCTAssertNotNil(FirebladeMath.distance(Float(123), Float(123)))
    }
    func test_dot() {
        XCTAssertNotNil(FirebladeMath.dot(SIMD2<Double>(1, 2), SIMD2<Double>(3, 4)))
        XCTAssertNotNil(FirebladeMath.dot(SIMD3<Double>(1, 2, 3), SIMD3<Double>(4, 5, 6)))
        XCTAssertNotNil(FirebladeMath.dot(SIMD4<Double>(1, 2, 3, 4), SIMD4<Double>(5, 6, 7, 8)))

        XCTAssertNotNil(FirebladeMath.dot(SIMD2<Float>(1, 2), SIMD2<Float>(3, 4)))
        XCTAssertNotNil(FirebladeMath.dot(SIMD3<Float>(1, 2, 3), SIMD3<Float>(4, 5, 6)))
        XCTAssertNotNil(FirebladeMath.dot(SIMD4<Float>(1, 2, 3, 4), SIMD4<Float>(5, 6, 7, 8)))
    }
    func test_exp() {
        XCTAssertNotNil(FirebladeMath.exp(Double(123)))
        XCTAssertNotNil(FirebladeMath.exp(Float(123)))
    }
    func test_exp2() {
        XCTAssertNotNil(FirebladeMath.exp2(Double(123)))
        XCTAssertNotNil(FirebladeMath.exp2(Float(123)))
    }
    func test_faceforward() {
        XCTAssertNotNil(FirebladeMath.faceforward(n: Double(1), i: Double(2), nref: Double(3)))
        XCTAssertNotNil(FirebladeMath.faceforward(n: Float(1), i: Float(2), nref: Float(3)))
    }
    func test_floor() {
        XCTAssertNotNil(FirebladeMath.floor(Double(123)))
        XCTAssertNotNil(FirebladeMath.floor(Float(123)))
    }
    func test_fract() {
        XCTAssertNotNil(FirebladeMath.fract(Double(123)))
        XCTAssertNotNil(FirebladeMath.fract(Float(123)))
    }
    func test_hypot() {
        XCTAssertNotNil(FirebladeMath.hypot(Double(1), Double(2)))
        XCTAssertNotNil(FirebladeMath.hypot(Float(1), Float(2)))
    }
    func test_isInfinite() {
        XCTAssertNotNil(FirebladeMath.isInfinite(Double(123)))
        XCTAssertNotNil(FirebladeMath.isInfinite(Float(123)))
    }
    func test_isNegativeInfinity() {
        XCTAssertNotNil(FirebladeMath.isNegativeInfinity(Double(123)))
        XCTAssertNotNil(FirebladeMath.isNegativeInfinity(Float(123)))
    }
    func test_isNegativeZero() {
        XCTAssertNotNil(FirebladeMath.isNegativeZero(Double(123)))
        XCTAssertNotNil(FirebladeMath.isNegativeZero(Float(123)))
    }
    func test_isPositiveInfinity() {
        XCTAssertNotNil(FirebladeMath.isPositiveInfinity(Double(123)))
        XCTAssertNotNil(FirebladeMath.isPositiveInfinity(Float(123)))
    }
    func test_isPositiveZero() {
        XCTAssertNotNil(FirebladeMath.isPositiveZero(Double(123)))
        XCTAssertNotNil(FirebladeMath.isPositiveZero(Float(123)))
    }
    func test_length() {
        XCTAssertNotNil(FirebladeMath.length(SIMD2<Double>(1, 2)))
        XCTAssertNotNil(FirebladeMath.length(SIMD3<Double>(1, 2, 3)))
        XCTAssertNotNil(FirebladeMath.length(SIMD4<Double>(1, 2, 3, 4)))

        XCTAssertNotNil(FirebladeMath.length(SIMD2<Float>(1, 2)))
        XCTAssertNotNil(FirebladeMath.length(SIMD3<Float>(1, 2, 3)))
        XCTAssertNotNil(FirebladeMath.length(SIMD4<Float>(1, 2, 3, 4)))
    }
    func test_log() {
        XCTAssertNotNil(FirebladeMath.log(Double(123)))
        XCTAssertNotNil(FirebladeMath.log(Float(123)))
    }
    func test_log2() {
        XCTAssertNotNil(FirebladeMath.log2(Double(123)))
        XCTAssertNotNil(FirebladeMath.log2(Float(123)))
    }
    func test_log10() {
        XCTAssertNotNil(FirebladeMath.log10(Double(123)))
        XCTAssertNotNil(FirebladeMath.log10(Float(123)))
    }
    func test_max() {
        XCTAssertNotNil(FirebladeMath.max(Double(123), Double(123)))
        XCTAssertNotNil(FirebladeMath.max(Float(123), Float(123)))
    }
    func test_min() {
        XCTAssertNotNil(FirebladeMath.min(Double(123), Double(123)))
        XCTAssertNotNil(FirebladeMath.min(Float(123), Float(123)))
    }
    func test_mix() {
        XCTAssertNotNil(FirebladeMath.mix(Double(123), Double(123), Double(123)))
        XCTAssertNotNil(FirebladeMath.mix(Float(123), Float(123), Float(123)))
    }
    func test_mod() {
        XCTAssertNotNil(FirebladeMath.mod(Double(123), Double(123)))
        XCTAssertNotNil(FirebladeMath.mod(Float(123), Float(123)))
    }
    func test_normalize() {
        XCTAssertNotNil(FirebladeMath.normalize(SIMD2<Double>(1, 2)))
        XCTAssertNotNil(FirebladeMath.normalize(SIMD3<Double>(1, 2, 3)))
        XCTAssertNotNil(FirebladeMath.normalize(SIMD4<Double>(1, 2, 3, 4)))

        XCTAssertNotNil(FirebladeMath.normalize(SIMD2<Float>(1, 2)))
        XCTAssertNotNil(FirebladeMath.normalize(SIMD3<Float>(1, 2, 3)))
        XCTAssertNotNil(FirebladeMath.normalize(SIMD4<Float>(1, 2, 3, 4)))
    }
    func test_pow() {
        XCTAssertNotNil(FirebladeMath.pow(Double(123), Double(2)))
        XCTAssertNotNil(FirebladeMath.pow(Float(123), Float(2)))
    }
    func test_pow2() {
        XCTAssertNotNil(FirebladeMath.pow2(Double(123)))
        XCTAssertNotNil(FirebladeMath.pow2(Float(123)))
    }
    func test_radians() {
        XCTAssertNotNil(FirebladeMath.radians(Double(123)))
        XCTAssertNotNil(FirebladeMath.radians(Float(123)))
    }
    func test_reflect() {
        XCTAssertNotNil(FirebladeMath.reflect(Double(123), Double(123)))
        XCTAssertNotNil(FirebladeMath.reflect(Float(123), Float(123)))
    }
    func test_refract() {
        XCTAssertNotNil(FirebladeMath.refract(Double(123), Double(123), Double(123)))
        XCTAssertNotNil(FirebladeMath.refract(Float(123), Float(123), Float(123)))
    }
    func test_rsqrt() {
        XCTAssertNotNil(FirebladeMath.rsqrt(Double(123)))
        XCTAssertNotNil(FirebladeMath.rsqrt(Float(123)))
    }
    func test_sign() {
        XCTAssertNotNil(FirebladeMath.sign(Double(123)))
        XCTAssertNotNil(FirebladeMath.sign(Float(123)))
    }
    func test_sin() {
        XCTAssertNotNil(FirebladeMath.sin(Double(123)))
        XCTAssertNotNil(FirebladeMath.sin(Float(123)))
    }
    func test_sinh() {
        XCTAssertNotNil(FirebladeMath.sinh(Double(123)))
        XCTAssertNotNil(FirebladeMath.sinh(Float(123)))
    }
    func test_smoothstep() {
        XCTAssertNotNil(FirebladeMath.smoothstep(Double(123), Double(123), Double(123)))
        XCTAssertNotNil(FirebladeMath.smoothstep(Float(123), Float(123), Float(123)))
    }
    func test_sqrt() {
        XCTAssertNotNil(FirebladeMath.sqrt(Double(123)))
        XCTAssertNotNil(FirebladeMath.sqrt(Float(123)))
    }
    func test_step() {
        XCTAssertNotNil(FirebladeMath.step(Double(123), Double(123)))
        XCTAssertNotNil(FirebladeMath.step(Float(123), Float(123)))
    }
    func test_tan() {
        XCTAssertNotNil(FirebladeMath.tan(Double(123)))
        XCTAssertNotNil(FirebladeMath.tan(Float(123)))
    }
    func test_tanh() {
        XCTAssertNotNil(FirebladeMath.tanh(Double(123)))
        XCTAssertNotNil(FirebladeMath.tanh(Float(123)))
    }
    func test_trunc() {
        XCTAssertNotNil(FirebladeMath.trunc(Double(123)))
        XCTAssertNotNil(FirebladeMath.trunc(Float(123)))
    }
}
