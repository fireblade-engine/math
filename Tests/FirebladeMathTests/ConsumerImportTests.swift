//
//  ConsumerImportTests.swift
//  FirebladeMathTests
//

// This file simulates a typical consumer that imports FirebladeMath alongside the
// platform math libraries. Every call below is intentionally *unqualified*:
// if any FirebladeMath function becomes ambiguous with a Foundation/libc/simd
// counterpart this file stops compiling.
//
// Each test also checks that whichever overload wins resolution produces the
// same result as the explicitly qualified FirebladeMath function.
//
// Do not use `@testable import` here; it changes overload resolution.

import FirebladeMath
import Foundation
#if canImport(simd)
import simd
#endif
import Testing

struct ConsumerImportTests {
    let f: Float = 0.3
    let d: Double = 0.3

    @Test func trigonometry() {
        #expect(sin(f) == FirebladeMath.sin(f))
        #expect(sin(d) == FirebladeMath.sin(d))
        #expect(cos(f) == FirebladeMath.cos(f))
        #expect(cos(d) == FirebladeMath.cos(d))
        #expect(tan(f) == FirebladeMath.tan(f))
        #expect(tan(d) == FirebladeMath.tan(d))
        #expect(asin(f) == FirebladeMath.asin(f))
        #expect(asin(d) == FirebladeMath.asin(d))
        #expect(acos(f) == FirebladeMath.acos(f))
        #expect(acos(d) == FirebladeMath.acos(d))
        #expect(atan(f) == FirebladeMath.atan(f))
        #expect(atan(d) == FirebladeMath.atan(d))
        #expect(atan2(f, f) == FirebladeMath.atan2(f, f))
        #expect(atan2(d, d) == FirebladeMath.atan2(d, d))
    }

    @Test func hyperbolic() {
        #expect(sinh(f) == FirebladeMath.sinh(f))
        #expect(sinh(d) == FirebladeMath.sinh(d))
        #expect(cosh(f) == FirebladeMath.cosh(f))
        #expect(cosh(d) == FirebladeMath.cosh(d))
        #expect(tanh(f) == FirebladeMath.tanh(f))
        #expect(tanh(d) == FirebladeMath.tanh(d))
        #expect(asinh(f) == FirebladeMath.asinh(f))
        #expect(asinh(d) == FirebladeMath.asinh(d))
        #expect(acosh(f + 1) == FirebladeMath.acosh(f + 1))
        #expect(acosh(d + 1) == FirebladeMath.acosh(d + 1))
        #expect(atanh(f) == FirebladeMath.atanh(f))
        #expect(atanh(d) == FirebladeMath.atanh(d))
    }

    @Test func exponentialAndPower() {
        #expect(exp(f) == FirebladeMath.exp(f))
        #expect(exp(d) == FirebladeMath.exp(d))
        #expect(exp2(f) == FirebladeMath.exp2(f))
        #expect(exp2(d) == FirebladeMath.exp2(d))
        #expect(log(f) == FirebladeMath.log(f))
        #expect(log(d) == FirebladeMath.log(d))
        #expect(log2(f) == FirebladeMath.log2(f))
        #expect(log2(d) == FirebladeMath.log2(d))
        #expect(log10(f) == FirebladeMath.log10(f))
        #expect(log10(d) == FirebladeMath.log10(d))
        #expect(pow(f, f) == FirebladeMath.pow(f, f))
        #expect(pow(d, d) == FirebladeMath.pow(d, d))
        #expect(pow2(f) == FirebladeMath.pow2(f))
        #expect(pow2(d) == FirebladeMath.pow2(d))
        #expect(sqrt(f) == FirebladeMath.sqrt(f))
        #expect(sqrt(d) == FirebladeMath.sqrt(d))
        #expect(isClose(rsqrt(f), FirebladeMath.rsqrt(f)))
        #expect(isClose(rsqrt(d), FirebladeMath.rsqrt(d)))
        #expect(hypot(f, f) == FirebladeMath.hypot(f, f))
        #expect(hypot(d, d) == FirebladeMath.hypot(d, d))
    }

    @Test func rounding() {
        #expect(floor(f) == FirebladeMath.floor(f))
        #expect(floor(d) == FirebladeMath.floor(d))
        #expect(ceil(f) == FirebladeMath.ceil(f))
        #expect(ceil(d) == FirebladeMath.ceil(d))
        #expect(fract(f) == FirebladeMath.fract(f))
        #expect(fract(d) == FirebladeMath.fract(d))
        #expect(mod(f, 0.1) == FirebladeMath.mod(f, 0.1))
        #expect(mod(d, 0.1) == FirebladeMath.mod(d, 0.1))
        #expect(copysign(f, -1) == FirebladeMath.copysign(f, -1))
        #expect(copysign(d, -1) == FirebladeMath.copysign(d, -1))
    }

