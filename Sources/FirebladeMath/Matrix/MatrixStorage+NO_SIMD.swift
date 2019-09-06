//
//  MatrixStorage+NO_SIMD.swift
//
//
//  Created by Christian Treffs on 06.09.19.
//

// MARK: - Storage3x3
public struct Storage3x3<Value>: Storage3x3Protocol where Value: Scalar {
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
        _columns0 = Column(diagonal.x, 0, 0)
        _columns1 = Column(0, diagonal.y, 0)
        _columns2 = Column(0, 0, diagonal.z)
    }

    public __consuming func makeIterator() -> IndexingIterator<[Value]> {
        return [_columns0, _columns1, _columns2].flatMap { $0 }.makeIterator()
    }
}

// MARK: - Storage4x4
public struct Storage4x4<Value>: Storage4x4Protocol where Value: Scalar {
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
        _columns0 = Column(diagonal.x, 0, 0, 0)
        _columns1 = Column(0, diagonal.y, 0, 0)
        _columns2 = Column(0, diagonal.z, 0, 0)
        _columns3 = Column(0, 0, 0, diagonal.w)
    }

    public __consuming func makeIterator() -> IndexingIterator<[Value]> {
        return [_columns0, _columns1, _columns2, _columns3].flatMap { $0 }.makeIterator()
    }
}
