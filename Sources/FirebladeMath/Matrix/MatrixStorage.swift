//
//  MatrixStorage.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 05.09.19.
//

public protocol Storage4x4Protocol: Sequence, Equatable {
    associatedtype Value: StorageScalar
    //associatedtype _Storage3x3: Storage3x3Protocol where _Storage3x3.Value == Value
    typealias Column = SIMD4<Value>

    init(_ columns: [Column])
    init(diagonal: Column)

    // swiftlint:disable large_tuple
    var columns: (Column, Column, Column, Column) { get }

    subscript(column: Int, row: Int) -> Value { get set }
    subscript(index: Int) -> Value { get set }
}

public protocol Storage3x3Protocol: Sequence, Equatable {
    associatedtype Value: StorageScalar
    //associatedtype _Storage4x4: Storage4x4Protocol where _Storage4x4.Value == Value
    typealias Column = SIMD3<Value>

    init(_ columns: [Column])
    init(diagonal: Column)

    var columns: (Column, Column, Column) { get }

    subscript(column: Int, row: Int) -> Value { get set }
    subscript(index: Int) -> Value { get set }
}
