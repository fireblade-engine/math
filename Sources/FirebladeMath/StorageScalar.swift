//
//  StorageScalar.swift
//
//
//  Created by Christian Treffs on 06.09.19.
//

public typealias StorageScalar = SIMDScalar

extension StorageScalar {
    public static var zero: Self { return 0 as! Self }
    public static var one: Self { return 1 as! Self }
}