    @Test func scalarUtilities() {
        #expect(sign(f) == FirebladeMath.sign(f))
        #expect(sign(d) == FirebladeMath.sign(d))
        #expect(step(f, 0.5) == FirebladeMath.step(f, 0.5))
        #expect(step(d, 0.5) == FirebladeMath.step(d, 0.5))
        #expect(clamp(f, 0, 0.2) == FirebladeMath.clamp(f, 0, 0.2))
        #expect(clamp(d, 0, 0.2) == FirebladeMath.clamp(d, 0, 0.2))
        #expect(clamp(f, min: 0, max: 0.2) == FirebladeMath.clamp(f, min: 0, max: 0.2))
        #expect(saturate(d + 1) == FirebladeMath.saturate(d + 1))
        #expect(mix(f, 1, 0.5) == FirebladeMath.mix(f, 1, 0.5))
        #expect(mix(d, 1, 0.5) == FirebladeMath.mix(d, 1, 0.5))
        #expect(lerp(d, 1, 0.5) == FirebladeMath.lerp(d, 1, 0.5))
        #expect(interpolate(d, 1, 0.5) == FirebladeMath.interpolate(d, 1, 0.5))
        #expect(lerpPrecise(d, 1, 0.5) == FirebladeMath.lerpPrecise(d, 1, 0.5))
        #expect(smoothstep(Float(0), 1, f) == FirebladeMath.smoothstep(Float(0), 1, f))
        #expect(smoothstep(0, 1, d) == FirebladeMath.smoothstep(0, 1, d))
        #expect(distance(f, 1) == FirebladeMath.distance(f, 1))
        #expect(distance(d, 1) == FirebladeMath.distance(d, 1))
        #expect(degrees(f) == FirebladeMath.degrees(f))
        #expect(degrees(d) == FirebladeMath.degrees(d))
        #expect(radians(f) == FirebladeMath.radians(f))
        #expect(radians(d) == FirebladeMath.radians(d))
        #expect(degrees(Vec3f(f, f, f)) == FirebladeMath.degrees(Vec3f(f, f, f)))
        #expect(radians(Vec3f(f, f, f)) == FirebladeMath.radians(Vec3f(f, f, f)))
        #expect(reflect(f, 1) == FirebladeMath.reflect(f, 1))
        #expect(reflect(d, 1) == FirebladeMath.reflect(d, 1))
        #expect(refract(f, 1, 0.5) == FirebladeMath.refract(f, 1, 0.5))
        #expect(refract(d, 1, 0.5) == FirebladeMath.refract(d, 1, 0.5))
        #expect(faceforward(n: f, i: 1, nref: 1) == FirebladeMath.faceforward(n: f, i: 1, nref: 1))
        #expect(faceforward(n: d, i: 1, nref: 1) == FirebladeMath.faceforward(n: d, i: 1, nref: 1))
        #expect(isInfinite(f) == FirebladeMath.isInfinite(f))
        #expect(isInfinite(d) == FirebladeMath.isInfinite(d))
        #expect(isNegativeZero(-Float.zero) == FirebladeMath.isNegativeZero(-Float.zero))
        #expect(isNegativeZero(-Double.zero) == FirebladeMath.isNegativeZero(-Double.zero))
        #expect(isPositiveZero(Float.zero) == FirebladeMath.isPositiveZero(Float.zero))
        #expect(isPositiveZero(Double.zero) == FirebladeMath.isPositiveZero(Double.zero))
        #expect(isNegativeInfinity(-Float.infinity) == FirebladeMath.isNegativeInfinity(-Float.infinity))
        #expect(isNegativeInfinity(-Double.infinity) == FirebladeMath.isNegativeInfinity(-Double.infinity))
        #expect(isPositiveInfinity(Float.infinity) == FirebladeMath.isPositiveInfinity(Float.infinity))
        #expect(isPositiveInfinity(Double.infinity) == FirebladeMath.isPositiveInfinity(Double.infinity))
    }

