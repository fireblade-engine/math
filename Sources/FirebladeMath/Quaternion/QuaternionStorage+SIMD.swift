//
//  QuaternionStorage+SIMD.swift
//
//
//  Created by Christian Treffs on 06.09.19.
//

#if canImport(simd)
import struct simd.quaternion.simd_quatd
import struct simd.quaternion.simd_quatf
import func simd.simd_quaternion

extension simd_quatf: QuaternionStorageProtocol {
    public init(_ vector: SIMD4<Float>) {
        self = simd_quaternion(vector)
    }

    public init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
        self.init(ix: x, iy: y, iz: z, r: w)
    }

    @inlinable public var x: Float {
        get { return imag.x }
        set { imag.x = newValue }
    }

    @inlinable public var y: Float {
        get { return imag.y }
        set { imag.y = newValue }
    }

    @inlinable public var z: Float {
        get { return imag.z }
        set { imag.z = newValue }
    }

    @inlinable public var w: Float {
        get { return real }
        set { real = newValue }
    }

    public __consuming func makeIterator() -> IndexingIterator<[Float]> {
        return [x, y, z, w].makeIterator()
    }
}

extension simd_quatd: QuaternionStorageProtocol {
    public init(_ vector: SIMD4<Double>) {
        self = simd_quaternion(vector)
    }

    public init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
        self.init(ix: x, iy: y, iz: z, r: w)
    }

    @inlinable public var x: Double {
        get { return imag.x }
        set { imag.x = newValue }
    }

    @inlinable public var y: Double {
        get { return imag.y }
        set { imag.y = newValue }
    }

    @inlinable public var z: Double {
        get { return imag.z }
        set { imag.z = newValue }
    }

    @inlinable public var w: Double {
        get { return real }
        set { real = newValue }
    }

    public __consuming func makeIterator() -> IndexingIterator<[Double]> {
        return [x, y, z, w].makeIterator()
    }
}

#endif
