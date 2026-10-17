//
//  PortableVsSIMDQuaternionTests.swift
//  FirebladeMathTests
//

// Differential tests for quaternion arithmetic and queries against Apple's simd.
// See PortableVsSIMDSupport.swift.

#if canImport(simd) && !FRB_MATH_USE_SIMD
import FirebladeMath
import simd
import Testing

struct PortableVsSIMDQuaternionTests {
    /// Random quaternions, the basis, and the zero quaternion as an edge case.
    static let quaternions = DifferentialInputs.quaternions(seed: 0x2001) + [[0, 0, 0, 0]]


    // MARK: - Quat4f

    // covers: multiply(Float, Quat4f)
    // covers: multiply(Quat4f, Float)
    // covers: add(Quat4f, Quat4f)
    // covers: subtract(Quat4f, Quat4f)
    @Test func arithmeticF() {
        let inputs = Self.quaternions
        let scalars = DifferentialInputs.scalars(seed: 0x2002)
        for (index, values) in inputs.enumerated() {
            let lhs = SIMD4<Float>(values.floats), rhs = SIMD4<Float>(inputs[(index + 1) % inputs.count].floats)
            let scalar = Float(scalars[index % scalars.count])
            let left = simd_quatf(vector: lhs), right = simd_quatf(vector: rhs)
            #expect(differentialMatch(FirebladeMath.multiply(scalar, Quat4f(lhs)).elements, simd_mul(scalar, left).vector.lanes, tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(FirebladeMath.multiply(Quat4f(lhs), scalar).elements, simd_mul(left, scalar).vector.lanes, tolerance: Tolerance.float), "input \(index)")
            #expect(FirebladeMath.add(Quat4f(lhs), Quat4f(rhs)).elements == simd_add(left, right).vector.lanes, "input \(index)")
            #expect(FirebladeMath.subtract(Quat4f(lhs), Quat4f(rhs)).elements == simd_sub(left, right).vector.lanes, "input \(index)")
        }
    }

    // covers: conjugate(Quat4f)
    // covers: inverse(Quat4f)
    // covers: length(Quat4f)
    // covers: normalize(Quat4f)
    @Test func queriesF() {
        for (index, values) in Self.quaternions.enumerated() {
            let vector = SIMD4<Float>(values.floats)
            let reference = simd_quatf(vector: vector)
            #expect(FirebladeMath.conjugate(Quat4f(vector)).elements == simd_conjugate(reference).vector.lanes, "input \(index)")
            #expect(differentialMatch(FirebladeMath.inverse(Quat4f(vector)).elements, simd_inverse(reference).vector.lanes, tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(Double(FirebladeMath.length(Quat4f(vector))), Double(simd_length(reference)), tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(FirebladeMath.normalize(Quat4f(vector)).elements, simd_normalize(reference).vector.lanes, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: angle(Quat4f)
    // covers: axis(Quat4f)
    @Test func angleAndAxisF() {
        for (index, values) in Self.quaternions.enumerated() {
            let vector = SIMD4<Float>(values.floats)
            let reference = simd_quatf(vector: vector)
            #expect(differentialMatch(Double(FirebladeMath.angle(Quat4f(vector))), Double(simd_angle(reference)), tolerance: Tolerance.floatLoose), "input \(index)")
            #expect(differentialMatch(FirebladeMath.axis(Quat4f(vector)).lanes, simd_axis(reference).lanes, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: act(Quat4f, Vec3f)
    @Test func actF() {
        let vectors = DifferentialInputs.vectors(dimension: 3, seed: 0x2003)
        for (index, values) in Self.quaternions.enumerated() {
            let quaternion = SIMD4<Float>(values.floats)
            let vector = Vec3f(vectors[index % vectors.count].floats)
            let portable = FirebladeMath.act(Quat4f(quaternion), vector)
            let reference = simd_act(simd_normalize(simd_quatf(vector: quaternion)), vector)
            #expect(differentialMatch(portable.lanes, reference.lanes, tolerance: Tolerance.floatLoose), "input \(index)")
        }
    }

    // MARK: - Quat4d

    // covers: multiply(Double, Quat4d)
    // covers: multiply(Quat4d, Double)
    // covers: add(Quat4d, Quat4d)
    // covers: subtract(Quat4d, Quat4d)
    @Test func arithmeticD() {
        let inputs = Self.quaternions
        let scalars = DifferentialInputs.scalars(seed: 0x2002)
        for (index, values) in inputs.enumerated() {
            let lhs = SIMD4<Double>(values), rhs = SIMD4<Double>(inputs[(index + 1) % inputs.count])
            let scalar = Double(scalars[index % scalars.count])
            let left = simd_quatd(vector: lhs), right = simd_quatd(vector: rhs)
            #expect(differentialMatch(FirebladeMath.multiply(scalar, Quat4d(lhs)).elements, simd_mul(scalar, left).vector.lanes, tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(FirebladeMath.multiply(Quat4d(lhs), scalar).elements, simd_mul(left, scalar).vector.lanes, tolerance: Tolerance.double), "input \(index)")
            #expect(FirebladeMath.add(Quat4d(lhs), Quat4d(rhs)).elements == simd_add(left, right).vector.lanes, "input \(index)")
            #expect(FirebladeMath.subtract(Quat4d(lhs), Quat4d(rhs)).elements == simd_sub(left, right).vector.lanes, "input \(index)")
        }
    }

    // covers: conjugate(Quat4d)
    // covers: inverse(Quat4d)
    // covers: length(Quat4d)
    // covers: normalize(Quat4d)
    @Test func queriesD() {
        for (index, values) in Self.quaternions.enumerated() {
            let vector = SIMD4<Double>(values)
            let reference = simd_quatd(vector: vector)
            #expect(FirebladeMath.conjugate(Quat4d(vector)).elements == simd_conjugate(reference).vector.lanes, "input \(index)")
            #expect(differentialMatch(FirebladeMath.inverse(Quat4d(vector)).elements, simd_inverse(reference).vector.lanes, tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(Double(FirebladeMath.length(Quat4d(vector))), Double(simd_length(reference)), tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(FirebladeMath.normalize(Quat4d(vector)).elements, simd_normalize(reference).vector.lanes, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // covers: angle(Quat4d)
    // covers: axis(Quat4d)
    @Test func angleAndAxisD() {
        for (index, values) in Self.quaternions.enumerated() {
            let vector = SIMD4<Double>(values)
            let reference = simd_quatd(vector: vector)
            #expect(differentialMatch(Double(FirebladeMath.angle(Quat4d(vector))), Double(simd_angle(reference)), tolerance: Tolerance.doubleLoose), "input \(index)")
            #expect(differentialMatch(FirebladeMath.axis(Quat4d(vector)).lanes, simd_axis(reference).lanes, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // covers: act(Quat4d, Vec3d)
    @Test func actD() {
        let vectors = DifferentialInputs.vectors(dimension: 3, seed: 0x2003)
        for (index, values) in Self.quaternions.enumerated() {
            let quaternion = SIMD4<Double>(values)
            let vector = Vec3d(vectors[index % vectors.count])
            let portable = FirebladeMath.act(Quat4d(quaternion), vector)
            let reference = simd_act(simd_normalize(simd_quatd(vector: quaternion)), vector)
            #expect(differentialMatch(portable.lanes, reference.lanes, tolerance: Tolerance.doubleLoose), "input \(index)")
        }
    }
}
#endif
