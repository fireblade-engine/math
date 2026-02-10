public let kDegreeToRadians64 = Double.pi / 180.0
public let kDegreeToRadians32 = Float(kDegreeToRadians64)

public let kRadiansToDegree64: Double = 180.0 / Double.pi
public let kRadiansToDegree32 = Float(kRadiansToDegree64)

extension Float {
    public static let halfPi = Float(Double.halfPi)
}

extension Double {
    public static let halfPi: Double = .pi * 0.5
}
