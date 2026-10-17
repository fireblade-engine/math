//
//  ReferenceRegistry.swift
//  FirebladeMathTests
//

// Infrastructure for registering functions in the reference-value tests.
// The registrations themselves are in ReferenceFunctions.swift.

import FirebladeMath

// MARK: - Inputs

/// The inputs a function argument is drawn from.
enum InputDomain {
    /// Every scalar uniformly from the range.
    case uniform(ClosedRange<Double>)
    /// Every scalar log-uniformly from the (positive) range.
    case logUniform(ClosedRange<Double>)
    /// A unit vector (scalar count = dimension).
    case unitVector
    /// A unit quaternion [x, y, z, w].
    case unitQuaternion
    /// A rotation matrix (3x3 or 4x4, by scalar count).
    case rotationMatrix
    /// A matrix with a strengthened diagonal, safely invertible.
    case wellConditionedMatrix

    static let standard: InputDomain = .uniform(-10...10)

    func generate(scalarCount: Int, using generator: inout ReferenceGenerator) -> [Double] {
        switch self {
        case let .uniform(range):
            return (0..<scalarCount).map { _ in generator.next(in: range) }
        case let .logUniform(range):
            let logRange = Foundation_log(range.lowerBound)...Foundation_log(range.upperBound)
            return (0..<scalarCount).map { _ in Foundation_exp(generator.next(in: logRange)) }
        case .unitVector:
            return normalized((0..<scalarCount).map { _ in generator.next(in: -1...1) })
        case .unitQuaternion:
            return normalized((0..<4).map { _ in generator.next(in: -1...1) })
        case .rotationMatrix:
            let q = normalized((0..<4).map { _ in generator.next(in: -1...1) })
            let rotation = Mat3x3d.rotation(fromUnitQuaternion: q)
            if scalarCount == 9 { return rotation }
            return [rotation[0], rotation[1], rotation[2], 0,
                    rotation[3], rotation[4], rotation[5], 0,
                    rotation[6], rotation[7], rotation[8], 0,
                    0, 0, 0, 1]
        case .wellConditionedMatrix:
            let dimension = Int(Double(scalarCount).squareRoot())
            var values = (0..<scalarCount).map { _ in generator.next(in: -2...2) }
            for index in stride(from: 0, to: scalarCount, by: dimension + 1) {
                values[index] += 6
            }
            return values
        }
    }

    private func normalized(_ values: [Double]) -> [Double] {
        let length = values.reduce(0) { $0 + $1 * $1 }.squareRoot()
        return values.map { $0 / length }
    }
}

// Platform-independent exp/log for input generation (inputs are stored, so only the
// generating platform calls these).
private func Foundation_log(_ x: Double) -> Double { FirebladeMath.log(x) }
private func Foundation_exp(_ x: Double) -> Double { FirebladeMath.exp(x) }

private extension Mat3x3d {
    /// Column-major rotation matrix of a unit quaternion [x, y, z, w].
    static func rotation(fromUnitQuaternion q: [Double]) -> [Double] {
        let (x, y, z, w) = (q[0], q[1], q[2], q[3])
        return [1 - 2 * (y * y + z * z), 2 * (x * y + z * w), 2 * (x * z - y * w),
                2 * (x * y - z * w), 1 - 2 * (x * x + z * z), 2 * (y * z + x * w),
                2 * (x * z + y * w), 2 * (y * z - x * w), 1 - 2 * (x * x + y * y)]
    }
}

/// SplitMix64: deterministic input generation.
struct ReferenceGenerator {
    var state: UInt64

    mutating func next(in range: ClosedRange<Double>) -> Double {
        state &+= 0x9E37_79B9_7F4A_7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58_476D_1CE4_E5B9
        z = (z ^ (z >> 27)) &* 0x94D0_49BB_1331_11EB
        z ^= z >> 31
        let unit = Double(z >> 11) * 0x1p-53 // no `1 << 53`: Int is 32-bit on wasm32
        return range.lowerBound + unit * (range.upperBound - range.lowerBound)
    }
}

/// Special scalar inputs added to every scalar-only function when `specials` is set.
let referenceSpecialScalars: [Double] = [.nan, .infinity, -.infinity, 0, -0.0, 1, -1, 0.5, -0.5, 1e-30, -1e-30, 1e30, -1e30]

// MARK: - Registered functions

struct ReferenceFunction {
    let key: String
    let accuracy: ReferenceAccuracy
    let singlePrecisionResult: Bool
    /// Scalar count of each argument.
    let argumentScalarCounts: [Int]
    let domains: [InputDomain]
    let includeSpecials: Bool
    /// Rounds raw inputs to the argument types (e.g. Float), so the stored inputs are exactly
    /// what every platform evaluates.
    let roundInputs: ([Double]) -> [Double]
    let evaluate: ([Double]) -> [Double]

    /// Number of random cases per function (special cases come on top).
    static let randomCaseCount = 24

    /// Deterministic inputs for this function, rounded to the argument types.
    func generateInputs(seed: UInt64) -> [[Double]] {
        var generator = ReferenceGenerator(state: seed)
        var cases: [[Double]] = (0..<Self.randomCaseCount).map { _ in
            zip(argumentScalarCounts, domains).flatMap { count, domain in domain.generate(scalarCount: count, using: &generator) }
        }
        if includeSpecials {
            let base = cases[0]
            for special in referenceSpecialScalars {
                cases.append([Double](repeating: special, count: base.count))
                if base.count > 1 {
                    for position in base.indices {
                        var mixed = base
                        mixed[position] = special
                        cases.append(mixed)
                    }
                }
            }
        }
        return cases.map(roundInputs)
    }
}

