//
//  QuaternionStorage+SIMD.swift
//
//
//  Created by Christian Treffs on 06.09.19.
//

#if FRB_MATH_USE_SIMD
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
        get { imag.x }
        set { imag.x = newValue }
    }

    @inlinable public var y: Float {
        get { imag.y }
        set { imag.y = newValue }
    }

    @inlinable public var z: Float {
        get { imag.z }
        set { imag.z = newValue }
    }

    @inlinable public var w: Float {
        get { real }
        set { real = newValue }
    }

    public __consuming func makeIterator() -> IndexingIterator<[Float]> {
        [x, y, z, w].makeIterator()
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
        get { imag.x }
        set { imag.x = newValue }
    }

    @inlinable public var y: Double {
        get { imag.y }
        set { imag.y = newValue }
    }

    @inlinable public var z: Double {
        get { imag.z }
        set { imag.z = newValue }
    }

    @inlinable public var w: Double {
        get { real }
        set { real = newValue }
    }

    public __consuming func makeIterator() -> IndexingIterator<[Double]> {
        [x, y, z, w].makeIterator()
    }
}

#endif
