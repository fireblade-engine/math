//
//  PortableVsSIMDTests.swift
//  FirebladeMathTests
//

// Differential tests: FirebladeMath's portable (non-simd) implementations against Apple's
// simd library, which is exactly what FirebladeMath forwards to when the `simd` trait is on.
//
// Only compiled when Apple's simd is available but the `simd` trait is disabled, i.e.
// `swift test --disable-default-traits` on Apple platforms (see the macOS CI workflow).
//
// Covers the functions with portable implementations changed in #76:
// 4x4 inverse, determinant and adjugate, and quaternion multiplication.
//
// Tolerances are about 10x the worst deviation measured over all inputs; both sides differ
// only by floating-point rounding.

#if canImport(simd) && !FRB_MATH_USE_SIMD
import FirebladeMath
import simd
import Testing

struct PortableVsSIMDTests {
    // MARK: - Inputs

    /// Column-major 4x4 element lists: pseudo-random matrices plus structured cases.
    static let matrices: [[Double]] = {
        var generator = SplitMix(seed: 0x5EED_CAFE_F00D_BEEF)
        var result: [[Double]] = (0..<256).map { _ in (0..<16).map { _ in generator.next(in: -2...2) } }

        let identity: [Double] = [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]
        result.append(identity)
        result.append([2, 0, 0, 0, 0, -3, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 7]) // diagonal
        result.append([0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0]) // permutation
        result.append(rotationAndTranslation(angle: 0.7, axis: (1, 2, 3), translation: (4, -5, 6)))
        result.append(identity.map { $0 * 1e-3 }) // small scale
        result.append(result[0].map { $0 * 1e3 }) // large scale
        return result
    }()

    /// Singular matrices: only the determinant is compared for these.
    static let singularMatrices: [[Double]] = [
        [Double](repeating: 0, count: 16),
        [1, 2, 3, 4, 2, 4, 6, 8, 0, 1, 0, 1, 5, 0, 5, 0], // column 1 = 2 * column 0
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] // rank 2
    ]

    /// Quaternion pairs as [x, y, z, w]: pseudo-random plus basis elements.
    static let quaternionPairs: [([Double], [Double])] = {
        var generator = SplitMix(seed: 0x0DDB_A11C_0FFE_E123)
        var result: [([Double], [Double])] = (0..<256).map { _ in
            ((0..<4).map { _ in generator.next(in: -2...2) }, (0..<4).map { _ in generator.next(in: -2...2) })
        }
        let basis: [[Double]] = [[0, 0, 0, 1], [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0]]
        for lhs in basis {
            for rhs in basis {
                result.append((lhs, rhs))
            }
        }
        return result
    }()

    // MARK: - 4x4 determinant

    @Test(arguments: matrices + singularMatrices)
    func determinantDouble(_ values: [Double]) {
        let portable = FirebladeMath.determinant(Mat4x4d(values))
        let reference = simd_determinant(simd_double4x4(values))
        #expect(isClose(portable, reference, scale: magnitude(values) ^^ 4, tolerance: 1e-14))
    }

    @Test(arguments: matrices + singularMatrices)
    func determinantFloat(_ values: [Double]) {
        let floats = values.map(Float.init)
        let portable = FirebladeMath.determinant(Mat4x4f(floats))
        let reference = simd_determinant(simd_float4x4(floats))
        #expect(isClose(Double(portable), Double(reference), scale: magnitude(values) ^^ 4, tolerance: 3e-6))
    }

    // MARK: - 4x4 inverse

    @Test(arguments: matrices)
    func inverseDouble(_ values: [Double]) {
        let reference = simd_inverse(simd_double4x4(values))
        let portable = FirebladeMath.inverse(Mat4x4d(values))
        #expect(isClose(portable.elements, reference.elements, tolerance: 5e-13))
    }

    @Test(arguments: matrices)
    func inverseFloat(_ values: [Double]) {
        let floats = values.map(Float.init)
        let reference = simd_inverse(simd_float4x4(floats))
        let portable = FirebladeMath.inverse(Mat4x4f(floats))
        #expect(isClose(portable.elements.map(Double.init), reference.elements.map(Double.init), tolerance: 2e-4))
    }

    // MARK: - 4x4 adjugate (simd has none; adjugate(m) = inverse(m) * determinant(m))

    @Test(arguments: matrices)
    func adjugateDouble(_ values: [Double]) {
        let matrix = simd_double4x4(values)
        let reference = simd_inverse(matrix) * simd_determinant(matrix)
        let portable = FirebladeMath.adjugate(Mat4x4d(values))
        #expect(isClose(portable.elements, reference.elements, tolerance: 5e-13))
    }

    @Test(arguments: matrices)
    func adjugateFloat(_ values: [Double]) {
        let floats = values.map(Float.init)
        let matrix = simd_float4x4(floats)
        let reference = simd_inverse(matrix) * simd_determinant(matrix)
        let portable = FirebladeMath.adjugate(Mat4x4f(floats))
        #expect(isClose(portable.elements.map(Double.init), reference.elements.map(Double.init), tolerance: 2e-4))
    }

    // MARK: - Quaternion multiplication

    @Test(arguments: quaternionPairs)
    func quaternionMultiplyDouble(_ pair: ([Double], [Double])) {
        let (lhs, rhs) = pair
        let reference = simd_mul(simd_quatd(vector: SIMD4(lhs)), simd_quatd(vector: SIMD4(rhs))).vector
        let portable = FirebladeMath.multiply(Quat4d(SIMD4(lhs)), Quat4d(SIMD4(rhs)))
        #expect(isClose(portable.elements, Array(reference), tolerance: 1e-14))
    }

    @Test(arguments: quaternionPairs)
    func quaternionMultiplyFloat(_ pair: ([Double], [Double])) {
        let (lhs, rhs) = pair
        let left = SIMD4<Float>(lhs.map(Float.init))
        let right = SIMD4<Float>(rhs.map(Float.init))
        let reference = simd_mul(simd_quatf(vector: left), simd_quatf(vector: right)).vector
        let portable = FirebladeMath.multiply(Quat4f(left), Quat4f(right))
        #expect(isClose(portable.elements.map(Double.init), Array(reference).map(Double.init), tolerance: 2e-6))
    }
}

