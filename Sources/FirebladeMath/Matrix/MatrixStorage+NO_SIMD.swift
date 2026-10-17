#if !FRB_MATH_USE_SIMD

// MARK: - Storage2x2

@frozen
public struct Storage2x2<Value: StorageScalar>: Storage2x2Protocol {
    public typealias Column = SIMD2<Value>
    public typealias Storage3x3Ref = Storage3x3<Value>
    public typealias Storage4x4Ref = Storage4x4<Value>

    @usableFromInline var column0: Column
    @usableFromInline var column1: Column

    @inlinable public var columns: (Column, Column) {
        (column0, column1)
    }

    @inlinable
    public init(_ columns: [Column]) {
        precondition(columns.count == 2, "Storage needs exactly 2 column vectors")
        self.init(columns[0], columns[1])
    }

    @inlinable
    public init(_ column0: Column, _ column1: Column) {
        self.column0 = column0
        self.column1 = column1
    }

    @inlinable
    public init(diagonal: Column) {
        let zero = Value.zero
        column0 = Column(diagonal.x, zero)
        column1 = Column(zero, diagonal.y)
    }

    @inlinable
    public init() {
        let zero = Value.zero
        self.init(diagonal: Column(zero, zero))
    }

    @inlinable
    public subscript(column: Int, row: Int) -> Value {
        get {
            switch column {
            case 0:
                column0[row]

            case 1:
                column1[row]

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

            default:
                fatalError("column out of bounds \(column)")
            }
        }
    }

    @inlinable
    public subscript(index: Int) -> Value {
        get {
            let (column, row) = columnMajorPosition(of: index, rows: 2)
            return self[column, row]
        }
        set {
            let (column, row) = columnMajorPosition(of: index, rows: 2)
            self[column, row] = newValue
        }
    }
}

extension Storage2x2: Equatable {
    @inlinable
    @inline(__always)
    public static func == (lhs: Storage2x2<Value>, rhs: Storage2x2<Value>) -> Bool {
        lhs.column0 == rhs.column0 &&
            lhs.column1 == rhs.column1
    }
}

extension Storage2x2: @unchecked Sendable where Value: Sendable {}

// MARK: - Storage3x3

@frozen
public struct Storage3x3<Value: StorageScalar>: Storage3x3Protocol {
    public typealias Column = SIMD3<Value>
    public typealias Storage2x2Ref = Storage2x2<Value>
    public typealias Storage4x4Ref = Storage4x4<Value>

    @usableFromInline var column0: Column
    @usableFromInline var column1: Column
    @usableFromInline var column2: Column

    // swiftlint:disable:next large_tuple
    @inlinable public var columns: (Column, Column, Column) {
        (column0, column1, column2)
    }

    @inlinable
    public init(_ columns: [Column]) {
        precondition(columns.count == 3, "Storage needs exactly 3 column vectors")
        self.init(columns[0], columns[1], columns[2])
    }

    @inlinable
    public init(_ column0: Column, _ column1: Column, _ column2: Column) {
        self.column0 = column0
        self.column1 = column1
        self.column2 = column2
    }

    @inlinable
    public init(diagonal: Column) {
        let zero = Value.zero
        column0 = Column(diagonal.x, zero, zero)
        column1 = Column(zero, diagonal.y, zero)
        column2 = Column(zero, zero, diagonal.z)
    }

    @inlinable
    public init() {
        let zero = Value.zero
        self.init(diagonal: Column(zero, zero, zero))
    }

    @inlinable
    public subscript(column: Int, row: Int) -> Value {
        get {
            switch column {
            case 0:
                column0[row]

            case 1:
                column1[row]

            case 2:
                column2[row]

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

    @inlinable
    public subscript(index: Int) -> Value {
        get {
            let (column, row) = columnMajorPosition(of: index, rows: 3)
            return self[column, row]
        }
        set {
            let (column, row) = columnMajorPosition(of: index, rows: 3)
            self[column, row] = newValue
        }
    }
}

extension Storage3x3: Equatable {
    @inlinable
    @inline(__always)
    public static func == (lhs: Storage3x3<Value>, rhs: Storage3x3<Value>) -> Bool {
        lhs.column0 == rhs.column0 &&
            lhs.column1 == rhs.column1 &&
            lhs.column2 == rhs.column2
    }
}

extension Storage3x3: @unchecked Sendable where Value: Sendable {}

// MARK: - Storage4x4Ref

@frozen
public struct Storage4x4<Value: StorageScalar>: Storage4x4Protocol {
    public typealias Column = SIMD4<Value>
    public typealias Storage2x2Ref = Storage2x2<Value>
    public typealias Storage3x3Ref = Storage3x3<Value>

    // NOTE: we could use SIMD16<Value> here

    @usableFromInline var column0: Column
    @usableFromInline var column1: Column
    @usableFromInline var column2: Column
    @usableFromInline var column3: Column

    // swiftlint:disable:next large_tuple
    @inlinable public var columns: (Column, Column, Column, Column) {
        (column0, column1, column2, column3)
    }

    @inlinable
    public init(_ columns: [Column]) {
        precondition(columns.count == 4, "Storage needs exactly 4 column vectors")
        self.init(columns[0], columns[1], columns[2], columns[3])
    }

    @inlinable
    public init(_ column0: Column, _ column1: Column, _ column2: Column, _ column3: Column) {
        self.column0 = column0
        self.column1 = column1
        self.column2 = column2
        self.column3 = column3
    }

    @inlinable
    public init(diagonal: Column) {
        let zero = Value.zero
        column0 = Column(diagonal.x, zero, zero, zero)
        column1 = Column(zero, diagonal.y, zero, zero)
        column2 = Column(zero, zero, diagonal.z, zero)
        column3 = Column(zero, zero, zero, diagonal.w)
    }

    @inlinable
    public init() {
        let zero = Value.zero
        self.init(diagonal: Column(zero, zero, zero, zero))
    }

    @inlinable
    public subscript(column: Int, row: Int) -> Value {
        get {
            switch column {
            case 0:
                column0[row]

            case 1:
                column1[row]

            case 2:
                column2[row]

            case 3:
                column3[row]

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

    @inlinable
    public subscript(index: Int) -> Value {
        get {
            let (column, row) = columnMajorPosition(of: index, rows: 4)
            return self[column, row]
        }
        set {
            let (column, row) = columnMajorPosition(of: index, rows: 4)
            self[column, row] = newValue
        }
    }
}

extension Storage4x4: Equatable {
    @inlinable
    @inline(__always)
    public static func == (lhs: Storage4x4<Value>, rhs: Storage4x4<Value>) -> Bool {
        lhs.column0 == rhs.column0 &&
            lhs.column1 == rhs.column1 &&
            lhs.column2 == rhs.column2 &&
            lhs.column3 == rhs.column3
    }
}

extension Storage4x4: @unchecked Sendable where Value: Sendable {}
#endif