    @Test func vectors() {
        let v2f = Vec2f(1, 2)
        let v2d = Vec2d(1, 2)
        let v3f = Vec3f(1, 2, 3)
        let v3d = Vec3d(1, 2, 3)
        let v4f = Vec4f(1, 2, 3, 4)
        let v4d = Vec4d(1, 2, 3, 4)

        #expect(length(v2f) == FirebladeMath.length(v2f))
        #expect(length(v2d) == FirebladeMath.length(v2d))
        #expect(length(v3f) == FirebladeMath.length(v3f))
        #expect(length(v3d) == FirebladeMath.length(v3d))
        #expect(length(v4f) == FirebladeMath.length(v4f))
        #expect(length(v4d) == FirebladeMath.length(v4d))

        #expect(isClose(normalize(v2f), FirebladeMath.normalize(v2f)))
        #expect(isClose(normalize(v2d), FirebladeMath.normalize(v2d)))
        #expect(isClose(normalize(v3f), FirebladeMath.normalize(v3f)))
        #expect(isClose(normalize(v3d), FirebladeMath.normalize(v3d)))
        #expect(isClose(normalize(v4f), FirebladeMath.normalize(v4f)))
        #expect(isClose(normalize(v4d), FirebladeMath.normalize(v4d)))

        #expect(dot(v2f, v2f) == FirebladeMath.dot(v2f, v2f))
        #expect(dot(v2d, v2d) == FirebladeMath.dot(v2d, v2d))
        #expect(dot(v3f, v3f) == FirebladeMath.dot(v3f, v3f))
        #expect(dot(v3d, v3d) == FirebladeMath.dot(v3d, v3d))
        #expect(dot(v4f, v4f) == FirebladeMath.dot(v4f, v4f))
        #expect(dot(v4d, v4d) == FirebladeMath.dot(v4d, v4d))

        #expect(cross(v2f, Vec2f(2, 1)) == FirebladeMath.cross(v2f, Vec2f(2, 1)))
        #expect(cross(v2d, Vec2d(2, 1)) == FirebladeMath.cross(v2d, Vec2d(2, 1)))
        #expect(cross(v3f, Vec3f(3, 1, 2)) == FirebladeMath.cross(v3f, Vec3f(3, 1, 2)))
        #expect(cross(v3d, Vec3d(3, 1, 2)) == FirebladeMath.cross(v3d, Vec3d(3, 1, 2)))

        #expect(rotate(v3f, Vec3f(0, 0, 1), f) == FirebladeMath.rotate(v3f, Vec3f(0, 0, 1), f))
        #expect(rotate(v4f, Vec3f(0, 0, 1), f) == FirebladeMath.rotate(v4f, Vec3f(0, 0, 1), f))
    }

    @Test func quaternions() {
        let axisF = normalize(Vec3f(1, 2, 3))
        let axisD = normalize(Vec3d(1, 2, 3))
        let qf = quaternion(angle: f, axis: axisF)
        let qd = quaternion(angle: d, axis: axisD)

        #expect(qf == FirebladeMath.quaternion(angle: f, axis: axisF))
        #expect(qd == FirebladeMath.quaternion(angle: d, axis: axisD))
        #expect(quaternion(from: axisF, to: Vec3f(0, 1, 0)) == FirebladeMath.quaternion(from: axisF, to: Vec3f(0, 1, 0)))
        #expect(quaternion(from: axisD, to: Vec3d(0, 1, 0)) == FirebladeMath.quaternion(from: axisD, to: Vec3d(0, 1, 0)))

        #expect(angle(qf) == FirebladeMath.angle(qf))
        #expect(angle(qd) == FirebladeMath.angle(qd))
        #expect(axis(qf) == FirebladeMath.axis(qf))
        #expect(axis(qd) == FirebladeMath.axis(qd))
        #expect(length(qf) == FirebladeMath.length(qf))
        #expect(length(qd) == FirebladeMath.length(qd))
        #expect(normalize(qf) == FirebladeMath.normalize(qf))
        #expect(normalize(qd) == FirebladeMath.normalize(qd))
        #expect(conjugate(qf) == FirebladeMath.conjugate(qf))
        #expect(conjugate(qd) == FirebladeMath.conjugate(qd))
        #expect(inverse(qf) == FirebladeMath.inverse(qf))
        #expect(inverse(qd) == FirebladeMath.inverse(qd))
        #expect(act(qf, axisF) == FirebladeMath.act(qf, axisF))
        #expect(act(qd, axisD) == FirebladeMath.act(qd, axisD))
        #expect(multiply(qf, qf) == FirebladeMath.multiply(qf, qf))
        #expect(multiply(qd, qd) == FirebladeMath.multiply(qd, qd))
        #expect(multiply(f, qf) == FirebladeMath.multiply(f, qf))
        #expect(multiply(qd, d) == FirebladeMath.multiply(qd, d))
        #expect(add(qf, qf) == FirebladeMath.add(qf, qf))
        #expect(add(qd, qd) == FirebladeMath.add(qd, qd))
        #expect(subtract(qf, qf) == FirebladeMath.subtract(qf, qf))
        #expect(subtract(qd, qd) == FirebladeMath.subtract(qd, qd))

        #expect(quaternionToEulerAngles_123(qf) == FirebladeMath.quaternionToEulerAngles_123(qf))
        #expect(quaternionToEulerAngles_321(qf) == FirebladeMath.quaternionToEulerAngles_321(qf))
    }

