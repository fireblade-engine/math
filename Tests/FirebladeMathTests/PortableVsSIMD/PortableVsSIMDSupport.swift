//
//  PortableVsSIMDSupport.swift
//  FirebladeMathTests
//

// Shared inputs and helpers for the PortableVsSIMD differential tests, which compare
// FirebladeMath's portable implementations against Apple's simd library.
//
// Only compiled when Apple's simd is available but the `simd` trait is disabled
// (`swift test --disable-default-traits` on Apple platforms).
//
// Every test is annotated with `// covers: name(ParameterTypes)` lines naming the
// FirebladeMath functions it compares. Scripts/check-simd-differential-coverage.py
// fails CI if a function with a simd branch has no such annotation.

#if canImport(simd) && !FRB_MATH_USE_SIMD
import FirebladeMath
import simd

// MARK: - Deterministic inputs

/// SplitMix64: a small deterministic generator, so failures are reproducible.
struct SplitMix {
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

    mutating func values(_ count: Int, in range: ClosedRange<Double> = -2...2) -> [Double] {
        (0..<count).map { _ in next(in: range) }
    }
}

enum DifferentialInputs {
    static let randomCount = 256

    /// Column-major n x n element lists: pseudo-random plus identity, diagonal, permutation,
    /// small and large scale.
    static func matrices(dimension n: Int, seed: UInt64) -> [[Double]] {
        var generator = SplitMix(seed: seed)
        var result = (0..<randomCount).map { _ in generator.values(n * n) }
        let identity = (0..<n * n).map { $0 % (n + 1) == 0 ? 1.0 : 0.0 }
        result.append(identity)
        result.append((0..<n * n).map { $0 % (n + 1) == 0 ? Double($0 % 7) - 3.5 : 0.0 }) // diagonal
        result.append((0..<n * n).map { index -> Double in // cyclic permutation
            let column = index / n, row = index % n
            return row == (column + 1) % n ? 1 : 0
        })
        result.append(identity.map { $0 * 1e-3 })
        result.append(result[0].map { $0 * 1e3 })
        return result
    }

    /// Vectors as element lists: pseudo-random plus zero, unit axes, negative, tiny and large.
    static func vectors(dimension n: Int, seed: UInt64) -> [[Double]] {
        var generator = SplitMix(seed: seed)
        var result = (0..<randomCount).map { _ in generator.values(n) }
        result.append([Double](repeating: 0, count: n))
        for axis in 0..<n {
            result.append((0..<n).map { $0 == axis ? 1 : 0 })
            result.append((0..<n).map { $0 == axis ? -1 : 0 })
        }
        result.append([Double](repeating: 1e-3, count: n))
        result.append([Double](repeating: 1e3, count: n))
        return result
    }

    /// Quaternions as [x, y, z, w]: pseudo-random plus identity, the basis and their negations.
    static func quaternions(seed: UInt64) -> [[Double]] {
        var generator = SplitMix(seed: seed)
        var result = (0..<randomCount).map { _ in generator.values(4) }
        let basis: [[Double]] = [[0, 0, 0, 1], [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0]]
        result += basis + basis.map { $0.map { -$0 } }
        return result
    }

    /// Unit quaternions (rotations): random rotations plus identity and 180-degree turns.
    static func rotations(seed: UInt64) -> [[Double]] {
        var generator = SplitMix(seed: seed)
        var result = (0..<randomCount).map { _ -> [Double] in
            let q = simd_normalize(simd_quatd(vector: SIMD4(generator.values(4))))
            return Array(q.vector)
        }
        result += [[0, 0, 0, 1], [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, -1]]
        let half = 0.5.squareRoot()
        result += [[half, half, 0, 0], [0, half, half, 0], [half, 0, half, 0]] // 180 degrees about diagonals
        return result
    }

    /// Scalars: pseudo-random over a wide range plus special values.
    static func scalars(seed: UInt64) -> [Double] {
        var generator = SplitMix(seed: seed)
        return generator.values(randomCount, in: -100...100) + [
            0, -0.0, 1, -1, 0.5, -0.5, 2.5, -2.5, 1e-30, -1e-30, 1e30, -1e30
        ]
    }

