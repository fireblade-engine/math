//
//  FunctionTests.swift
//  FirebladeMathTests
//
//  Created by Christian Treffs on 26.08.19.
//

import FirebladeMath
import Testing

struct FunctionTests {
    @Test func absFunc() {
        #expect(FirebladeMath.abs(Double(-123)) == 123)
        #expect(FirebladeMath.abs(Float(-123)) == 123)
    }
    @Test func acosFunc() {
        #expect(abs(FirebladeMath.acos(Double(0.5)) - 1.0471975511965976) <= 1e-14)
        #expect(abs(FirebladeMath.acos(Float(0.5)) - 1.0471975) <= 1e-6)
    }
    @Test func acoshFunc() {
        #expect(FirebladeMath.acosh(Double(123)) == 5.505315010967267)
        #expect(FirebladeMath.acosh(Float(123)) == 5.505315)
    }
    @Test func asinFunc() {
        #expect(abs(FirebladeMath.asin(Double(0.5)) - 0.5235987755982988) <= 1e-14)
        #expect(FirebladeMath.asin(Float(0.5)) == 0.5235988)
    }
    @Test func asinhFunc() {
        #expect(abs(FirebladeMath.asinh(Double(123)) - 5.505348060078276) <= 1e-14)
        #expect(FirebladeMath.asinh(Float(123)) == 5.505348)
    }
    @Test func atanFunc() {
        #expect(FirebladeMath.atan(Double(123)) == 1.5626664246149526)
        #expect(FirebladeMath.atan(Float(123)) == 1.5626664)
    }
    @Test func atan2Func() {
        #expect(FirebladeMath.atan2(Double(123), Double(123)) == 0.7853981633974483)
        #expect(FirebladeMath.atan2(Float(123), Float(123)) == 0.7853982)
    }
    @Test func atanhFunc() {
        #expect(abs(FirebladeMath.atanh(Double(0.5)) - 0.5493061443340549) <= 1e-14)
        #expect(FirebladeMath.atanh(Float(0.5)) == 0.54930615)
    }
    @Test func ceilFunc() {
        #expect(FirebladeMath.ceil(Double(123.78)) == 124)
        #expect(FirebladeMath.ceil(Float(123.69)) == 124)
    }
    @Test func clampFunc() {
        #expect(FirebladeMath.clamp(Double(123), Double(1), Double(50)) == 50)
        #expect(FirebladeMath.clamp(Float(123), Float(1), Float(50)) == 50)
    }
    @Test func cosFunc() {
        #expect(FirebladeMath.cos(Double(123)) == -0.8879689066918555)
        #expect(FirebladeMath.cos(Float(123)) == -0.8879689)
    }
    @Test func coshFunc() {
        #expect(FirebladeMath.cosh(Double.pi) == 11.591953275521519)
        #expect(abs(FirebladeMath.cosh(Float.pi) - 11.591951) <= 1e-6)
    }
    @Test func degreesFunc() {
        #expect(FirebladeMath.degrees(Double(123)) == 7047.380880109125)
        #expect(FirebladeMath.degrees(Float(123)) == 7047.381)
    }
    @Test func distanceFunc() {
        #expect(FirebladeMath.distance(Double(123), Double(124)) == 1)
        #expect(FirebladeMath.distance(Float(123), Float(122)) == 1)
    }
    @Test func dotFunc() {
        #expect(FirebladeMath.dot(SIMD2<Double>(1, 2), SIMD2<Double>(3, 4)) == 11.0)
        #expect(FirebladeMath.dot(SIMD3<Double>(1, 2, 3), SIMD3<Double>(4, 5, 6)) == 32.0)
        #expect(FirebladeMath.dot(SIMD4<Double>(1, 2, 3, 4), SIMD4<Double>(5, 6, 7, 8)) == 70.0)

        #expect(FirebladeMath.dot(SIMD2<Float>(1, 2), SIMD2<Float>(3, 4)) == 11.0)
        #expect(FirebladeMath.dot(SIMD3<Float>(1, 2, 3), SIMD3<Float>(4, 5, 6)) == 32.0)
        #expect(FirebladeMath.dot(SIMD4<Float>(1, 2, 3, 4), SIMD4<Float>(5, 6, 7, 8)) == 70.0)
    }
    @Test func expFunc() {
        #expect(FirebladeMath.exp(Double(13)) == 442413.3920089205)
        #expect(FirebladeMath.exp(Float(13)) == 442413.4)
    }
    @Test func exp2Func() {
        #expect(FirebladeMath.exp2(Double(9)) == 512.0)
        #expect(FirebladeMath.exp2(Float(9)) == 512.0)
    }
    @Test func faceforwardFunc() {
        #expect(FirebladeMath.faceforward(n: Double(1), i: Double(2), nref: Double(3)) == -1)
        #expect(FirebladeMath.faceforward(n: Float(1), i: Float(2), nref: Float(3)) == -1.0)
    }
    @Test func floorFunc() {
        #expect(FirebladeMath.floor(Double(123.45)) == 123)
        #expect(FirebladeMath.floor(Float(123.32)) == 123)
    }
    @Test func fractFunc() {
        #expect(FirebladeMath.fract(Double(123.34)) == 0.3400000000000034)
        #expect(FirebladeMath.fract(Float(123.56)) == 0.55999756)
    }
    @Test func hypotFunc() {
        #expect(FirebladeMath.hypot(Double(1), Double(2)) == 2.23606797749979)
        #expect(FirebladeMath.hypot(Float(1), Float(2)) == 2.236068)
    }
    @Test func isInfiniteFunc() {
        #expect(FirebladeMath.isInfinite(Double(123)) == false)
        #expect(FirebladeMath.isInfinite(Float(123)) == false)
    }
    @Test func isNegativeInfinityFunc() {
        #expect(FirebladeMath.isNegativeInfinity(Double(123)) == false)
        #expect(FirebladeMath.isNegativeInfinity(Float(123)) == false)
    }
    @Test func isNegativeZeroFunc() {
        #expect(FirebladeMath.isNegativeZero(Double(123)) == false)
        #expect(FirebladeMath.isNegativeZero(Float(123)) == false)
    }
    @Test func isPositiveInfinityFunc() {
        #expect(FirebladeMath.isPositiveInfinity(Double(123)) == false)
        #expect(FirebladeMath.isPositiveInfinity(Float(123)) == false)
    }
    @Test func isPositiveZeroFunc() {
        #expect(FirebladeMath.isPositiveZero(Double(123)) == false)
        #expect(FirebladeMath.isPositiveZero(Float(123)) == false)
    }
    @Test func lengthFunc() {
        #expect(FirebladeMath.length(SIMD2<Double>(1, 2)) == 2.23606797749979)
        #expect(FirebladeMath.length(SIMD3<Double>(1, 2, 3)) == 3.7416573867739413)
        #expect(FirebladeMath.length(SIMD4<Double>(1, 2, 3, 4)) == 5.477225575051661)

        #expect(FirebladeMath.length(SIMD2<Float>(1, 2)) == 2.236068)
        #expect(FirebladeMath.length(SIMD3<Float>(1, 2, 3)) == 3.7416575)
        #expect(FirebladeMath.length(SIMD4<Float>(1, 2, 3, 4)) == 5.477226)
    }
    @Test func logFunc() {
        #expect(FirebladeMath.log(Double(123)) == 4.812184355372417)
        #expect(FirebladeMath.log(Float(123)) == 4.8121843)
    }
    @Test func log2Func() {
        #expect(FirebladeMath.log2(Double(123)) == 6.94251450533924)
        #expect(FirebladeMath.log2(Float(123)) == 6.9425144)
    }
    @Test func log10Func() {
        #expect(FirebladeMath.log10(Double(123)) == 2.089905111439398)
        #expect(FirebladeMath.log10(Float(123)) == 2.089905)
    }
    @Test func maxFunc() {
        #expect(FirebladeMath.max(Double(123), Double(534)) == 534)
        #expect(FirebladeMath.max(Float(123), Float(33)) == 123)
    }
    @Test func minFunc() {
        #expect(FirebladeMath.min(Double(123), Double(22)) == 22)
        #expect(FirebladeMath.min(Float(123), Float(66)) == 66)
    }
    @Test func mixFunc() {
        #expect(FirebladeMath.mix(Double(123), Double(456), Double(18)) == 6117.0)
        #expect(FirebladeMath.mix(Float(123), Float(456), Float(222)) == 74049.0)
    }
    @Test func modFunc() {
        #expect(FirebladeMath.mod(Double(123), Double(2)) == 1.0)
        #expect(FirebladeMath.mod(Float(123), Float(3)) == 0.0)
    }
    @Test func normalizeFunc() {
        #expect(FirebladeMath.normalize(SIMD2<Double>(1, 2)) == SIMD2<Double>(0.4472135954999579, 0.8944271909999159))
        #expect(FirebladeMath.normalize(SIMD3<Double>(1, 2, 3)) == SIMD3<Double>(0.2672612419124244, 0.5345224838248488, 0.8017837257372732))
        #expect(FirebladeMath.normalize(SIMD4<Double>(1, 2, 3, 4)) == SIMD4<Double>(0.18257418583505536, 0.3651483716701107, 0.5477225575051661, 0.7302967433402214))

        expectEqualElements(FirebladeMath.normalize(SIMD2<Float>(1, 2)).elements, [0.4472136, 0.8944272], accuracy: 1e-7)
        expectEqualElements(FirebladeMath.normalize(SIMD3<Float>(1, 2, 3)).elements, [0.26726124, 0.5345225, 0.8017837], accuracy: 1e-7)
        #if FRB_MATH_USE_SIMD
        expectEqualElements(FirebladeMath.normalize(SIMD4<Float>(1, 2, 3, 4)).elements, [0.18257417, 0.36514834, 0.5477225, 0.7302967], accuracy: 1e-7)
        #else
        expectEqualElements(FirebladeMath.normalize(SIMD4<Float>(1, 2, 3, 4)).elements, [0.18257418, 0.36514837, 0.5477226, 0.73029673], accuracy: 1e-7)
        #endif
    }
    @Test func powFunc() {
        #expect(FirebladeMath.pow(Double(123), Double(2)) == 15129.0)
        #expect(FirebladeMath.pow(Float(123), Float(2)) == 15129.0)
    }
    @Test func pow2Func() {
        #expect(FirebladeMath.pow2(Double(123)) == 1.0633823966279327e+37)
        #expect(FirebladeMath.pow2(Float(123)) == 1.0633824e+37)
    }
    @Test func radiansFunc() {
        #expect(FirebladeMath.radians(Double(123)) == 2.1467549799530254)
        #expect(FirebladeMath.radians(Float(123)) == 2.146755)
    }
    @Test func reflectFunc() {
        #expect(FirebladeMath.reflect(Double(123), Double(123)) == -3721611.0)
        #expect(FirebladeMath.reflect(Float(123), Float(123)) == -3721611.0)
    }
    @Test func refractFunc() {
        #expect(FirebladeMath.refract(Double(123), Double(123), Double(123)) == -457758152.500033)
        #expect(FirebladeMath.refract(Float(123), Float(123), Float(123)) == -4.5775814e+08)
    }
    @Test func rsqrtFunc() {
        #expect(FirebladeMath.rsqrt(Double(123)) == 0.09016696346674323)
        #expect(abs(FirebladeMath.rsqrt(Float(123)) - 0.090166956) <= 1e-8)
    }
    @Test func signFunc() {
        #expect(FirebladeMath.sign(Double(123)) == 1.0)
        #expect(FirebladeMath.sign(Float(-123)) == -1.0)
    }
    @Test func sinFunc() {
        #expect(FirebladeMath.sin(Double(123)) == -0.45990349068959124)
        #expect(abs(FirebladeMath.sin(Float(123)) - (-0.45990348)) <= 1e-7)
    }
    @Test func sinhFunc() {
        #expect(FirebladeMath.sinh(Double(0.5)) == 0.5210953054937474)
        #expect(FirebladeMath.sinh(Float(0.5)) == 0.5210953)
    }
    @Test func smoothstepFunc() {
        #expect(FirebladeMath.smoothstep(Double(12), Double(24), Double(13)) == 0.019675925925925927)
        #expect(FirebladeMath.smoothstep(Float(12), Float(24), Float(13)) == 0.019675927)
    }
    @Test func sqrtFunc() {
        #expect(FirebladeMath.sqrt(Double(123)) == 11.090536506409418)
        #expect(FirebladeMath.sqrt(Float(123)) == 11.090536)
    }
    @Test func stepFunc() {
        #expect(FirebladeMath.step(Double(123), Double(123)) == 1.0)
        #expect(FirebladeMath.step(Float(123), Float(123)) == 1.0)
    }
    @Test func tanFunc() {
        #expect(abs(FirebladeMath.tan(Double(123)) - 0.5179274715856551) <= 1e-14)
        #expect(FirebladeMath.tan(Float(123)) == 0.51792747)
    }
    @Test func tanhFunc() {
        #expect(FirebladeMath.tanh(Double(0.5)) == 0.46211715726000974)
        #expect(FirebladeMath.tanh(Float(0.5)) == 0.46211717)
    }
    @Test func remapFunc() {
        #expect(Double(5).remaped(clampingIn: 0...10, to: 0...100) == 50.0)
        #expect(Float(5).remaped(clampingIn: 0...10, to: 0...100) == 50.0)
        
        var v = Double(5)
        v.remap(clampingIn: 0...10, to: 0...100)
        #expect(v == 50.0)
    }
    @Test func rotateFunc() {
        // Rotate (1, 0, 0) by 90 degrees around Z axis -> (0, 1, 0)
        let v = SIMD3<Float>(1, 0, 0)
        let axis = SIMD3<Float>(0, 0, 1)
        let rotated = FirebladeMath.rotate(v, axis, Float.pi / 2)
        expectEqualElements(rotated.elements, [0, 1, 0], accuracy: 1e-6)
    }
    @Test func interpolateFunc() {
        #expect(FirebladeMath.interpolate(Double(0), Double(10), Double(0.5)) == 5.0)
        #expect(FirebladeMath.interpolate(Float(0), Float(10), Float(0.5)) == 5.0)
    }
    @Test func lerpFunc() {
        #expect(FirebladeMath.lerp(Double(0), Double(10), Double(0.5)) == 5.0)
        #expect(FirebladeMath.lerp(Float(0), Float(10), Float(0.5)) == 5.0)
    }
    @Test func lerpPreciseFunc() {
        #expect(FirebladeMath.lerpPrecise(Double(0), Double(10), Double(0.5)) == 5.0)
        #expect(FirebladeMath.lerpPrecise(Float(0), Float(10), Float(0.5)) == 5.0)

        // Precise method, which guarantees v = v1 when t = 1.
        #expect(FirebladeMath.lerpPrecise(Double(0), Double(10), Double(1.0)) == 10.0)
        #expect(FirebladeMath.lerpPrecise(Float(0), Float(10), Float(1.0)) == 10.0)
    }
    @Test func lerpedExtension() {
        #expect(Double(5).lerped(from: 0...10, to: 0...100) == 50.0)
        #expect(Float(5).lerped(from: 0...10, to: 0...100) == 50.0)

        var v = Double(5)
        v.lerp(from: 0...10, to: 0...100)
        #expect(v == 50.0)
    }
    @Test func saturateFunc() {
        #expect(FirebladeMath.saturate(Double(1.5)) == 1.0)
        #expect(FirebladeMath.saturate(Double(-0.5)) == 0.0)
        #expect(FirebladeMath.saturate(Double(0.5)) == 0.5)
        
        #expect(FirebladeMath.saturate(Float(1.5)) == 1.0)
        #expect(FirebladeMath.saturate(Float(-0.5)) == 0.0)
        #expect(FirebladeMath.saturate(Float(0.5)) == 0.5)
    }
    @Test func copysignFunc() {
        #expect(FirebladeMath.copysign(Double(10.0), Double(-1.0)) == -10.0)
        #expect(FirebladeMath.copysign(Double(10.0), Double(1.0)) == 10.0)
        #expect(FirebladeMath.copysign(Double(-10.0), Double(-1.0)) == -10.0)
        
        #expect(FirebladeMath.copysign(Float(10.0), Float(-1.0)) == -10.0)
        #expect(FirebladeMath.copysign(Float(10.0), Float(1.0)) == 10.0)
        #expect(FirebladeMath.copysign(Float(-10.0), Float(-1.0)) == -10.0)
    }
}

private func expectEqualElements<T, S>(_ expression1: @autoclosure () throws -> S,
                                       _ expression2: @autoclosure () throws -> S,
                                       accuracy: T,
                                       _ message: @autoclosure () -> String = "",
                                       sourceLocation: SourceLocation = #_sourceLocation) where T: FloatingPoint, S: Sequence, S.Element == T {
    do {
        let s1 = try expression1()
        let s2 = try expression2()
        for (index, elements) in zip(s1, s2).enumerated() {
            let diff = abs(elements.0 - elements.1)
            let comment = Comment(stringLiteral: "[element:\(index + 1)] \(elements.0) is not equal to \(elements.1) +/- \(accuracy) " + message())
            #expect(diff <= accuracy, comment, sourceLocation: sourceLocation)
        }
    } catch {
        Issue.record(error, Comment(stringLiteral: "Error thrown during element comparison"), sourceLocation: sourceLocation)
    }
}