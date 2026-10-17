//
//  PortableVsSIMDScalarTests.swift
//  FirebladeMathTests
//

// Differential tests for scalar functions against Apple's simd, including NaN, infinities
// and signed zeros. See PortableVsSIMDSupport.swift.

#if canImport(simd) && !FRB_MATH_USE_SIMD
import FirebladeMath
import simd
import Testing

struct PortableVsSIMDScalarTests {
    static let values = DifferentialInputs.scalars(seed: 0x4001) + DifferentialInputs.specialScalars


    // MARK: - Float

    // covers: clamp(Float, Float, Float)
    @Test func clampF() {
        let values = Self.values
        for (index, value) in values.enumerated() {
            let a = values[(index + 7) % values.count], b = values[(index + 13) % values.count]
            guard a.isFinite, b.isFinite else { continue }
            let x = Float(value), low = Float(Swift.min(a, b)), high = Float(Swift.max(a, b))
            #expect(differentialMatch(Double(FirebladeMath.clamp(x, low, high)), Double(simd_clamp(x, low, high)), tolerance: 0, signedZero: true), "input \(index): clamp(\(x), \(low), \(high))")
        }
    }

    // covers: fract(Float)
    // covers: sign(Float)
    @Test func fractAndSignF() {
        for (index, value) in Self.values.enumerated() {
            let x = Float(value)
            #expect(differentialMatch(Double(FirebladeMath.fract(x)), Double(simd_fract(x)), tolerance: Tolerance.float, signedZero: true), "input \(index): fract(\(x))")
            #expect(differentialMatch(Double(FirebladeMath.sign(x)), Double(simd_sign(x)), tolerance: 0, signedZero: true), "input \(index): sign(\(x))")
        }
    }

    // covers: mix(Float, Float, Float)
    @Test func mixF() {
        let values = Self.values
        var generator = SplitMix(seed: 0x4002)
        for (index, value) in values.enumerated() {
            let a = Float(value), b = Float(values[(index + 5) % values.count])
            let t = Float(generator.next(in: -0.5...1.5))
            let scale = Double(Swift.max(Swift.abs(a), Swift.abs(b)))
            #expect(differentialMatch(Double(FirebladeMath.mix(a, b, t)), Double(simd_mix(a, b, t)), tolerance: Tolerance.float, scale: scale), "input \(index): mix(\(a), \(b), \(t))")
        }
    }

    // covers: rsqrt(Float)
    @Test func rsqrtF() {
        for (index, value) in Self.values.enumerated() where value >= 0 || value.isNaN {
            let x = Float(value)
            #expect(differentialMatch(Double(FirebladeMath.rsqrt(x)), Double(simd_rsqrt(x)), tolerance: Tolerance.float), "input \(index): rsqrt(\(x))")
        }
    }

    // covers: smoothstep(Float, Float, Float)
    @Test func smoothstepF() {
        let values = Self.values
        var generator = SplitMix(seed: 0x4003)
        for (index, value) in values.enumerated() where value.isFinite {
            let edge0 = Float(generator.next(in: -10...0)), edge1 = Float(generator.next(in: 0.5...10))
            let x = Float(value)
            #expect(differentialMatch(Double(FirebladeMath.smoothstep(edge0, edge1, x)), Double(simd_smoothstep(edge0, edge1, x)), tolerance: Tolerance.float), "input \(index): smoothstep(\(edge0), \(edge1), \(x))")
        }
    }

    // covers: step(Float, Float)
    @Test func stepF() {
        let values = Self.values
        for (index, value) in values.enumerated() {
            let x = Float(value)
            for edge in [Float(values[(index + 3) % values.count]), x] {
                #expect(differentialMatch(Double(FirebladeMath.step(x, edge)), Double(simd.step(x, edge: edge)), tolerance: 0, signedZero: true), "input \(index): step(\(x), \(edge))")
            }
        }
    }

    // MARK: - Double

    // covers: clamp(Double, Double, Double)
    @Test func clampD() {
        let values = Self.values
        for (index, value) in values.enumerated() {
            let a = values[(index + 7) % values.count], b = values[(index + 13) % values.count]
            guard a.isFinite, b.isFinite else { continue }
            let x = Double(value), low = Double(Swift.min(a, b)), high = Double(Swift.max(a, b))
            #expect(differentialMatch(Double(FirebladeMath.clamp(x, low, high)), Double(simd_clamp(x, low, high)), tolerance: 0, signedZero: true), "input \(index): clamp(\(x), \(low), \(high))")
        }
    }

    // covers: fract(Double)
    // covers: sign(Double)
    @Test func fractAndSignD() {
        for (index, value) in Self.values.enumerated() {
            let x = Double(value)
            #expect(differentialMatch(Double(FirebladeMath.fract(x)), Double(simd_fract(x)), tolerance: Tolerance.double, signedZero: true), "input \(index): fract(\(x))")
            #expect(differentialMatch(Double(FirebladeMath.sign(x)), Double(simd_sign(x)), tolerance: 0, signedZero: true), "input \(index): sign(\(x))")
        }
    }

    // covers: mix(Double, Double, Double)
    @Test func mixD() {
        let values = Self.values
        var generator = SplitMix(seed: 0x4002)
        for (index, value) in values.enumerated() {
            let a = Double(value), b = Double(values[(index + 5) % values.count])
            let t = Double(generator.next(in: -0.5...1.5))
            let scale = Double(Swift.max(Swift.abs(a), Swift.abs(b)))
            #expect(differentialMatch(Double(FirebladeMath.mix(a, b, t)), Double(simd_mix(a, b, t)), tolerance: Tolerance.double, scale: scale), "input \(index): mix(\(a), \(b), \(t))")
        }
    }

    // covers: rsqrt(Double)
    @Test func rsqrtD() {
        for (index, value) in Self.values.enumerated() where value >= 0 || value.isNaN {
            let x = Double(value)
            #expect(differentialMatch(Double(FirebladeMath.rsqrt(x)), Double(simd_rsqrt(x)), tolerance: Tolerance.double), "input \(index): rsqrt(\(x))")
        }
    }

    // covers: smoothstep(Double, Double, Double)
    @Test func smoothstepD() {
        let values = Self.values
        var generator = SplitMix(seed: 0x4003)
        for (index, value) in values.enumerated() where value.isFinite {
            let edge0 = Double(generator.next(in: -10...0)), edge1 = Double(generator.next(in: 0.5...10))
            let x = Double(value)
            #expect(differentialMatch(Double(FirebladeMath.smoothstep(edge0, edge1, x)), Double(simd_smoothstep(edge0, edge1, x)), tolerance: Tolerance.double), "input \(index): smoothstep(\(edge0), \(edge1), \(x))")
        }
    }

    // covers: step(Double, Double)
    @Test func stepD() {
        let values = Self.values
        for (index, value) in values.enumerated() {
            let x = Double(value)
            for edge in [Double(values[(index + 3) % values.count]), x] {
                #expect(differentialMatch(Double(FirebladeMath.step(x, edge)), Double(simd.step(x, edge: edge)), tolerance: 0, signedZero: true), "input \(index): step(\(x), \(edge))")
            }
        }
    }
}
#endif
