//
//  Matrix4x4CofactorTests.swift
//  FirebladeMathTests
//

// Checks the 4x4 adjugate, determinant and inverse against a straightforward
// cofactor expansion that is written independently of the library code.

import FirebladeMath
import Testing

struct Matrix4x4CofactorTests {
    /// Deterministic, well-conditioned test matrices (column-major element lists).
    static let matrices: [[Double]] = {
        var state: UInt64 = 0x9E37_79B9_7F4A_7C15
        func next() -> Double {
            state = state &* 6_364_136_223_846_793_005 &+ 1_442_695_040_888_963_407
            return Double(state >> 11) * 0x1p-53 * 4 - 2
        }
        var result: [[Double]] = []
        for _ in 0..<32 {
            var values = (0..<16).map { _ in next() }
            // Strengthen the diagonal so every matrix is safely invertible.
            for index in stride(from: 0, to: 16, by: 5) {
                values[index] += 6
            }
            result.append(values)
        }
        return result
    }()

    @Test(arguments: matrices)
    func adjugateDeterminantInverseDouble(_ values: [Double]) {
        let matrix = Mat4x4d(values)
        let (expectedAdjugate, expectedDeterminant) = referenceAdjugateAndDeterminant(values)

        #expect(isClose(determinant(matrix), expectedDeterminant, tolerance: 1e-9))
        #expect(isClose(adjugate(matrix).elements, expectedAdjugate, tolerance: 1e-9))

        let product = (matrix * inverse(matrix)).elements
        #expect(isClose(product, Mat4x4d.identity.elements, tolerance: 1e-12))
    }

    @Test(arguments: matrices)
    func adjugateDeterminantInverseFloat(_ values: [Double]) {
        let matrix = Mat4x4f(values.map(Float.init))
        let (expectedAdjugate, expectedDeterminant) = referenceAdjugateAndDeterminant(values)

        #expect(isClose(Double(determinant(matrix)), expectedDeterminant, tolerance: 1e-4))
        #expect(isClose(adjugate(matrix).elements.map(Double.init), expectedAdjugate, tolerance: 1e-4))

        let product = (matrix * inverse(matrix)).elements
        #expect(isClose(product.map(Double.init), Mat4x4d.identity.elements, tolerance: 1e-5))
    }

    @Test func singularMatrixHasZeroDeterminant() {
        let singular = Mat4x4d([1, 2, 3, 4, 2, 4, 6, 8, 0, 1, 0, 1, 5, 0, 5, 0])
        #expect(determinant(singular) == 0)
        #expect(determinant(Mat4x4f(singular.elements.map(Float.init))) == 0)
    }
}

/// Cofactor expansion on a column-major element list; element (row, column) is `values[column * 4 + row]`.
private func referenceAdjugateAndDeterminant(_ values: [Double]) -> (adjugate: [Double], determinant: Double) {
    func element(_ row: Int, _ column: Int) -> Double { values[column * 4 + row] }

    func minor(_ skipRow: Int, _ skipColumn: Int) -> Double {
        let rows = (0..<4).filter { $0 != skipRow }
        let columns = (0..<4).filter { $0 != skipColumn }
        func m(_ row: Int, _ column: Int) -> Double { element(rows[row], columns[column]) }
        return m(0, 0) * (m(1, 1) * m(2, 2) - m(1, 2) * m(2, 1))
            - m(0, 1) * (m(1, 0) * m(2, 2) - m(1, 2) * m(2, 0))
            + m(0, 2) * (m(1, 0) * m(2, 1) - m(1, 1) * m(2, 0))
    }

    func cofactor(_ row: Int, _ column: Int) -> Double {
        ((row + column).isMultiple(of: 2) ? 1 : -1) * minor(row, column)
    }

    // adjugate(row, column) = cofactor(column, row); stored column-major.
    var adjugate = [Double](repeating: 0, count: 16)
    for column in 0..<4 {
        for row in 0..<4 {
            adjugate[column * 4 + row] = cofactor(column, row)
        }
    }
    let determinant = (0..<4).reduce(0) { $0 + element(0, $1) * cofactor(0, $1) }
    return (adjugate, determinant)
}

private func isClose(_ lhs: Double, _ rhs: Double, tolerance: Double) -> Bool {
    Swift.abs(lhs - rhs) <= tolerance * Swift.max(1, Swift.abs(rhs))
}

private func isClose(_ lhs: [Double], _ rhs: [Double], tolerance: Double) -> Bool {
    lhs.count == rhs.count && zip(lhs, rhs).allSatisfy { isClose($0, $1, tolerance: tolerance) }
}
