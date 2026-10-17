//
//  QuaternionMultiplicationTests.swift
//  FirebladeMathTests
//

// Checks the quaternion (Hamilton) product for Float and Double against a scalar
// reference written independently of the library, plus the defining algebraic rules.

import FirebladeMath
import Testing

struct QuaternionMultiplicationTests {
    /// Deterministic pseudo-random quaternion pairs as [x, y, z, w] component lists.
    static let pairs: [([Double], [Double])] = {
        var state: UInt64 = 0xD1B5_4A32_D192_ED03
        func next() -> Double {
            state = state &* 6_364_136_223_846_793_005 &+ 1_442_695_040_888_963_407
            return Double(state >> 11) / Double(1 << 53) * 4 - 2
        }
        return (0..<64).map { _ in ((0..<4).map { _ in next() }, (0..<4).map { _ in next() }) }
    }()

    @Test(arguments: pairs)
    func matchesReferenceDouble(_ pair: ([Double], [Double])) {
        let (lhs, rhs) = pair
        let expected = referenceHamiltonProduct(lhs, rhs)
        let product = Quat4d(lhs[0], lhs[1], lhs[2], lhs[3]) * Quat4d(rhs[0], rhs[1], rhs[2], rhs[3])
        #expect(isClose(product.elements, expected, tolerance: 1e-12))
        #expect(multiply(Quat4d(lhs[0], lhs[1], lhs[2], lhs[3]), Quat4d(rhs[0], rhs[1], rhs[2], rhs[3])) == product)
    }

    @Test(arguments: pairs)
    func matchesReferenceFloat(_ pair: ([Double], [Double])) {
        let (lhs, rhs) = pair
        let expected = referenceHamiltonProduct(lhs, rhs)
        let left = Quat4f(Float(lhs[0]), Float(lhs[1]), Float(lhs[2]), Float(lhs[3]))
        let right = Quat4f(Float(rhs[0]), Float(rhs[1]), Float(rhs[2]), Float(rhs[3]))
        let product = left * right
        #expect(isClose(product.elements.map(Double.init), expected, tolerance: 1e-5))
        #expect(multiply(left, right) == product)
    }

    @Test func basisRulesDouble() {
        let one = Quat4d(0, 0, 0, 1)
        let i = Quat4d(1, 0, 0, 0)
        let j = Quat4d(0, 1, 0, 0)
        let k = Quat4d(0, 0, 1, 0)
        let minusOne = Quat4d(0, 0, 0, -1)

        #expect(i * j == k)
        #expect(j * k == i)
        #expect(k * i == j)
        #expect(j * i == Quat4d(0, 0, -1, 0))
        #expect(i * i == minusOne)
        #expect(j * j == minusOne)
        #expect(k * k == minusOne)
        #expect(one * i == i)
        #expect(i * one == i)
    }

    @Test func basisRulesFloat() {
        let one = Quat4f(0, 0, 0, 1)
        let i = Quat4f(1, 0, 0, 0)
        let j = Quat4f(0, 1, 0, 0)
        let k = Quat4f(0, 0, 1, 0)
        let minusOne = Quat4f(0, 0, 0, -1)

        #expect(i * j == k)
        #expect(j * k == i)
        #expect(k * i == j)
        #expect(j * i == Quat4f(0, 0, -1, 0))
        #expect(i * i == minusOne)
        #expect(j * j == minusOne)
        #expect(k * k == minusOne)
        #expect(one * i == i)
        #expect(i * one == i)
    }

    @Test(arguments: pairs)
    func normIsMultiplicative(_ pair: ([Double], [Double])) {
        let (lhs, rhs) = pair
        let left = Quat4d(lhs[0], lhs[1], lhs[2], lhs[3])
        let right = Quat4d(rhs[0], rhs[1], rhs[2], rhs[3])
        #expect(isClose([(left * right).length], [left.length * right.length], tolerance: 1e-12))
    }
}

/// Hamilton product on [x, y, z, w] component lists, written out per component.
private func referenceHamiltonProduct(_ lhs: [Double], _ rhs: [Double]) -> [Double] {
    let (ax, ay, az, aw) = (lhs[0], lhs[1], lhs[2], lhs[3])
    let (bx, by, bz, bw) = (rhs[0], rhs[1], rhs[2], rhs[3])
    let x = aw * bx + ax * bw + ay * bz - az * by
    let y = aw * by - ax * bz + ay * bw + az * bx
    let z = aw * bz + ax * by - ay * bx + az * bw
    let w = aw * bw - ax * bx - ay * by - az * bz
    return [x, y, z, w]
}

private func isClose(_ lhs: [Double], _ rhs: [Double], tolerance: Double) -> Bool {
    lhs.count == rhs.count && zip(lhs, rhs).allSatisfy { Swift.abs($0 - $1) <= tolerance * Swift.max(1, Swift.abs($1)) }
}
