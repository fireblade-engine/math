//
//  PortableVsSIMDMatrixTests.swift
//  FirebladeMathTests
//

// Differential tests for matrix multiplication, 3x3 determinant/inverse and transpose
// against Apple's simd. See PortableVsSIMDSupport.swift.

#if canImport(simd) && !FRB_MATH_USE_SIMD
import FirebladeMath
import simd
import Testing

struct PortableVsSIMDMatrixTests {

    // MARK: - Mat2x2f

    // covers: multiply(Mat2x2f, Mat2x2f)
    @Test func multiplyMatrixMatrix2x2f() {
        let inputs = DifferentialInputs.matrices(dimension: 2, seed: 0x1001)
        for (index, values) in inputs.enumerated() {
            let other = inputs[(index + 1) % inputs.count].floats
            let lhs = values.floats
            let portable = FirebladeMath.multiply(Mat2x2f(lhs), Mat2x2f(other))
            let reference = simd_mul(simd_float2x2(elements: lhs), simd_float2x2(elements: other))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: multiply(Float, Mat2x2f)
    @Test func multiplyScalarMatrix2x2f() {
        let scalars = DifferentialInputs.scalars(seed: 0x1201)
        for (index, values) in DifferentialInputs.matrices(dimension: 2, seed: 0x1001).enumerated() {
            let scalar = Float(scalars[index % scalars.count])
            let matrix = values.floats
            let portable = FirebladeMath.multiply(scalar, Mat2x2f(matrix))
            let reference = simd_mul(scalar, simd_float2x2(elements: matrix))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: multiply(Vec2f, Mat2x2f)
    // covers: multiply(Mat2x2f, Vec2f)
    @Test func multiplyVectorMatrix2x2f() {
        let vectors = DifferentialInputs.vectors(dimension: 2, seed: 0x1101)
        for (index, values) in DifferentialInputs.matrices(dimension: 2, seed: 0x1001).enumerated() {
            let vector = SIMD2<Float>(vectors[index % vectors.count].floats)
            let matrix = values.floats
            let rowTimesMatrix = FirebladeMath.multiply(vector, Mat2x2f(matrix))
            let matrixTimesColumn = FirebladeMath.multiply(Mat2x2f(matrix), vector)
            #expect(differentialMatch(rowTimesMatrix.lanes, simd_mul(vector, simd_float2x2(elements: matrix)).lanes, tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(matrixTimesColumn.lanes, simd_mul(simd_float2x2(elements: matrix), vector).lanes, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // MARK: - Mat2x2d

    // covers: multiply(Mat2x2d, Mat2x2d)
    @Test func multiplyMatrixMatrix2x2d() {
        let inputs = DifferentialInputs.matrices(dimension: 2, seed: 0x1002)
        for (index, values) in inputs.enumerated() {
            let other = inputs[(index + 1) % inputs.count]
            let lhs = values
            let portable = FirebladeMath.multiply(Mat2x2d(lhs), Mat2x2d(other))
            let reference = simd_mul(simd_double2x2(elements: lhs), simd_double2x2(elements: other))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // covers: multiply(Double, Mat2x2d)
    @Test func multiplyScalarMatrix2x2d() {
        let scalars = DifferentialInputs.scalars(seed: 0x1202)
        for (index, values) in DifferentialInputs.matrices(dimension: 2, seed: 0x1002).enumerated() {
            let scalar = Double(scalars[index % scalars.count])
            let matrix = values
            let portable = FirebladeMath.multiply(scalar, Mat2x2d(matrix))
            let reference = simd_mul(scalar, simd_double2x2(elements: matrix))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // covers: multiply(Vec2d, Mat2x2d)
    // covers: multiply(Mat2x2d, Vec2d)
    @Test func multiplyVectorMatrix2x2d() {
        let vectors = DifferentialInputs.vectors(dimension: 2, seed: 0x1102)
        for (index, values) in DifferentialInputs.matrices(dimension: 2, seed: 0x1002).enumerated() {
            let vector = SIMD2<Double>(vectors[index % vectors.count])
            let matrix = values
            let rowTimesMatrix = FirebladeMath.multiply(vector, Mat2x2d(matrix))
            let matrixTimesColumn = FirebladeMath.multiply(Mat2x2d(matrix), vector)
            #expect(differentialMatch(rowTimesMatrix.lanes, simd_mul(vector, simd_double2x2(elements: matrix)).lanes, tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(matrixTimesColumn.lanes, simd_mul(simd_double2x2(elements: matrix), vector).lanes, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // MARK: - Mat3x3f

    // covers: multiply(Mat3x3f, Mat3x3f)
    @Test func multiplyMatrixMatrix3x3f() {
        let inputs = DifferentialInputs.matrices(dimension: 3, seed: 0x1003)
        for (index, values) in inputs.enumerated() {
            let other = inputs[(index + 1) % inputs.count].floats
            let lhs = values.floats
            let portable = FirebladeMath.multiply(Mat3x3f(lhs), Mat3x3f(other))
            let reference = simd_mul(simd_float3x3(elements: lhs), simd_float3x3(elements: other))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: multiply(Float, Mat3x3f)
    @Test func multiplyScalarMatrix3x3f() {
        let scalars = DifferentialInputs.scalars(seed: 0x1203)
        for (index, values) in DifferentialInputs.matrices(dimension: 3, seed: 0x1003).enumerated() {
            let scalar = Float(scalars[index % scalars.count])
            let matrix = values.floats
            let portable = FirebladeMath.multiply(scalar, Mat3x3f(matrix))
            let reference = simd_mul(scalar, simd_float3x3(elements: matrix))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: multiply(Vec3f, Mat3x3f)
    // covers: multiply(Mat3x3f, Vec3f)
    @Test func multiplyVectorMatrix3x3f() {
        let vectors = DifferentialInputs.vectors(dimension: 3, seed: 0x1103)
        for (index, values) in DifferentialInputs.matrices(dimension: 3, seed: 0x1003).enumerated() {
            let vector = SIMD3<Float>(vectors[index % vectors.count].floats)
            let matrix = values.floats
            let rowTimesMatrix = FirebladeMath.multiply(vector, Mat3x3f(matrix))
            let matrixTimesColumn = FirebladeMath.multiply(Mat3x3f(matrix), vector)
            #expect(differentialMatch(rowTimesMatrix.lanes, simd_mul(vector, simd_float3x3(elements: matrix)).lanes, tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(matrixTimesColumn.lanes, simd_mul(simd_float3x3(elements: matrix), vector).lanes, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: transpose(Mat3x3f)
    @Test func transpose3x3f() {
        for (index, values) in DifferentialInputs.matrices(dimension: 3, seed: 0x1003).enumerated() {
            let matrix = values.floats
            let portable = FirebladeMath.transpose(Mat3x3f(matrix))
            let reference = simd_transpose(simd_float3x3(elements: matrix))
            #expect(portable.elements == reference.elements, "input \(index)")
        }
    }

    // covers: determinant(Mat3x3f)
    @Test func determinant3x3f() {
        let singular: [[Double]] = [[Double](repeating: 0, count: 9), [1, 2, 3, 2, 4, 6, 0, 1, 5], [1, 2, 3, 4, 5, 6, 7, 8, 9]]
        for (index, values) in (DifferentialInputs.matrices(dimension: 3, seed: 0x1003) + singular).enumerated() {
            let matrix = values.floats
            let scale = Swift.max(1, values.map { Swift.abs($0) }.max() ?? 1)
            let portable = FirebladeMath.determinant(Mat3x3f(matrix))
            let reference = simd_determinant(simd_float3x3(elements: matrix))
            #expect(differentialMatch(Double(portable), Double(reference), tolerance: Tolerance.float, scale: scale * scale * scale), "input \(index)")
        }
    }

    // covers: inverse(Mat3x3f)
    @Test func inverse3x3f() {
        for (index, values) in DifferentialInputs.matrices(dimension: 3, seed: 0x1003).enumerated() {
            let matrix = values.floats
            let scale = Swift.max(1, values.map { Swift.abs($0) }.max() ?? 1)
            // Skip near-singular inputs: both sides would only amplify rounding noise.
            guard Swift.abs(Double(simd_determinant(simd_float3x3(elements: matrix)))) > 1e-2 * scale * scale * scale else { continue }
            let portable = FirebladeMath.inverse(Mat3x3f(matrix))
            let reference = simd_inverse(simd_float3x3(elements: matrix))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.floatLoose), "input \(index)")
        }
    }

    // MARK: - Mat3x3d

    // covers: multiply(Mat3x3d, Mat3x3d)
    @Test func multiplyMatrixMatrix3x3d() {
        let inputs = DifferentialInputs.matrices(dimension: 3, seed: 0x1004)
        for (index, values) in inputs.enumerated() {
            let other = inputs[(index + 1) % inputs.count]
            let lhs = values
            let portable = FirebladeMath.multiply(Mat3x3d(lhs), Mat3x3d(other))
            let reference = simd_mul(simd_double3x3(elements: lhs), simd_double3x3(elements: other))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // covers: multiply(Double, Mat3x3d)
    @Test func multiplyScalarMatrix3x3d() {
        let scalars = DifferentialInputs.scalars(seed: 0x1204)
        for (index, values) in DifferentialInputs.matrices(dimension: 3, seed: 0x1004).enumerated() {
            let scalar = Double(scalars[index % scalars.count])
            let matrix = values
            let portable = FirebladeMath.multiply(scalar, Mat3x3d(matrix))
            let reference = simd_mul(scalar, simd_double3x3(elements: matrix))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // covers: multiply(Vec3d, Mat3x3d)
    // covers: multiply(Mat3x3d, Vec3d)
    @Test func multiplyVectorMatrix3x3d() {
        let vectors = DifferentialInputs.vectors(dimension: 3, seed: 0x1104)
        for (index, values) in DifferentialInputs.matrices(dimension: 3, seed: 0x1004).enumerated() {
            let vector = SIMD3<Double>(vectors[index % vectors.count])
            let matrix = values
            let rowTimesMatrix = FirebladeMath.multiply(vector, Mat3x3d(matrix))
            let matrixTimesColumn = FirebladeMath.multiply(Mat3x3d(matrix), vector)
            #expect(differentialMatch(rowTimesMatrix.lanes, simd_mul(vector, simd_double3x3(elements: matrix)).lanes, tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(matrixTimesColumn.lanes, simd_mul(simd_double3x3(elements: matrix), vector).lanes, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // covers: transpose(Mat3x3d)
    @Test func transpose3x3d() {
        for (index, values) in DifferentialInputs.matrices(dimension: 3, seed: 0x1004).enumerated() {
            let matrix = values
            let portable = FirebladeMath.transpose(Mat3x3d(matrix))
            let reference = simd_transpose(simd_double3x3(elements: matrix))
            #expect(portable.elements == reference.elements, "input \(index)")
        }
    }

    // covers: determinant(Mat3x3d)
    @Test func determinant3x3d() {
        let singular: [[Double]] = [[Double](repeating: 0, count: 9), [1, 2, 3, 2, 4, 6, 0, 1, 5], [1, 2, 3, 4, 5, 6, 7, 8, 9]]
        for (index, values) in (DifferentialInputs.matrices(dimension: 3, seed: 0x1004) + singular).enumerated() {
            let matrix = values
            let scale = Swift.max(1, values.map { Swift.abs($0) }.max() ?? 1)
            let portable = FirebladeMath.determinant(Mat3x3d(matrix))
            let reference = simd_determinant(simd_double3x3(elements: matrix))
            #expect(differentialMatch(Double(portable), Double(reference), tolerance: Tolerance.double, scale: scale * scale * scale), "input \(index)")
        }
    }

    // covers: inverse(Mat3x3d)
    @Test func inverse3x3d() {
        for (index, values) in DifferentialInputs.matrices(dimension: 3, seed: 0x1004).enumerated() {
            let matrix = values
            let scale = Swift.max(1, values.map { Swift.abs($0) }.max() ?? 1)
            // Skip near-singular inputs: both sides would only amplify rounding noise.
            guard Swift.abs(Double(simd_determinant(simd_double3x3(elements: matrix)))) > 1e-2 * scale * scale * scale else { continue }
            let portable = FirebladeMath.inverse(Mat3x3d(matrix))
            let reference = simd_inverse(simd_double3x3(elements: matrix))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.doubleLoose), "input \(index)")
        }
    }

    // MARK: - Mat4x4f

    // covers: multiply(Mat4x4f, Mat4x4f)
    @Test func multiplyMatrixMatrix4x4f() {
        let inputs = DifferentialInputs.matrices(dimension: 4, seed: 0x1005)
        for (index, values) in inputs.enumerated() {
            let other = inputs[(index + 1) % inputs.count].floats
            let lhs = values.floats
            let portable = FirebladeMath.multiply(Mat4x4f(lhs), Mat4x4f(other))
            let reference = simd_mul(simd_float4x4(elements: lhs), simd_float4x4(elements: other))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: multiply(Float, Mat4x4f)
    @Test func multiplyScalarMatrix4x4f() {
        let scalars = DifferentialInputs.scalars(seed: 0x1205)
        for (index, values) in DifferentialInputs.matrices(dimension: 4, seed: 0x1005).enumerated() {
            let scalar = Float(scalars[index % scalars.count])
            let matrix = values.floats
            let portable = FirebladeMath.multiply(scalar, Mat4x4f(matrix))
            let reference = simd_mul(scalar, simd_float4x4(elements: matrix))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: multiply(Vec4f, Mat4x4f)
    // covers: multiply(Mat4x4f, Vec4f)
    @Test func multiplyVectorMatrix4x4f() {
        let vectors = DifferentialInputs.vectors(dimension: 4, seed: 0x1105)
        for (index, values) in DifferentialInputs.matrices(dimension: 4, seed: 0x1005).enumerated() {
            let vector = SIMD4<Float>(vectors[index % vectors.count].floats)
            let matrix = values.floats
            let rowTimesMatrix = FirebladeMath.multiply(vector, Mat4x4f(matrix))
            let matrixTimesColumn = FirebladeMath.multiply(Mat4x4f(matrix), vector)
            #expect(differentialMatch(rowTimesMatrix.lanes, simd_mul(vector, simd_float4x4(elements: matrix)).lanes, tolerance: Tolerance.float), "input \(index)")
            #expect(differentialMatch(matrixTimesColumn.lanes, simd_mul(simd_float4x4(elements: matrix), vector).lanes, tolerance: Tolerance.float), "input \(index)")
        }
    }

    // covers: transpose(Mat4x4f)
    @Test func transpose4x4f() {
        for (index, values) in DifferentialInputs.matrices(dimension: 4, seed: 0x1005).enumerated() {
            let matrix = values.floats
            let portable = FirebladeMath.transpose(Mat4x4f(matrix))
            let reference = simd_transpose(simd_float4x4(elements: matrix))
            #expect(portable.elements == reference.elements, "input \(index)")
        }
    }

    // MARK: - Mat4x4d

    // covers: multiply(Mat4x4d, Mat4x4d)
    @Test func multiplyMatrixMatrix4x4d() {
        let inputs = DifferentialInputs.matrices(dimension: 4, seed: 0x1006)
        for (index, values) in inputs.enumerated() {
            let other = inputs[(index + 1) % inputs.count]
            let lhs = values
            let portable = FirebladeMath.multiply(Mat4x4d(lhs), Mat4x4d(other))
            let reference = simd_mul(simd_double4x4(elements: lhs), simd_double4x4(elements: other))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // covers: multiply(Double, Mat4x4d)
    @Test func multiplyScalarMatrix4x4d() {
        let scalars = DifferentialInputs.scalars(seed: 0x1206)
        for (index, values) in DifferentialInputs.matrices(dimension: 4, seed: 0x1006).enumerated() {
            let scalar = Double(scalars[index % scalars.count])
            let matrix = values
            let portable = FirebladeMath.multiply(scalar, Mat4x4d(matrix))
            let reference = simd_mul(scalar, simd_double4x4(elements: matrix))
            #expect(differentialMatch(portable.elements, reference.elements, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // covers: multiply(Vec4d, Mat4x4d)
    // covers: multiply(Mat4x4d, Vec4d)
    @Test func multiplyVectorMatrix4x4d() {
        let vectors = DifferentialInputs.vectors(dimension: 4, seed: 0x1106)
        for (index, values) in DifferentialInputs.matrices(dimension: 4, seed: 0x1006).enumerated() {
            let vector = SIMD4<Double>(vectors[index % vectors.count])
            let matrix = values
            let rowTimesMatrix = FirebladeMath.multiply(vector, Mat4x4d(matrix))
            let matrixTimesColumn = FirebladeMath.multiply(Mat4x4d(matrix), vector)
            #expect(differentialMatch(rowTimesMatrix.lanes, simd_mul(vector, simd_double4x4(elements: matrix)).lanes, tolerance: Tolerance.double), "input \(index)")
            #expect(differentialMatch(matrixTimesColumn.lanes, simd_mul(simd_double4x4(elements: matrix), vector).lanes, tolerance: Tolerance.double), "input \(index)")
        }
    }

    // covers: transpose(Mat4x4d)
    @Test func transpose4x4d() {
        for (index, values) in DifferentialInputs.matrices(dimension: 4, seed: 0x1006).enumerated() {
            let matrix = values
            let portable = FirebladeMath.transpose(Mat4x4d(matrix))
            let reference = simd_transpose(simd_double4x4(elements: matrix))
            #expect(portable.elements == reference.elements, "input \(index)")
        }
    }
}
#endif
