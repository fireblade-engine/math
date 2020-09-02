//
//  conjugate.swift
//
//
//  Created by Christian Treffs on 09.09.19.
//

#if FRB_MATH_USE_SIMD
import func simd.simd_conjugate
#endif

public func conjugate(_ quat: Quat4f) -> Quat4f {
    #if FRB_MATH_USE_SIMD
    return Quat4f(storage: simd.simd_conjugate(quat.storage))
    #else
    return Quat4f(Vec4f(quat) * Vec4f(-1, -1, -1, 1))
    #endif
}

public func conjugate(_ quat: Quat4d) -> Quat4d {
    #if FRB_MATH_USE_SIMD
    return Quat4d(storage: simd.simd_conjugate(quat.storage))
    #else
    return Quat4d(Vec4d(quat) * Vec4d(-1, -1, -1, 1))
    #endif
}
