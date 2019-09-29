//
//  MatrixStorage+NO_SIMD.swift
//
//
//  Created by Christian Treffs on 06.09.19.
//

#if !USE_SIMD
// MARK: - Storage3x3
public struct Storage3x3<Value>: Storage3x3Protocol where Value: StorageScalar {
    public typealias Column = SIMD3<Value>
    public typealias _Storage4x4 = Storage4x4<Value>

    @usableFromInline var _column0: Column
    @usableFromInline var _column1: Column
    @usableFromInline var _column2: Column

    @inlinable public var columns: (Column, Column, Column) {
        return (_column0, _column1, _column2)
    }

    @inlinable public init(_ columns: [Column]) {
        precondition(columns.count == 3, "Storage needs exacty 3 column vectors")
        _column0 = columns[0]
        _column1 = columns[1]
        _column2 = columns[2]
    }

    @inlinable public init(diagonal: Column) {
        let zero: Value = 0
        _column0 = Column(diagonal.x, zero, zero)
        _column1 = Column(zero, diagonal.y, zero)
        _column2 = Column(zero, zero, diagonal.z)
    }

    public __consuming func makeIterator() -> IndexingIterator<[Value]> {
        return [_column0, _column1, _column2].flatMap { $0 }.makeIterator()
    }

    @inlinable public subscript(column: Int, row: Int) -> Value {
        get {
            switch column {
            case 0:
                return _column0[row]

            case 1:
                return _column1[row]

            case 2:
                return _column2[row]

            default:
                fatalError("column out of bounds \(column)")
            }
        }
        set {
            switch column {
            case 0:
                _column0[row] = newValue

            case 1:
                _column1[row] = newValue

            case 2:
                _column2[row] = newValue

            default:
                fatalError("column out of bounds \(column)")
            }
        }
    }

    public subscript(index: Int) -> Value {
        get {
            let (column, row) = columnRow(index: index, width: 3)
            return self[column, row]
        }
        set {
            let (column, row) = columnRow(index: index, width: 3)
            self[column, row] = newValue
        }
    }
}

extension Storage3x3: Equatable {
    public static func == (lhs: Storage3x3<Value>, rhs: Storage3x3<Value>) -> Bool {
        return lhs._column0 == rhs._column0 &&
            lhs._column1 == rhs._column1 &&
            lhs._column2 == rhs._column2
    }
}

// MARK: - Storage4x4
public struct Storage4x4<Value>: Storage4x4Protocol where Value: StorageScalar {
    public typealias Column = SIMD4<Value>
    public typealias _Storage3x3 = Storage3x3<Value>

    @usableFromInline var _column0: Column
    @usableFromInline var _column1: Column
    @usableFromInline var _column2: Column
    @usableFromInline var _column3: Column

    @inlinable public var columns: (Column, Column, Column, Column) {
        return (_column0, _column1, _column2, _column3)
    }

    @inlinable public init(_ columns: [Column]) {
        precondition(columns.count == 4, "Storage needs exacty 4 column vectors")
        _column0 = columns[0]
        _column1 = columns[1]
        _column2 = columns[2]
        _column3 = columns[3]
    }

    @inlinable public init(diagonal: Column) {
        let zero: Value = 0
        _column0 = Column(diagonal.x, zero, zero, zero)
        _column1 = Column(zero, diagonal.y, zero, zero)
        _column2 = Column(zero, zero, diagonal.z, zero)
        _column3 = Column(zero, zero, zero, diagonal.w)
    }

    public __consuming func makeIterator() -> IndexingIterator<[Value]> {
        return [_column0, _column1, _column2, _column3].flatMap { $0 }.makeIterator()
    }

    public subscript(column: Int, row: Int) -> Value {
        get {
            switch column {
            case 0:
                return _column0[row]

            case 1:
                return _column1[row]

            case 2:
                return _column2[row]

            case 3:
                return _column3[row]

            default:
                fatalError("column out of bounds \(column)")
            }
        }
        set {
            switch column {
            case 0:
                _column0[row] = newValue

            case 1:
                _column1[row] = newValue

            case 2:
                _column2[row] = newValue

            case 3:
                _column3[row] = newValue

            default:
                fatalError("column out of bounds \(column)")
            }
        }
    }

    public subscript(index: Int) -> Value {
        get {
            let (column, row) = columnRow(index: index, width: 4)
            return self[column, row]
        }
        set {
            let (column, row) = columnRow(index: index, width: 4)
            self[column, row] = newValue
        }
    }
}

extension Storage4x4: Equatable {
    public static func == (lhs: Storage4x4<Value>, rhs: Storage4x4<Value>) -> Bool {
        return lhs._column0 == rhs._column0 &&
            lhs._column1 == rhs._column1 &&
            lhs._column2 == rhs._column2 &&
            lhs._column3 == rhs._column3
    }
}
#endif
