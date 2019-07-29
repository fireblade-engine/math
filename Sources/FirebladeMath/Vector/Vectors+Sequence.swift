//
//  Vectors+Sequence.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 15.06.19.
//

import simd.vector

extension SIMD2: Sequence {
    public __consuming func makeIterator() -> IndexingIterator<[Scalar]> {
        return [x, y].makeIterator()
    }
}

extension SIMD3: Sequence {
    public __consuming func makeIterator() -> IndexingIterator<[Scalar]> {
        return [x, y, z].makeIterator()
    }
}

extension SIMD4: Sequence {
    public __consuming func makeIterator() -> IndexingIterator<[Scalar]> {
        return [x, y, z, w].makeIterator()
    }
}
