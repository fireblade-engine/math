#if FRB_MATH_USE_SIMD
import struct simd.matrix.simd_double2x2
import struct simd.matrix.simd_double3x3
import struct simd.matrix.simd_double4x4
import struct simd.matrix.simd_float2x2
import struct simd.matrix.simd_float3x3
import struct simd.matrix.simd_float4x4

// MARK: - Storage2x2

/// Conformance to matrix storage protocols.
extension simd_float2x2: Storage2x2Protocol, @retroactive @unchecked Sendable, @retroactive RandomAccessCollection, @retroactive MutableCollection, @retroactive RangeReplaceableCollection,
    @retroactive BidirectionalCollection, @retroactive Collection,
    @retroactive Sequence {
    /// The element type of the matrix storage.
    public typealias Element = Float
    /// The column vector type of the matrix.
    public typealias Column = SIMD2<Float>
    /// The scalar value type of the matrix.
    public typealias Value = Float
    /// Reference to 3x3 storage type.
    public typealias Storage3x3Ref = simd_float3x3
    /// Reference to 4x4 storage type.
    public typealias Storage4x4Ref = simd_float4x4

    /// Accesses the value at the specified flat index in column-major order.
    /// - Parameter index: The flat index.
    public subscript(index: Int) -> Float {
        get {
            let (col, row) = columnRow(index: index, width: 2)
            switch col {
            case 0:
                return columns.0[row]

            case 1:
                return columns.1[row]

            default:
                fatalError("Column out of bounds \(col)")
            }
        }
        set {
            let (col, row) = columnRow(index: index, width: 2)
            switch col {
            case 0:
                columns.0[row] = newValue

            case 1:
                columns.1[row] = newValue

            default:
                fatalError("Column out of bounds \(col)")
            }
        }
    }
}

/// Conformance to matrix storage protocols.
extension simd_double2x2: Storage2x2Protocol, @retroactive @unchecked Sendable, @retroactive RandomAccessCollection, @retroactive MutableCollection, @retroactive RangeReplaceableCollection,
    @retroactive BidirectionalCollection, @retroactive Collection,
    @retroactive Sequence {
    /// The element type of the matrix storage.
    public typealias Element = Double
    /// The column vector type of the matrix.
    public typealias Column = SIMD2<Double>
    /// The scalar value type of the matrix.
    public typealias Value = Double
    /// Reference to 3x3 storage type.
    public typealias Storage3x3Ref = simd_double3x3
    /// Reference to 4x4 storage type.
    public typealias Storage4x4Ref = simd_double4x4

    /// Accesses the value at the specified flat index in column-major order.
    /// - Parameter index: The flat index.
    public subscript(index: Int) -> Double {
        get {
            let (col, row) = columnRow(index: index, width: 2)
            switch col {
            case 0:
                return columns.0[row]

            case 1:
                return columns.1[row]

            default:
                fatalError("Column out of bounds \(col)")
            }
        }
        set {
            let (col, row) = columnRow(index: index, width: 2)
            switch col {
            case 0:
                columns.0[row] = newValue

            case 1:
                columns.1[row] = newValue

            default:
                fatalError("Column out of bounds \(col)")
            }
        }
    }
}

// MARK: - Storage3x3

/// Conformance to matrix storage protocols.
extension simd_float3x3: Storage3x3Protocol, @retroactive @unchecked Sendable, @retroactive RandomAccessCollection, @retroactive MutableCollection, @retroactive RangeReplaceableCollection,
    @retroactive BidirectionalCollection, @retroactive Collection,
    @retroactive Sequence {
    /// The element type of the matrix storage.
    public typealias Element = Float
    /// The column vector type of the matrix.
    public typealias Column = SIMD3<Float>
    /// The scalar value type of the matrix.
    public typealias Value = Float
    /// Reference to 2x2 storage type.
    public typealias Storage2x2 = simd_float2x2
    /// Reference to 4x4 storage type.
    public typealias Storage4x4 = simd_float4x4

    /// Accesses the value at the specified flat index in column-major order.
    /// - Parameter index: The flat index.
    public subscript(index: Int) -> Float {
        get {
            let (col, row) = columnRow(index: index, width: 3)
            switch col {
            case 0:
                return columns.0[row]

            case 1:
                return columns.1[row]

            case 2:
                return columns.2[row]

            default:
                fatalError("Column out of bounds \(col)")
            }
        }
        set {
            let (col, row) = columnRow(index: index, width: 3)
            switch col {
            case 0:
                columns.0[row] = newValue

            case 1:
                columns.1[row] = newValue

            case 2:
                columns.2[row] = newValue

            default:
                fatalError("Column out of bounds \(col)")
            }
        }
    }
}

