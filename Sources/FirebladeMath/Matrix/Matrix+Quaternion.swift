//
//  Matrix+Quaternion.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 27.08.19.
//

#if canImport(simd)
import func simd.simd_quaternion
import struct simd.simd_float4x4
#endif

extension Mat4x4f {
    /// Creates a new matrix from the specified quarternion.
    /// Quaternion will be normalized.
    public init(orientation quaternion: Quat4f) {
        #if USE_SIMD
        self.init(storage: simd_float4x4(quaternion.normalized.storage))
        #else
        fatalError("not implemented yet \(#function)")
        #endif
    }

    /// Construct a quaternion from a 4x4 rotation `matrix`.
    ///
    /// The last row and column of the matrix are ignored. This
    /// function is equivalent to calling simd_quaternion with the upper-left 3x3
    /// submatrix.
    @inlinable public var quaternion: Quat4f {
        #if USE_SIMD
        return Quat4f(storage: simd.simd_quaternion(self.storage))
        #else
        fatalError("not implemented yet \(#function)")
        #endif
    }
}
