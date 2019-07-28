//
//  Constants.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

public let kDegreeToRadians64 = Float64.pi / 180.0
public let kDegreeToRadians32 = Float32(kDegreeToRadians64)

public let kRadiansToDegree64: Float64 = 180.0 / Float64.pi
public let kRadiansToDegree32 = Float32(kRadiansToDegree64)

extension Float {
    public static let halfPi = Float(Double.halfPi)
}

extension Double {
    public static let halfPi: Double = .pi * 0.5
}