/// Conformance to matrix storage protocols.
extension simd_double3x3: Storage3x3Protocol, @retroactive @unchecked Sendable, @retroactive RandomAccessCollection, @retroactive MutableCollection, @retroactive RangeReplaceableCollection,
    @retroactive BidirectionalCollection, @retroactive Collection,
    @retroactive Sequence {
    /// The element type of the matrix storage.
    public typealias Element = Double
    /// The column vector type of the matrix.
    public typealias Column = SIMD3<Double>
    /// The scalar value type of the matrix.
    public typealias Value = Double
    /// Reference to 2x2 storage type.
    public typealias Storage2x2Ref = simd_double2x2
    /// Reference to 4x4 storage type.
    public typealias Storage4x4Ref = simd_double4x4

    /// Accesses the value at the specified flat index in column-major order.
    /// - Parameter index: The flat index.
    public subscript(index: Int) -> Double {
        get {
            let (col, row) = columnRow(index: index, width: 3)
            switch col {
            case 0:
                return columns.0[row]

            case 1:
                return columns.1[row]

            case 2:
                return columns.2[row]

            default:
                fatalError("Column out of bounds \(col)")
            }
        }
        set {
            let (col, row) = columnRow(index: index, width: 3)
            switch col {
            case 0:
                columns.0[row] = newValue

            case 1:
                columns.1[row] = newValue

            case 2:
                columns.2[row] = newValue

            default:
                fatalError("Column out of bounds \(col)")
            }
        }
    }
}

// MARK: - Storage4x4

/// Conformance to matrix storage protocols.
extension simd_float4x4: Storage4x4Protocol, @retroactive @unchecked Sendable, @retroactive RandomAccessCollection, @retroactive MutableCollection, @retroactive RangeReplaceableCollection,
    @retroactive BidirectionalCollection, @retroactive Collection,
    @retroactive Sequence {
    /// The element type of the matrix storage.
    public typealias Element = Float
    /// The column vector type of the matrix.
    public typealias Column = SIMD4<Float>
    /// The scalar value type of the matrix.
    public typealias Value = Float
    /// Reference to 2x2 storage type.
    public typealias Storage2x2Ref = simd_float2x2
    /// Reference to 3x3 storage type.
    public typealias Storage3x3Ref = simd_float3x3

    /// Accesses the value at the specified flat index in column-major order.
    /// - Parameter index: The flat index.
    public subscript(index: Int) -> Float {
        get {
            let (col, row) = columnRow(index: index, width: 4)
            switch col {
            case 0:
                return columns.0[row]

            case 1:
                return columns.1[row]

            case 2:
                return columns.2[row]

            case 3:
                return columns.3[row]

            default:
                fatalError("Column out of bounds \(col)")
            }
        }
        set {
            let (col, row) = columnRow(index: index, width: 4)
            switch col {
            case 0:
                columns.0[row] = newValue

            case 1:
                columns.1[row] = newValue

            case 2:
                columns.2[row] = newValue

            case 3:
                columns.3[row] = newValue

            default:
                fatalError("Column out of bounds \(col)")
            }
        }
    }
}

/// Conformance to matrix storage protocols.
extension simd_double4x4: Storage4x4Protocol, @retroactive @unchecked Sendable, @retroactive RandomAccessCollection, @retroactive MutableCollection, @retroactive RangeReplaceableCollection,
    @retroactive BidirectionalCollection, @retroactive Collection,
    @retroactive Sequence {
    /// The element type of the matrix storage.
    public typealias Element = Double
    /// The column vector type of the matrix.
    public typealias Column = SIMD4<Double>
    /// The scalar value type of the matrix.
    public typealias Value = Double
    /// Reference to 2x2 storage type.
    public typealias Storage2x2Ref = simd_double2x2
    /// Reference to 3x3 storage type.
    public typealias Storage3x3Ref = simd_double3x3

    /// Accesses the value at the specified flat index in column-major order.
    /// - Parameter index: The flat index.
    public subscript(index: Int) -> Double {
        get {
            let (col, row) = columnRow(index: index, width: 4)
            switch col {
            case 0:
                return columns.0[row]

            case 1:
                return columns.1[row]

            case 2:
                return columns.2[row]

            case 3:
                return columns.3[row]

            default:
                fatalError("Column out of bounds \(col)")
            }
        }
        set {
            let (col, row) = columnRow(index: index, width: 4)
            switch col {
            case 0:
                columns.0[row] = newValue

            case 1:
                columns.1[row] = newValue

            case 2:
                columns.2[row] = newValue

            case 3:
                columns.3[row] = newValue

            default:
                fatalError("Column out of bounds \(col)")
            }
        }
    }
}

#endif