    @Test func matrices() {
        let qf = quaternion(angle: f, axis: Vec3f(0, 0, 1))
        let qd = quaternion(angle: d, axis: Vec3d(0, 0, 1))
        let m3f = matrix3x3(from: qf)
        let m3d = matrix3x3(from: qd)
        let m4f = matrix4x4(from: qf)
        let m4d = matrix4x4(from: qd)

        #expect(m3f == FirebladeMath.matrix3x3(from: qf))
        #expect(m4d == FirebladeMath.matrix4x4(from: qd))

        #expect(transpose(m3f) == FirebladeMath.transpose(m3f))
        #expect(transpose(m3d) == FirebladeMath.transpose(m3d))
        #expect(transpose(m4f) == FirebladeMath.transpose(m4f))
        #expect(transpose(m4d) == FirebladeMath.transpose(m4d))

        #expect(determinant(m3f) == FirebladeMath.determinant(m3f))
        #expect(determinant(m3d) == FirebladeMath.determinant(m3d))
        #expect(determinant(m4f) == FirebladeMath.determinant(m4f))
        #expect(determinant(m4d) == FirebladeMath.determinant(m4d))

        #expect(inverse(m3f) == FirebladeMath.inverse(m3f))
        #expect(inverse(m3d) == FirebladeMath.inverse(m3d))
        #expect(inverse(m4f) == FirebladeMath.inverse(m4f))
        #expect(inverse(m4d) == FirebladeMath.inverse(m4d))

        #expect(adjugate(m3f) == FirebladeMath.adjugate(m3f))
        #expect(adjugate(m3d) == FirebladeMath.adjugate(m3d))
        #expect(adjugate(m4f) == FirebladeMath.adjugate(m4f))
        #expect(adjugate(m4d) == FirebladeMath.adjugate(m4d))

        #expect(quaternion(matrix: m3f) == FirebladeMath.quaternion(matrix: m3f))
        #expect(quaternion(matrix: m3d) == FirebladeMath.quaternion(matrix: m3d))
        #expect(quaternion(matrix: m4f) == FirebladeMath.quaternion(matrix: m4f))
        #expect(quaternion(matrix: m4d) == FirebladeMath.quaternion(matrix: m4d))

        #expect(multiply(m4f, m4f) == FirebladeMath.multiply(m4f, m4f))
        #expect(multiply(m4d, m4d) == FirebladeMath.multiply(m4d, m4d))
        #expect(multiply(m3f, m3f) == FirebladeMath.multiply(m3f, m3f))
        #expect(multiply(m3d, m3d) == FirebladeMath.multiply(m3d, m3d))
        #expect(multiply(m4f, Vec4f(1, 2, 3, 4)) == FirebladeMath.multiply(m4f, Vec4f(1, 2, 3, 4)))
        #expect(multiply(Vec3d(1, 2, 3), m3d) == FirebladeMath.multiply(Vec3d(1, 2, 3), m3d))
        #expect(multiply(Float(2), m4f) == FirebladeMath.multiply(Float(2), m4f))
        #expect(multiply(Mat2x2f.identity, Mat2x2f.identity) == FirebladeMath.multiply(Mat2x2f.identity, Mat2x2f.identity))
    }
}

// When the `simd` trait is disabled on an Apple platform, a consumer that imports `simd`
// resolves `rsqrt`/`normalize` to simd's implementation, which may differ from the
// portable fallback in the last ulp. Everywhere else both sides are bit-identical.
private func isClose<T: BinaryFloatingPoint>(_ lhs: T, _ rhs: T) -> Bool {
    Swift.abs(lhs - rhs) <= lhs.ulp * 4
}

private func isClose<V: SIMD>(_ lhs: V, _ rhs: V) -> Bool where V.Scalar: BinaryFloatingPoint {
    lhs.indices.allSatisfy { isClose(lhs[$0], rhs[$0]) }
}
