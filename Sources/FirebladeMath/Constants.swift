/// Factor to convert degrees to radians (Double).
public let kDegreeToRadians64 = Double.pi / 180.0
/// Factor to convert degrees to radians (Float).
public let kDegreeToRadians32 = Float(kDegreeToRadians64)

/// Factor to convert radians to degrees (Double).
public let kRadiansToDegree64: Double = 180.0 / Double.pi
/// Factor to convert radians to degrees (Float).
public let kRadiansToDegree32 = Float(kRadiansToDegree64)

extension Float {
    /// Half of Pi (π/2).
    public static let halfPi = Float(Double.halfPi)
}

extension Double {
    /// Half of Pi (π/2).
    public static let halfPi: Double = .pi * 0.5
}