//
//  File.swift
//
//
//  Created by Christian Treffs on 09.09.19.
//

#if canImport(simd)
import func simd.simd_inverse
#endif

public func inverse(_ quat: Quat4f) -> Quat4f {
    #if USE_SIMD
    return Quat4f(storage: simd_inverse(quat.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}

public func inverse(_ quat: Quat4d) -> Quat4d {
    #if USE_SIMD
    return Quat4d(storage: simd_inverse(quat.storage))
    #else
    fatalError("implementation missing \(#function)")
    #endif
}