/// Collects function registrations; see ReferenceFunctions.swift.
struct ReferenceRegistry {
    private(set) var functions: [ReferenceFunction] = []

    private mutating func register(
        _ key: String,
        _ accuracy: ReferenceAccuracy,
        result: (some ReferenceValue).Type,
        arguments: [any ReferenceValue.Type],
        domains: [InputDomain],
        specials: Bool,
        evaluate: @escaping ([Double]) -> [Double]
    ) {
        precondition(domains.count == arguments.count, "\(key): one domain per argument")
        let counts = arguments.map { $0.scalarCount }
        let round: ([Double]) -> [Double] = { inputs in
            zip(arguments, Self.split(inputs, counts)).flatMap { type, slice in type.init(referenceScalars: slice).referenceScalars }
        }
        functions.append(ReferenceFunction(
            key: key,
            accuracy: accuracy,
            singlePrecisionResult: result.isSinglePrecision,
            argumentScalarCounts: arguments.map { $0.scalarCount },
            domains: domains,
            includeSpecials: specials,
            roundInputs: round,
            evaluate: evaluate
        ))
    }

    private static func split(_ inputs: [Double], _ counts: [Int]) -> [ArraySlice<Double>] {
        var slices: [ArraySlice<Double>] = []
        var start = inputs.startIndex
        for count in counts {
            slices.append(inputs[start..<start + count])
            start += count
        }
        return slices
    }

    mutating func add<A: ReferenceValue, R: ReferenceValue>(
        _ key: String, _ accuracy: ReferenceAccuracy, _ a: InputDomain = .standard, specials: Bool = false,
        _ function: @escaping (A) -> R
    ) {
        register(key, accuracy, result: R.self, arguments: [A.self], domains: [a], specials: specials) { inputs in
            function(A(referenceScalars: inputs[...])).referenceScalars
        }
    }

    mutating func add<A: ReferenceValue, B: ReferenceValue, R: ReferenceValue>(
        _ key: String, _ accuracy: ReferenceAccuracy, _ a: InputDomain = .standard, _ b: InputDomain = .standard,
        specials: Bool = false, _ function: @escaping (A, B) -> R
    ) {
        register(key, accuracy, result: R.self, arguments: [A.self, B.self], domains: [a, b], specials: specials) { inputs in
            let s = Self.split(inputs, [A.scalarCount, B.scalarCount])
            return function(A(referenceScalars: s[0]), B(referenceScalars: s[1])).referenceScalars
        }
    }

    mutating func add<A: ReferenceValue, B: ReferenceValue, C: ReferenceValue, R: ReferenceValue>(
        _ key: String, _ accuracy: ReferenceAccuracy,
        _ a: InputDomain = .standard, _ b: InputDomain = .standard, _ c: InputDomain = .standard,
        specials: Bool = false, _ function: @escaping (A, B, C) -> R
    ) {
        register(key, accuracy, result: R.self, arguments: [A.self, B.self, C.self], domains: [a, b, c], specials: specials) { inputs in
            let s = Self.split(inputs, [A.scalarCount, B.scalarCount, C.scalarCount])
            return function(A(referenceScalars: s[0]), B(referenceScalars: s[1]), C(referenceScalars: s[2])).referenceScalars
        }
    }

    mutating func add<A: ReferenceValue, B: ReferenceValue, C: ReferenceValue, D: ReferenceValue, R: ReferenceValue>(
        _ key: String, _ accuracy: ReferenceAccuracy,
        _ a: InputDomain, _ b: InputDomain, _ c: InputDomain, _ d: InputDomain,
        _ function: @escaping (A, B, C, D) -> R
    ) {
        register(key, accuracy, result: R.self, arguments: [A.self, B.self, C.self, D.self], domains: [a, b, c, d], specials: false) { inputs in
            let s = Self.split(inputs, [A.scalarCount, B.scalarCount, C.scalarCount, D.scalarCount])
            let a = A(referenceScalars: s[0]), b = B(referenceScalars: s[1])
            let c = C(referenceScalars: s[2]), d = D(referenceScalars: s[3])
            return function(a, b, c, d).referenceScalars
        }
    }

    // swiftlint:disable:next function_parameter_count
    mutating func add<A: ReferenceValue, B: ReferenceValue, C: ReferenceValue, D: ReferenceValue, E: ReferenceValue, F: ReferenceValue, R: ReferenceValue>(
        _ key: String, _ accuracy: ReferenceAccuracy,
        _ a: InputDomain, _ b: InputDomain, _ c: InputDomain, _ d: InputDomain, _ e: InputDomain, _ f: InputDomain,
        _ function: @escaping (A, B, C, D, E, F) -> R
    ) {
        let types: [any ReferenceValue.Type] = [A.self, B.self, C.self, D.self, E.self, F.self]
        register(key, accuracy, result: R.self, arguments: types, domains: [a, b, c, d, e, f], specials: false) { inputs in
            let s = Self.split(inputs, types.map { $0.scalarCount })
            let a = A(referenceScalars: s[0]), b = B(referenceScalars: s[1]), c = C(referenceScalars: s[2])
            let d = D(referenceScalars: s[3]), e = E(referenceScalars: s[4]), f = F(referenceScalars: s[5])
            return function(a, b, c, d, e, f).referenceScalars
        }
    }
}
