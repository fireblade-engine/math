//
//  angle.swift
//
//
//  Created by Christian Treffs on 09.09.19.
//

#if FRB_USE_SIMD
import func simd.simd_angle
#endif

/// Returns the angle by which a quaternion rotates.
public func angle(_ quat: Quat4f) -> Float {
    #if FRB_USE_SIMD
    return simd.simd_angle(quat.storage)
    #else
    return 2.0 * atan2(length(quat), quat.w)
    #endif
}

/// Returns the angle by which a quaternion rotates.
public func angle(_ quat: Quat4d) -> Double {
    #if FRB_USE_SIMD
    return simd.simd_angle(quat.storage)
    #else
    return 2.0 * atan2(length(quat), quat.w)
    #endif
}