// MARK: - Helpers

private struct SplitMix {
    var state: UInt64

    init(seed: UInt64) { state = seed }

    mutating func next(in range: ClosedRange<Double>) -> Double {
        state &+= 0x9E37_79B9_7F4A_7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58_476D_1CE4_E5B9
        z = (z ^ (z >> 27)) &* 0x94D0_49BB_1331_11EB
        z ^= z >> 31
        let unit = Double(z >> 11) / Double(1 << 53)
        return range.lowerBound + unit * (range.upperBound - range.lowerBound)
    }
}

private func rotationAndTranslation(angle: Double, axis: (Double, Double, Double), translation: (Double, Double, Double)) -> [Double] {
    let rotation = simd_matrix4x4(simd_quatd(angle: angle, axis: simd_normalize(SIMD3(axis.0, axis.1, axis.2))))
    var values = rotation.elements
    values[12] = translation.0
    values[13] = translation.1
    values[14] = translation.2
    return values
}

private extension simd_double4x4 {
    init(_ values: [Double]) {
        self.init(SIMD4(values[0..<4]), SIMD4(values[4..<8]), SIMD4(values[8..<12]), SIMD4(values[12..<16]))
    }

    var elements: [Double] {
        [columns.0, columns.1, columns.2, columns.3].flatMap { [$0.x, $0.y, $0.z, $0.w] }
    }
}

private extension simd_float4x4 {
    init(_ values: [Float]) {
        self.init(SIMD4(values[0..<4]), SIMD4(values[4..<8]), SIMD4(values[8..<12]), SIMD4(values[12..<16]))
    }

    var elements: [Float] {
        [columns.0, columns.1, columns.2, columns.3].flatMap { [$0.x, $0.y, $0.z, $0.w] }
    }
}

private func magnitude(_ values: [Double]) -> Double {
    Swift.max(1, values.map { Swift.abs($0) }.max() ?? 1)
}

infix operator ^^: MultiplicationPrecedence
private func ^^ (base: Double, exponent: Int) -> Double {
    (0..<exponent).reduce(1) { result, _ in result * base }
}

/// Compares relative to `scale`, the magnitude the result can reasonably have.
private func isClose(_ lhs: Double, _ rhs: Double, scale: Double, tolerance: Double) -> Bool {
    Swift.abs(lhs - rhs) <= tolerance * Swift.max(1, scale)
}

/// Compares element-wise relative to the largest reference element.
private func isClose(_ lhs: [Double], _ rhs: [Double], tolerance: Double) -> Bool {
    let scale = Swift.max(1, rhs.map { Swift.abs($0) }.max() ?? 1)
    return lhs.count == rhs.count && zip(lhs, rhs).allSatisfy { Swift.abs($0 - $1) <= tolerance * scale }
}
#endif
