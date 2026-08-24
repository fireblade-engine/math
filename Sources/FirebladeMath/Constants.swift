/// Factor to convert degrees to radians (Double).
@inlinable public var kDegreeToRadians64: Double {
    Double.pi / 180.0
}

/// Factor to convert degrees to radians (Float).
@inlinable public var kDegreeToRadians32: Float {
    Float(Double.pi / 180.0)
}

/// Factor to convert radians to degrees (Double).
@inlinable public var kRadiansToDegree64: Double {
    180.0 / Double.pi
}

/// Factor to convert radians to degrees (Float).
@inlinable public var kRadiansToDegree32: Float {
    Float(180.0 / Double.pi)
}

/// Extension to add constants to Float.
extension Float {
    /// Half of Pi (π/2).
    @inlinable public static var halfPi: Float {
        Float.pi * 0.5
    }
}

/// Extension to add constants to Double.
extension Double {
    /// Half of Pi (π/2).
    @inlinable public static var halfPi: Double {
        Double.pi * 0.5
    }
}
