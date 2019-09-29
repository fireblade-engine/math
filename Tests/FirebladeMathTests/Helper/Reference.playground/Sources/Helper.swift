public let kDegreeToRadians64 = Float64.pi / 180.0
public let kDegreeToRadians32 = Float32(kDegreeToRadians64)

public let kRadiansToDegree64: Float64 = 180.0 / Float64.pi
public let kRadiansToDegree32 = Float32(kRadiansToDegree64)

extension Float32 {
    public static let halfPi = Float32(Double.halfPi)
}

extension Float64 {
    public static let halfPi: Float64 = .pi * 0.5
}

/// Converts degress to radians.
///
/// - Parameter degrees: an angle (in degrees)
/// - Returns: the argument converted to radians.
public func radians(_ degrees: Float32) -> Float32 { return degrees * kDegreeToRadians32 }

/// Converts degress to radians.
///
/// - Parameter degrees: an angle (in degrees)
/// - Returns: the argument converted to radians.
public func radians(_ degrees: Float64) -> Float64 { return degrees * kDegreeToRadians64 }

public func rnd(_ count: Int, in range: ClosedRange<Float> = -1e-9...1e9) -> [Float] {
    return (0..<count).map { _ in Float.random(in: range) }
}

public func rndDecimal(_ count: Int, in range: ClosedRange<Int> = -10_000_000...10_000_000) -> [Float] {
    return (0..<count).map { _ in Float(Int.random(in: range)) }
}
