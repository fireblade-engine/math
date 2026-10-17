//
//  PortableVsSIMDVectorTests.swift
//  FirebladeMathTests
//

// Differential tests for vector functions against Apple's simd. See PortableVsSIMDSupport.swift.

#if canImport(simd) && !FRB_MATH_USE_SIMD
import FirebladeMath
import simd
import Testing

struct PortableVsSIMDVectorTests {

    // covers: dot(SIMD2<Float>, SIMD2<Float>)
    // covers: length(SIMD2<Float>)
    // covers: normalize(SIMD2<Float>)
    // covers: cross(SIMD2<Float>, SIMD2<Float>)
    @Test func vector2f() {
        let inputs = DifferentialInputs.vectors(dimension: 2, seed: 0x3021)
        for (index, values) in inputs.enumerated() {
            let lhs = SIMD2<Float>(values.floats), rhs = SIMD2<Float>(inputs[(index + 1) % inputs.count].floats)
            #expect(differentialMatch(Double(FirebladeMath.dot(lhs, rhs)), Double(simd_dot(lhs, rhs)), tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(Double(FirebladeMath.length(lhs)), Double(simd_length(lhs)), tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(FirebladeMath.normalize(lhs).lanes, simd_normalize(lhs).lanes, tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(FirebladeMath.cross(lhs, rhs).lanes, simd_cross(lhs, rhs).lanes, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: dot(SIMD3<Float>, SIMD3<Float>)
    // covers: length(SIMD3<Float>)
    // covers: normalize(SIMD3<Float>)
    // covers: cross(SIMD3<Float>, SIMD3<Float>)
    @Test func vector3f() {
        let inputs = DifferentialInputs.vectors(dimension: 3, seed: 0x3031)
        for (index, values) in inputs.enumerated() {
            let lhs = SIMD3<Float>(values.floats), rhs = SIMD3<Float>(inputs[(index + 1) % inputs.count].floats)
            #expect(differentialMatch(Double(FirebladeMath.dot(lhs, rhs)), Double(simd_dot(lhs, rhs)), tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(Double(FirebladeMath.length(lhs)), Double(simd_length(lhs)), tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(FirebladeMath.normalize(lhs).lanes, simd_normalize(lhs).lanes, tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(FirebladeMath.cross(lhs, rhs).lanes, simd_cross(lhs, rhs).lanes, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: dot(SIMD4<Float>, SIMD4<Float>)
    // covers: length(SIMD4<Float>)
    // covers: normalize(SIMD4<Float>)
    @Test func vector4f() {
        let inputs = DifferentialInputs.vectors(dimension: 4, seed: 0x3041)
        for (index, values) in inputs.enumerated() {
            let lhs = SIMD4<Float>(values.floats), rhs = SIMD4<Float>(inputs[(index + 1) % inputs.count].floats)
            #expect(differentialMatch(Double(FirebladeMath.dot(lhs, rhs)), Double(simd_dot(lhs, rhs)), tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(Double(FirebladeMath.length(lhs)), Double(simd_length(lhs)), tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(FirebladeMath.normalize(lhs).lanes, simd_normalize(lhs).lanes, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: dot(SIMD2<Double>, SIMD2<Double>)
    // covers: length(SIMD2<Double>)
    // covers: normalize(SIMD2<Double>)
    // covers: cross(SIMD2<Double>, SIMD2<Double>)
    @Test func vector2d() {
        let inputs = DifferentialInputs.vectors(dimension: 2, seed: 0x3022)
        for (index, values) in inputs.enumerated() {
            let lhs = SIMD2<Double>(values), rhs = SIMD2<Double>(inputs[(index + 1) % inputs.count])
            #expect(differentialMatch(Double(FirebladeMath.dot(lhs, rhs)), Double(simd_dot(lhs, rhs)), tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(Double(FirebladeMath.length(lhs)), Double(simd_length(lhs)), tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(FirebladeMath.normalize(lhs).lanes, simd_normalize(lhs).lanes, tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(FirebladeMath.cross(lhs, rhs).lanes, simd_cross(lhs, rhs).lanes, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // covers: dot(SIMD3<Double>, SIMD3<Double>)
    // covers: length(SIMD3<Double>)
    // covers: normalize(SIMD3<Double>)
    // covers: cross(SIMD3<Double>, SIMD3<Double>)
    @Test func vector3d() {
        let inputs = DifferentialInputs.vectors(dimension: 3, seed: 0x3032)
        for (index, values) in inputs.enumerated() {
            let lhs = SIMD3<Double>(values), rhs = SIMD3<Double>(inputs[(index + 1) % inputs.count])
            #expect(differentialMatch(Double(FirebladeMath.dot(lhs, rhs)), Double(simd_dot(lhs, rhs)), tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(Double(FirebladeMath.length(lhs)), Double(simd_length(lhs)), tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(FirebladeMath.normalize(lhs).lanes, simd_normalize(lhs).lanes, tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(FirebladeMath.cross(lhs, rhs).lanes, simd_cross(lhs, rhs).lanes, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // covers: dot(SIMD4<Double>, SIMD4<Double>)
    // covers: length(SIMD4<Double>)
    // covers: normalize(SIMD4<Double>)
    @Test func vector4d() {
        let inputs = DifferentialInputs.vectors(dimension: 4, seed: 0x3042)
        for (index, values) in inputs.enumerated() {
            let lhs = SIMD4<Double>(values), rhs = SIMD4<Double>(inputs[(index + 1) % inputs.count])
            #expect(differentialMatch(Double(FirebladeMath.dot(lhs, rhs)), Double(simd_dot(lhs, rhs)), tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(Double(FirebladeMath.length(lhs)), Double(simd_length(lhs)), tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(FirebladeMath.normalize(lhs).lanes, simd_normalize(lhs).lanes, tolerance: Tolerance.double), "input \(index)")
        }
    }
}
#endif
