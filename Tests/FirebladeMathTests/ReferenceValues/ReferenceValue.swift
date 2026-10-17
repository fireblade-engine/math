//
//  ReferenceValue.swift
//  FirebladeMathTests
//

// Cross-platform reference-value tests: every public FirebladeMath function is evaluated on a
// fixed set of inputs, and the results must match values recorded once on the reference
// platform (macOS) on every platform that runs the tests, up to rounding.
//
// This file maps FirebladeMath's types to flat lists of Doubles (every Float is exactly
// representable as a Double) and defines how results are compared.

import FirebladeMath

// MARK: - Encoding

protocol ReferenceValue {
    /// Number of scalars the value is encoded as.
    static var scalarCount: Int { get }
    /// Whether the value is made of single-precision scalars (affects tolerances).
    static var isSinglePrecision: Bool { get }
    init(referenceScalars: ArraySlice<Double>)
    var referenceScalars: [Double] { get }
}

extension Float: ReferenceValue {
    static var scalarCount: Int { 1 }
    static var isSinglePrecision: Bool { true }
    init(referenceScalars: ArraySlice<Double>) { self.init(referenceScalars[referenceScalars.startIndex]) }
    var referenceScalars: [Double] { [Double(self)] }
}

extension Double: ReferenceValue {
    static var scalarCount: Int { 1 }
    static var isSinglePrecision: Bool { false }
    init(referenceScalars: ArraySlice<Double>) { self = referenceScalars[referenceScalars.startIndex] }
    var referenceScalars: [Double] { [self] }
}

extension Bool: ReferenceValue {
    static var scalarCount: Int { 1 }
    static var isSinglePrecision: Bool { false }
    init(referenceScalars: ArraySlice<Double>) { self = referenceScalars[referenceScalars.startIndex] != 0 }
    var referenceScalars: [Double] { [self ? 1 : 0] }
}

extension SIMD2: ReferenceValue where Scalar: BinaryFloatingPoint {
    static var scalarCount: Int { 2 }
    static var isSinglePrecision: Bool { Scalar.self == Float.self }
    init(referenceScalars: ArraySlice<Double>) { self.init(referenceScalars.map { Scalar($0) }) }
    var referenceScalars: [Double] { [Double(x), Double(y)] }
}

extension SIMD3: ReferenceValue where Scalar: BinaryFloatingPoint {
    static var scalarCount: Int { 3 }
    static var isSinglePrecision: Bool { Scalar.self == Float.self }
    init(referenceScalars: ArraySlice<Double>) { self.init(referenceScalars.map { Scalar($0) }) }
    var referenceScalars: [Double] { [Double(x), Double(y), Double(z)] }
}

extension SIMD4: ReferenceValue where Scalar: BinaryFloatingPoint {
    static var scalarCount: Int { 4 }
    static var isSinglePrecision: Bool { Scalar.self == Float.self }
    init(referenceScalars: ArraySlice<Double>) { self.init(referenceScalars.map { Scalar($0) }) }
    var referenceScalars: [Double] { [Double(x), Double(y), Double(z), Double(w)] }
}

extension Matrix2x2: ReferenceValue {
    static var scalarCount: Int { 4 }
    static var isSinglePrecision: Bool { Value.self == Float.self }
    init(referenceScalars: ArraySlice<Double>) { self.init(referenceScalars.map { Value($0) }) }
    var referenceScalars: [Double] { elements.map { Double($0) } }
}

extension Matrix3x3: ReferenceValue {
    static var scalarCount: Int { 9 }
    static var isSinglePrecision: Bool { Value.self == Float.self }
    init(referenceScalars: ArraySlice<Double>) { self.init(referenceScalars.map { Value($0) }) }
    var referenceScalars: [Double] { elements.map { Double($0) } }
}

extension Matrix4x4: ReferenceValue {
    static var scalarCount: Int { 16 }
    static var isSinglePrecision: Bool { Value.self == Float.self }
    init(referenceScalars: ArraySlice<Double>) { self.init(referenceScalars.map { Value($0) }) }
    var referenceScalars: [Double] { elements.map { Double($0) } }
}

extension Quaternion: ReferenceValue {
    static var scalarCount: Int { 4 }
    static var isSinglePrecision: Bool { Value.self == Float.self }

