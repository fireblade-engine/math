//
//  PortableVsSIMDConversionTests.swift
//  FirebladeMathTests
//

// Differential tests for quaternion <-> matrix conversions and quaternion construction
// against Apple's simd. See PortableVsSIMDSupport.swift.

#if canImport(simd) && !FRB_MATH_USE_SIMD
import FirebladeMath
import simd
import Testing

struct PortableVsSIMDConversionTests {
    static let rotations = DifferentialInputs.rotations(seed: 0x5001)


    // MARK: - Float

    // covers: matrix3x3(from: Quat4f)
    // covers: matrix4x4(from: Quat4f)
    @Test func matrixFromQuaternionF() {
        // Includes non-unit quaternions: both sides must agree on how they are treated.
        for (index, values) in (Self.rotations + DifferentialInputs.quaternions(seed: 0x5002)).enumerated() {
            let vector = SIMD4<Float>(values.floats)
            let reference = simd_quatf(vector: vector)
            #expect(differentialMatch(FirebladeMath.matrix3x3(from: Quat4f(vector)).elements, simd_matrix3x3(reference).elements, tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(FirebladeMath.matrix4x4(from: Quat4f(vector)).elements, simd_matrix4x4(reference).elements, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: quaternion(matrix: Mat3x3f)
    // covers: quaternion(matrix: Mat4x4f)
    @Test func quaternionFromMatrixF() {
        for (index, values) in Self.rotations.enumerated() {
            let rotation = simd_quatf(vector: SIMD4<Float>(values.floats))
            let matrix3 = simd_matrix3x3(rotation), matrix4 = simd_matrix4x4(rotation)
            let portable3 = FirebladeMath.quaternion(matrix: Mat3x3f(matrix3.elements))
            let portable4 = FirebladeMath.quaternion(matrix: Mat4x4f(matrix4.elements))
            #expect(differentialMatch(portable3.elements, simd_quaternion(matrix3).vector.lanes, tolerance: Tolerance.floatLoose), "input \(index)")
            #expect(differentialMatch(portable4.elements, simd_quaternion(matrix4).vector.lanes, tolerance: Tolerance.floatLoose), "input \(index)")
        }
    }

    // covers: quaternion(angle: Float, axis: SIMD3<Float>)
    @Test func quaternionFromAngleAxisF() {
        let axes = DifferentialInputs.vectors(dimension: 3, seed: 0x5003)
        let angles = DifferentialInputs.scalars(seed: 0x5004)
        for (index, values) in axes.enumerated() {
            let axis = SIMD3<Float>(values.floats)
            let angle = Float(angles[index % angles.count])
            let portable = FirebladeMath.quaternion(angle: angle, axis: axis)
            let reference = simd_quaternion(angle, axis)
            #expect(differentialMatch(portable.elements, reference.vector.lanes, tolerance: Tolerance.floatLoose), "input \(index): angle \(angle), axis \(axis)")
        }
    }

    // covers: quaternion(from: SIMD3<Float>, to: SIMD3<Float>)
    @Test func quaternionFromToF() {
        // simd_quaternion(from:to:) expects unit vectors.
        let directions = DifferentialInputs.vectors(dimension: 3, seed: 0x5005)
            .filter { $0.contains { $0 != 0 } }
            .map { simd_normalize(SIMD3<Double>($0)) }
        for (index, from) in directions.enumerated() {
            for to in [directions[(index + 1) % directions.count], from, -from] {
                let fromVector = SIMD3<Float>(Float(from.x), Float(from.y), Float(from.z))
                let toVector = SIMD3<Float>(Float(to.x), Float(to.y), Float(to.z))
                let portable = FirebladeMath.quaternion(from: fromVector, to: toVector)
                let reference = simd_quaternion(fromVector, toVector)
                #expect(differentialMatch(portable.elements, reference.vector.lanes, tolerance: Tolerance.floatLoose), "input \(index): from \(fromVector) to \(toVector)")
            }
        }
    }

    // MARK: - Double

    // covers: matrix3x3(from: Quat4d)
    // covers: matrix4x4(from: Quat4d)
    @Test func matrixFromQuaternionD() {
        // Includes non-unit quaternions: both sides must agree on how they are treated.
        for (index, values) in (Self.rotations + DifferentialInputs.quaternions(seed: 0x5002)).enumerated() {
            let vector = SIMD4<Double>(values)
            let reference = simd_quatd(vector: vector)
            #expect(differentialMatch(FirebladeMath.matrix3x3(from: Quat4d(vector)).elements, simd_matrix3x3(reference).elements, tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(FirebladeMath.matrix4x4(from: Quat4d(vector)).elements, simd_matrix4x4(reference).elements, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // covers: quaternion(matrix: Mat3x3d)
    // covers: quaternion(matrix: Mat4x4d)
    @Test func quaternionFromMatrixD() {
        for (index, values) in Self.rotations.enumerated() {
            let rotation = simd_quatd(vector: SIMD4<Double>(values))
            let matrix3 = simd_matrix3x3(rotation), matrix4 = simd_matrix4x4(rotation)
            let portable3 = FirebladeMath.quaternion(matrix: Mat3x3d(matrix3.elements))
            let portable4 = FirebladeMath.quaternion(matrix: Mat4x4d(matrix4.elements))
            #expect(differentialMatch(portable3.elements, simd_quaternion(matrix3).vector.lanes, tolerance: Tolerance.doubleLoose), "input \(index)")
            #expect(differentialMatch(portable4.elements, simd_quaternion(matrix4).vector.lanes, tolerance: Tolerance.doubleLoose), "input \(index)")
        }
    }

    // covers: quaternion(angle: Double, axis: SIMD3<Double>)
    @Test func quaternionFromAngleAxisD() {
        let axes = DifferentialInputs.vectors(dimension: 3, seed: 0x5003)
        let angles = DifferentialInputs.scalars(seed: 0x5004)
        for (index, values) in axes.enumerated() {
            let axis = SIMD3<Double>(values)
            let angle = Double(angles[index % angles.count])
            let portable = FirebladeMath.quaternion(angle: angle, axis: axis)
            let reference = simd_quaternion(angle, axis)
            #expect(differentialMatch(portable.elements, reference.vector.lanes, tolerance: Tolerance.doubleLoose), "input \(index): angle \(angle), axis \(axis)")
        }
    }

    // covers: quaternion(from: SIMD3<Double>, to: SIMD3<Double>)
    @Test func quaternionFromToD() {
        // simd_quaternion(from:to:) expects unit vectors.
        let directions = DifferentialInputs.vectors(dimension: 3, seed: 0x5005)
            .filter { $0.contains { $0 != 0 } }
            .map { simd_normalize(SIMD3<Double>($0)) }
        for (index, from) in directions.enumerated() {
            for to in [directions[(index + 1) % directions.count], from, -from] {
                let fromVector = SIMD3<Double>(Double(from.x), Double(from.y), Double(from.z))
                let toVector = SIMD3<Double>(Double(to.x), Double(to.y), Double(to.z))
                let portable = FirebladeMath.quaternion(from: fromVector, to: toVector)
                let reference = simd_quaternion(fromVector, toVector)
                #expect(differentialMatch(portable.elements, reference.vector.lanes, tolerance: Tolerance.doubleLoose), "input \(index): from \(fromVector) to \(toVector)")
            }
        }
    }
}
#endif
