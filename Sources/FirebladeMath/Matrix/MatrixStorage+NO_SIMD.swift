//
//  MatrixStorage+NO_SIMD.swift
//
//
//  Created by Christian Treffs on 06.09.19.
//

#if !FRB_MATH_USE_SIMD
// MARK: - Storage3x3
public struct Storage3x3<Value>: Storage3x3Protocol where Value: StorageScalar {
    public typealias Column = SIMD3<Value>
    public typealias Storage4x4Ref = Storage4x4<Value>

    @usableFromInline var column0: Column
    @usableFromInline var column1: Column
    @usableFromInline var column2: Column

    @inlinable public var columns: (Column, Column, Column) {
        (column0, column1, column2)
    }

    @inlinable
    public init(_ columns: [Column]) {
        precondition(columns.count == 3, "Storage needs exactly 3 column vectors")
        column0 = columns[0]
        column1 = columns[1]
        column2 = columns[2]
    }

    @inlinable
    public init(diagonal: Column) {
        let zero: Value = 0
        column0 = Column(diagonal.x, zero, zero)
        column1 = Column(zero, diagonal.y, zero)
        column2 = Column(zero, zero, diagonal.z)
    }

    public init() {
        self.init(diagonal: Column(0, 0, 0))
    }

    public func makeIterator() -> IndexingIterator<[Value]> {
        [column0, column1, column2].flatMap { $0 }.makeIterator()
    }

    @inlinable
    public subscript(column: Int, row: Int) -> Value {
        get {
            switch column {
            case 0:
                return column0[row]

            case 1:
                return column1[row]

            case 2:
                return column2[row]

            default:
                fatalError("column out of bounds \(column)")
            }
        }
        set {
            switch column {
            case 0:
                column0[row] = newValue

            case 1:
                column1[row] = newValue

            case 2:
                column2[row] = newValue

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
        lhs.column0 == rhs.column0 &&
            lhs.column1 == rhs.column1 &&
            lhs.column2 == rhs.column2
    }
}

// MARK: - Storage4x4Ref
public struct Storage4x4<Value>: Storage4x4Protocol where Value: StorageScalar {
    public typealias Column = SIMD4<Value>
    public typealias Storage3x3Ref = Storage3x3<Value>

    // TODO: we could use SIMD16<Value> here

    @usableFromInline var column0: Column
    @usableFromInline var column1: Column
    @usableFromInline var column2: Column
    @usableFromInline var column3: Column

    // swiftlint:disable large_tuple
    @inlinable public var columns: (Column, Column, Column, Column) {
        (column0, column1, column2, column3)
    }

    @inlinable
    public init(_ columns: [Column]) {
        precondition(columns.count == 4, "Storage needs exactly 4 column vectors")
        column0 = columns[0]
        column1 = columns[1]
        column2 = columns[2]
        column3 = columns[3]
    }

    @inlinable
    public init(diagonal: Column) {
        let zero: Value = 0
        column0 = Column(diagonal.x, zero, zero, zero)
        column1 = Column(zero, diagonal.y, zero, zero)
        column2 = Column(zero, zero, diagonal.z, zero)
        column3 = Column(zero, zero, zero, diagonal.w)
    }

    public init() {
        self.init(diagonal: Column(0, 0, 0, 0))
    }

    public func makeIterator() -> IndexingIterator<[Value]> {
        [column0, column1, column2, column3].flatMap { $0 }.makeIterator()
    }

    public subscript(column: Int, row: Int) -> Value {
        get {
            switch column {
            case 0:
                return column0[row]

            case 1:
                return column1[row]

            case 2:
                return column2[row]

            case 3:
                return column3[row]

            default:
                fatalError("column out of bounds \(column)")
            }
        }
        set {
            switch column {
            case 0:
                column0[row] = newValue

            case 1:
                column1[row] = newValue

            case 2:
                column2[row] = newValue

            case 3:
                column3[row] = newValue

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
        lhs.column0 == rhs.column0 &&
            lhs.column1 == rhs.column1 &&
            lhs.column2 == rhs.column2 &&
            lhs.column3 == rhs.column3
    }
}
#endif