    init(referenceScalars: ArraySlice<Double>) {
        let values = Array(referenceScalars)
        self.init(Value(values[0]), Value(values[1]), Value(values[2]), Value(values[3]))
    }

    var referenceScalars: [Double] { [Double(x), Double(y), Double(z), Double(w)] }
}

// MARK: - Accuracy

/// How closely a platform's result must match the recorded reference.
///
/// Special values (NaN, infinities, the sign of zero) must always match exactly.
enum ReferenceAccuracy: CustomStringConvertible {
    /// Bit-identical: operations that IEEE 754 or the implementation fully determine
    /// (sqrt, floor, copysign, fmod, comparisons, sign flips, element moves, ...).
    case exact
    /// Within `ulps` units in the last place of the reference: single calls into the
    /// platform's C math library, whose implementations may differ by a few ulps.
    case libm(ulps: Double)
    /// Within a relative tolerance of the largest reference element: algorithms whose
    /// evaluation order differs between the simd and portable implementations, or that
    /// build on C math library calls.
    case composite(Composite)

    enum Composite {
        /// Sums of products (dot, cross, matrix and quaternion products): rounding error scales
        /// with the size of the products, not of the (possibly cancelled) result.
        case products
        /// Few operations (normalization, conversions).
        case tight
        /// Long operation chains or trigonometry (inverses, Euler angles, projections).
        case loose
    }

    func relativeTolerance(singlePrecision: Bool) -> Double {
        switch self {
        case .exact, .libm:
            return 0
        case .composite(.tight), .composite(.products):
            return singlePrecision ? 2e-6 : 1e-14
        case .composite(.loose):
            return singlePrecision ? 2e-4 : 5e-12
        }
    }

    var description: String {
        switch self {
        case .exact: return "exact"
        case let .libm(ulps): return "≤ \(ulps) ulp"
        case .composite(.products): return "rounding (products)"
        case .composite(.tight): return "rounding (tight)"
        case .composite(.loose): return "rounding (loose)"
        }
    }
}

// MARK: - Comparison

/// Returns nil if `actual` matches `expected`, otherwise a description of the first mismatch.
func referenceMismatch(
    inputs: [Double],
    actual: [Double],
    expected: [Double],
    accuracy: ReferenceAccuracy,
    singlePrecision: Bool
) -> String? {
    guard actual.count == expected.count else {
        return "expected \(expected.count) scalars, got \(actual.count)"
    }
    func largestMagnitude(_ values: [Double]) -> Double {
        values.filter(\.isFinite).map { Swift.abs($0) }.max() ?? 0
    }
    var scale = Swift.max(1, largestMagnitude(expected))
    if case .composite(.products) = accuracy {
        let largestInput = largestMagnitude(inputs)
        scale = Swift.max(scale, largestInput * largestInput)
    }
    for (index, (value, reference)) in zip(actual, expected).enumerated() {
        if let problem = scalarMismatch(value, reference, accuracy: accuracy, singlePrecision: singlePrecision, scale: scale) {
            return "scalar \(index): \(problem)"
        }
    }
    return nil
}

private func scalarMismatch(
    _ value: Double,
    _ reference: Double,
    accuracy: ReferenceAccuracy,
    singlePrecision: Bool,
    scale: Double
) -> String? {
    let describe = { "got \(value), expected \(reference)" }
    if value.isNaN || reference.isNaN {
        return value.isNaN && reference.isNaN ? nil : describe()
    }
    if value.isInfinite || reference.isInfinite {
        return value == reference ? nil : describe()
    }
    if value == 0, reference == 0 {
        return value.sign == reference.sign ? nil : describe() + " (sign of zero)"
    }
    switch accuracy {
    case .exact:
        return value.bitPattern == reference.bitPattern ? nil : describe()
    case let .libm(ulps):
        let ulp = singlePrecision ? Double(Float(reference).ulp) : reference.ulp
        return Swift.abs(value - reference) <= ulps * ulp ? nil : describe() + " (\(Swift.abs(value - reference) / ulp) ulp)"
    case .composite:
        let tolerance = accuracy.relativeTolerance(singlePrecision: singlePrecision) * scale
        return Swift.abs(value - reference) <= tolerance ? nil : describe() + " (tolerance \(tolerance))"
    }
}
