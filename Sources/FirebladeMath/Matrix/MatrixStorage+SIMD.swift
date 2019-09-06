//
//  File.swift
//
//
//  Created by Christian Treffs on 06.09.19.
//

#if canImport(simd)
import struct simd.matrix.simd_float4x4
import struct simd.matrix.simd_double4x4
import struct simd.matrix.simd_float3x3
import struct simd.matrix.simd_double3x3
#endif

#if USE_SIMD
extension simd_float4x4: Storage4x4Protocol {
    public typealias Column = SIMD4<Float>
    public typealias Value = Float
    public typealias _Storage3x3 = simd_float3x3

    public __consuming func makeIterator() -> IndexingIterator<[Value]> {
        return [columns.0, columns.1, columns.2, columns.3].flatMap { $0 }.makeIterator()
    }
}

extension simd_double4x4: Storage4x4Protocol {
    public typealias Column = SIMD4<Double>
    public typealias Value = Double
    public typealias _Storage3x3 = simd_double3x3

    public __consuming func makeIterator() -> IndexingIterator<[Value]> {
        return [columns.0, columns.1, columns.2, columns.3].flatMap { $0 }.makeIterator()
    }
}

extension simd_float3x3: Storage3x3Protocol {
    public typealias Column = SIMD3<Float>
    public typealias Value = Float
    public typealias _Storage4x4 = simd_float4x4

    public __consuming func makeIterator() -> IndexingIterator<[Value]> {
        return [columns.0, columns.1, columns.2].flatMap { $0 }.makeIterator()
    }
}

extension simd_double3x3: Storage3x3Protocol {
    public typealias Column = SIMD3<Double>
    public typealias Value = Double
    public typealias _Storage4x4 = simd_double4x4

    public __consuming func makeIterator() -> IndexingIterator<[Value]> {
        return [columns.0, columns.1, columns.2].flatMap { $0 }.makeIterator()
    }
}

#endif
