//
//  LibCResolutionTests.swift
//  FirebladeMathTests
//

// Checks that the libc functions resolved through FirebladeMathLibC behave as
// expected on every platform. Where the Swift standard library offers a pure-Swift
// equivalent, it is used as the reference so the check is independent of libc.

import FirebladeMath
import Testing

struct LibCResolutionTests {
    static let floats: [Float] = [-2.5, -1, -0.5, -0.0, 0, 0.25, 1, 1.5, 3.75, 1e6]
    static let doubles: [Double] = [-2.5, -1, -0.5, -0.0, 0, 0.25, 1, 1.5, 3.75, 1e12]

    @Test(arguments: floats)
    func floatMatchesStandardLibrary(_ x: Float) {
        #expect(FirebladeMath.sqrt(Swift.abs(x)) == Swift.abs(x).squareRoot())
        #expect(FirebladeMath.floor(x) == x.rounded(.down))
        #expect(FirebladeMath.ceil(x) == x.rounded(.up))
        #expect(FirebladeMath.mod(x, 0.75) == x.truncatingRemainder(dividingBy: 0.75))
        #expect(FirebladeMath.copysign(Float(2), x) == Float(signOf: x, magnitudeOf: 2))
        #expect(FirebladeMath.distance(x, 1) == Swift.abs(x - 1))
    }

    @Test(arguments: doubles)
    func doubleMatchesStandardLibrary(_ x: Double) {
        #expect(FirebladeMath.sqrt(Swift.abs(x)) == Swift.abs(x).squareRoot())
        #expect(FirebladeMath.floor(x) == x.rounded(.down))
        #expect(FirebladeMath.ceil(x) == x.rounded(.up))
        #expect(FirebladeMath.mod(x, 0.75) == x.truncatingRemainder(dividingBy: 0.75))
        #expect(FirebladeMath.copysign(Double(2), x) == Double(signOf: x, magnitudeOf: 2))
        #expect(FirebladeMath.distance(x, 1) == Swift.abs(x - 1))
    }

    @Test func transcendentalIdentities() {
        let fx: Float = 0.7
        let dx: Double = 0.7

        #expect(Swift.abs(FirebladeMath.sin(fx) * FirebladeMath.sin(fx) + FirebladeMath.cos(fx) * FirebladeMath.cos(fx) - 1) <= 1e-6)
        #expect(Swift.abs(FirebladeMath.sin(dx) * FirebladeMath.sin(dx) + FirebladeMath.cos(dx) * FirebladeMath.cos(dx) - 1) <= 1e-15)
        #expect(Swift.abs(FirebladeMath.tan(fx) - FirebladeMath.sin(fx) / FirebladeMath.cos(fx)) <= 1e-6)
        #expect(Swift.abs(FirebladeMath.tan(dx) - FirebladeMath.sin(dx) / FirebladeMath.cos(dx)) <= 1e-15)
        #expect(Swift.abs(FirebladeMath.asin(FirebladeMath.sin(fx)) - fx) <= 1e-6)
        #expect(Swift.abs(FirebladeMath.acos(FirebladeMath.cos(dx)) - dx) <= 1e-15)
        #expect(Swift.abs(FirebladeMath.atan(FirebladeMath.tan(fx)) - fx) <= 1e-6)
        #expect(Swift.abs(FirebladeMath.atan2(dx, 1) - FirebladeMath.atan(dx)) <= 1e-15)

        #expect(Swift.abs(FirebladeMath.log(FirebladeMath.exp(fx)) - fx) <= 1e-6)
        #expect(Swift.abs(FirebladeMath.log(FirebladeMath.exp(dx)) - dx) <= 1e-15)
        #expect(Swift.abs(FirebladeMath.log2(FirebladeMath.exp2(fx)) - fx) <= 1e-6)
        #expect(Swift.abs(FirebladeMath.log2(FirebladeMath.exp2(dx)) - dx) <= 1e-15)
        #expect(FirebladeMath.log10(Float(1000)) == 3)
        #expect(FirebladeMath.log10(Double(1000)) == 3)
        #expect(FirebladeMath.pow(Float(2), 10) == 1024)
        #expect(FirebladeMath.pow(Double(2), 10) == 1024)
        #expect(FirebladeMath.pow2(Float(10)) == 1024)
        #expect(FirebladeMath.pow2(Double(10)) == 1024)
        #expect(FirebladeMath.hypot(Float(3), 4) == 5)
        #expect(FirebladeMath.hypot(Double(3), 4) == 5)

        #expect(Swift.abs(FirebladeMath.cosh(fx) * FirebladeMath.cosh(fx) - FirebladeMath.sinh(fx) * FirebladeMath.sinh(fx) - 1) <= 1e-5)
        #expect(Swift.abs(FirebladeMath.cosh(dx) * FirebladeMath.cosh(dx) - FirebladeMath.sinh(dx) * FirebladeMath.sinh(dx) - 1) <= 1e-14)
        #expect(Swift.abs(FirebladeMath.asinh(FirebladeMath.sinh(fx)) - fx) <= 1e-6)
        #expect(Swift.abs(FirebladeMath.acosh(FirebladeMath.cosh(dx)) - dx) <= 1e-14)
        #expect(Swift.abs(FirebladeMath.atanh(FirebladeMath.tanh(fx)) - fx) <= 1e-6)
        #expect(Swift.abs(FirebladeMath.atanh(FirebladeMath.tanh(dx)) - dx) <= 1e-14)
    }
}
