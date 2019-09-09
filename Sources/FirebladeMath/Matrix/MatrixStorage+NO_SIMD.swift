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

    @usableFromInline var _columns0: Column
    @usableFromInline var _columns1: Column
    @usableFromInline var _columns2: Column

    @inlinable public var columns: (Column, Column, Column) {
        return (_columns0, _columns1, _columns2)
    }

    @inlinable public init(_ columns: [Column]) {
        precondition(columns.count == 3, "Storage needs exacty 3 column vectors")
        _columns0 = columns[0]
        _columns1 = columns[1]
        _columns2 = columns[2]
    }

    @inlinable public init(diagonal: Column) {
        let zero: Value = 0 as! Value
        _columns0 = Column(diagonal.x, zero, zero)
        _columns1 = Column(zero, diagonal.y, zero)
        _columns2 = Column(zero, zero, diagonal.z)
    }

    public __consuming func makeIterator() -> IndexingIterator<[Value]> {
        return [_columns0, _columns1, _columns2].flatMap { $0 }.makeIterator()
    }
}

extension Storage3x3: Equatable {
    public static func == (lhs: Storage3x3<Value>, rhs: Storage3x3<Value>) -> Bool {
        return lhs._columns0 == rhs._columns0 &&
            lhs._columns1 == rhs._columns1 &&
            lhs._columns2 == rhs._columns2
    }
}

// MARK: - Storage4x4
public struct Storage4x4<Value>: Storage4x4Protocol where Value: StorageScalar {
    public typealias Column = SIMD4<Value>
    public typealias _Storage3x3 = Storage3x3<Value>

    @usableFromInline var _columns0: Column
    @usableFromInline var _columns1: Column
    @usableFromInline var _columns2: Column
    @usableFromInline var _columns3: Column

    @inlinable public var columns: (Column, Column, Column, Column) {
        return (_columns0, _columns1, _columns2, _columns3)
    }

    @inlinable public init(_ columns: [Column]) {
        precondition(columns.count == 4, "Storage needs exacty 4 column vectors")
        _columns0 = columns[0]
        _columns1 = columns[1]
        _columns2 = columns[2]
        _columns3 = columns[3]
    }

    @inlinable public init(diagonal: Column) {
        _columns0 = Column(diagonal.x, Value.zero, Value.zero, Value.zero)
        _columns1 = Column(Value.zero, diagonal.y, Value.zero, Value.zero)
        _columns2 = Column(Value.zero, diagonal.z, Value.zero, Value.zero)
        _columns3 = Column(Value.zero, Value.zero, Value.zero, diagonal.w)
    }

    public __consuming func makeIterator() -> IndexingIterator<[Value]> {
        return [_columns0, _columns1, _columns2, _columns3].flatMap { $0 }.makeIterator()
    }
}

extension Storage4x4: Equatable {
    public static func == (lhs: Storage4x4<Value>, rhs: Storage4x4<Value>) -> Bool {
        return lhs._columns0 == rhs._columns0 &&
            lhs._columns1 == rhs._columns1 &&
            lhs._columns2 == rhs._columns2 &&
            lhs._columns3 == rhs._columns3
    }
}
#endif