    /// Special floating-point values, for functions where both implementations must agree on them.
    static let specialScalars: [Double] = [.nan, .infinity, -.infinity, 0, -0.0]
}

// MARK: - simd conversions

extension simd_float2x2 {
    init(elements values: [Float]) { self.init(SIMD2(values[0..<2]), SIMD2(values[2..<4])) }
    var elements: [Float] { [columns.0, columns.1].flatMap { [$0.x, $0.y] } }
}

extension simd_double2x2 {
    init(elements values: [Double]) { self.init(SIMD2(values[0..<2]), SIMD2(values[2..<4])) }
    var elements: [Double] { [columns.0, columns.1].flatMap { [$0.x, $0.y] } }
}

extension simd_float3x3 {
    init(elements values: [Float]) { self.init(SIMD3(values[0..<3]), SIMD3(values[3..<6]), SIMD3(values[6..<9])) }
    var elements: [Float] { [columns.0, columns.1, columns.2].flatMap { [$0.x, $0.y, $0.z] } }
}

extension simd_double3x3 {
    init(elements values: [Double]) { self.init(SIMD3(values[0..<3]), SIMD3(values[3..<6]), SIMD3(values[6..<9])) }
    var elements: [Double] { [columns.0, columns.1, columns.2].flatMap { [$0.x, $0.y, $0.z] } }
}

extension simd_float4x4 {
    init(elements values: [Float]) {
        self.init(SIMD4(values[0..<4]), SIMD4(values[4..<8]), SIMD4(values[8..<12]), SIMD4(values[12..<16]))
    }

    var elements: [Float] { [columns.0, columns.1, columns.2, columns.3].flatMap { [$0.x, $0.y, $0.z, $0.w] } }
}

extension simd_double4x4 {
    init(elements values: [Double]) {
        self.init(SIMD4(values[0..<4]), SIMD4(values[4..<8]), SIMD4(values[8..<12]), SIMD4(values[12..<16]))
    }

    var elements: [Double] { [columns.0, columns.1, columns.2, columns.3].flatMap { [$0.x, $0.y, $0.z, $0.w] } }
}

extension Array where Element == Double {
    var floats: [Float] { map(Float.init) }
}

extension SIMD {
    var lanes: [Scalar] { indices.map { self[$0] } }
}

// MARK: - Comparison

/// Floating-point comparison for differential tests.
///
/// Values match if they are bit-for-bit equal in kind (both NaN, same infinity, same signed
/// zero when `signedZero` is set) or differ by at most `tolerance` relative to `scale`.
func differentialMatch(
    _ portable: Double,
    _ reference: Double,
    tolerance: Double,
    scale: Double = 1,
    signedZero: Bool = false
) -> Bool {
    if portable.isNaN || reference.isNaN { return portable.isNaN && reference.isNaN }
    if portable.isInfinite || reference.isInfinite { return portable == reference }
    if signedZero, portable == 0, reference == 0 { return portable.sign == reference.sign }
    return Swift.abs(portable - reference) <= tolerance * Swift.max(1, scale, Swift.abs(reference))
}

/// Element-wise `differentialMatch`, relative to the largest finite reference element.
func differentialMatch(_ portable: [Double], _ reference: [Double], tolerance: Double) -> Bool {
    let scale = reference.filter(\.isFinite).map { Swift.abs($0) }.max() ?? 1
    return portable.count == reference.count
        && zip(portable, reference).allSatisfy { differentialMatch($0, $1, tolerance: tolerance, scale: scale) }
}

func differentialMatch(_ portable: [Float], _ reference: [Float], tolerance: Double) -> Bool {
    differentialMatch(portable.map(Double.init), reference.map(Double.init), tolerance: tolerance)
}

/// Tolerances relative to the result magnitude; both sides differ only by rounding.
enum Tolerance {
    /// Results computed by the same few operations, possibly in a different order or with FMA.
    static let float: Double = 2e-6
    static let double: Double = 1e-14
    /// Results with long operation chains (inverses, transcendental functions).
    static let floatLoose: Double = 2e-4
    static let doubleLoose: Double = 5e-12
}
#endif
