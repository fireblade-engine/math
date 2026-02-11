#if FRB_MATH_USE_SIMD
import struct simd.quaternion.simd_quatd
import struct simd.quaternion.simd_quatf
import func simd.simd_quaternion

/// Conformance to quaternion storage protocol.
extension simd_quatf: QuaternionStorageProtocol, @retroactive Sequence {
    /// Creates a new quaternion from a 4D vector.
    /// - Parameter vector: The vector [x, y, z, w].
    public init(_ vector: SIMD4<Float>) {
        self = simd_quaternion(vector)
    }

    /// Creates a new quaternion from its components.
    /// - Parameters:
    ///   - x: The x component of the imaginary part.
    ///   - y: The y component of the imaginary part.
    ///   - z: The z component of the imaginary part.
    ///   - w: The real component.
    public init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
        self.init(ix: x, iy: y, iz: z, r: w)
    }

    /// The x component of the imaginary part.
    @inlinable public var x: Float {
        get { imag.x }
        set { imag.x = newValue }
    }

    /// The y component of the imaginary part.
    @inlinable public var y: Float {
        get { imag.y }
        set { imag.y = newValue }
    }

    /// The z component of the imaginary part.
    @inlinable public var z: Float {
        get { imag.z }
        set { imag.z = newValue }
    }

    /// The real component.
    @inlinable public var w: Float {
        get { real }
        set { real = newValue }
    }

    /// Creates an iterator over the components of the quaternion.
    public func makeIterator() -> IndexingIterator<[Float]> {
        [x, y, z, w].makeIterator()
    }
}

/// Conformance to quaternion storage protocol.
extension simd_quatd: QuaternionStorageProtocol, @retroactive Sequence {
    /// Creates a new quaternion from a 4D vector.
    /// - Parameter vector: The vector [x, y, z, w].
    public init(_ vector: SIMD4<Double>) {
        self = simd_quaternion(vector)
    }

    /// Creates a new quaternion from its components.
    /// - Parameters:
    ///   - x: The x component of the imaginary part.
    ///   - y: The y component of the imaginary part.
    ///   - z: The z component of the imaginary part.
    ///   - w: The real component.
    public init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
        self.init(ix: x, iy: y, iz: z, r: w)
    }

    /// The x component of the imaginary part.
    @inlinable public var x: Double {
        get { imag.x }
        set { imag.x = newValue }
    }

    /// The y component of the imaginary part.
    @inlinable public var y: Double {
        get { imag.y }
        set { imag.y = newValue }
    }

    /// The z component of the imaginary part.
    @inlinable public var z: Double {
        get { imag.z }
        set { imag.z = newValue }
    }

    /// The real component.
    @inlinable public var w: Double {
        get { real }
        set { real = newValue }
    }

    /// Creates an iterator over the components of the quaternion.
    public func makeIterator() -> IndexingIterator<[Double]> {
        [x, y, z, w].makeIterator()
    }
}

#endif