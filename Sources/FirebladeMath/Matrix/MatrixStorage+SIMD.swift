#if FRB_MATH_USE_SIMD
import struct simd.matrix.simd_double2x2
import struct simd.matrix.simd_double3x3
import struct simd.matrix.simd_double4x4
import struct simd.matrix.simd_float2x2
import struct simd.matrix.simd_float3x3
import struct simd.matrix.simd_float4x4

// MARK: - Storage2x2

extension simd_float2x2: Storage2x2Protocol, @retroactive @unchecked Sendable, @retroactive RandomAccessCollection, @retroactive MutableCollection, @retroactive RangeReplaceableCollection, @retroactive BidirectionalCollection, @retroactive Collection,
    @retroactive Sequence
{
    public typealias Element = Float
    public typealias Column = SIMD2<Float>
    public typealias Value = Float
    public typealias Storage3x3Ref = simd_float3x3
    public typealias Storage4x4Ref = simd_float4x4

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

extension simd_double2x2: Storage2x2Protocol, @retroactive @unchecked Sendable, @retroactive RandomAccessCollection, @retroactive MutableCollection, @retroactive RangeReplaceableCollection, @retroactive BidirectionalCollection, @retroactive Collection,
    @retroactive Sequence
{
    public typealias Element = Double
    public typealias Column = SIMD2<Double>
    public typealias Value = Double
    public typealias Storage3x3Ref = simd_double3x3
    public typealias Storage4x4Ref = simd_double4x4

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

extension simd_float3x3: Storage3x3Protocol, @retroactive @unchecked Sendable, @retroactive RandomAccessCollection, @retroactive MutableCollection, @retroactive RangeReplaceableCollection, @retroactive BidirectionalCollection, @retroactive Collection,
    @retroactive Sequence
{
    public typealias Element = Float
    public typealias Column = SIMD3<Float>
    public typealias Value = Float
    public typealias Storage2x2 = simd_float2x2
    public typealias Storage4x4 = simd_float4x4

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

extension simd_double3x3: Storage3x3Protocol, @retroactive @unchecked Sendable, @retroactive RandomAccessCollection, @retroactive MutableCollection, @retroactive RangeReplaceableCollection, @retroactive BidirectionalCollection, @retroactive Collection,
    @retroactive Sequence
{
    public typealias Element = Double
    public typealias Column = SIMD3<Double>
    public typealias Value = Double
    public typealias Storage2x2Ref = simd_double2x2
    public typealias Storage4x4Ref = simd_double4x4

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

extension simd_float4x4: Storage4x4Protocol, @retroactive @unchecked Sendable, @retroactive RandomAccessCollection, @retroactive MutableCollection, @retroactive RangeReplaceableCollection, @retroactive BidirectionalCollection, @retroactive Collection,
    @retroactive Sequence
{
    public typealias Element = Float
    public typealias Column = SIMD4<Float>
    public typealias Value = Float
    public typealias Storage2x2Ref = simd_float2x2
    public typealias Storage3x3Ref = simd_float3x3

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

extension simd_double4x4: Storage4x4Protocol, @retroactive @unchecked Sendable, @retroactive RandomAccessCollection, @retroactive MutableCollection, @retroactive RangeReplaceableCollection, @retroactive BidirectionalCollection, @retroactive Collection,
    @retroactive Sequence
{
    public typealias Element = Double
    public typealias Column = SIMD4<Double>
    public typealias Value = Double
    public typealias Storage2x2Ref = simd_double2x2
    public typealias Storage3x3Ref = simd_double3x3

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
