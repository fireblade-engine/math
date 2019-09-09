//
//  File.swift
//
//
//  Created by Christian Treffs on 09.09.19.
//

#if canImport(simd)
import func simd.simd_conjugate
#endif

public func conjugate(_ quat: Quat4f) -> Quat4f {
    #if USE_SIMD
    return Quat4f(storage: simd.simd_conjugate(quat.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func conjugate(_ quat: Quat4d) -> Quat4d {
    #if USE_SIMD
    return Quat4d(storage: simd.simd_conjugate(quat.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}
