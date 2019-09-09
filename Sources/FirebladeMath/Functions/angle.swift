//
//  File.swift
//
//
//  Created by Christian Treffs on 09.09.19.
//

#if canImport(simd)
import func simd.simd_angle
#endif

/// Returns the angle by which a quaternion rotates.
public func angle(_ quat: Quat4f) -> Float {
    #if USE_SIMD
    return simd.simd_angle(quat.storage)
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

/// Returns the angle by which a quaternion rotates.
public func angle(_ quat: Quat4d) -> Double {
    #if USE_SIMD
    return simd.simd_angle(quat.storage)
    #else
    fatalError("implementation missing \(#function)")
    #endif
}
