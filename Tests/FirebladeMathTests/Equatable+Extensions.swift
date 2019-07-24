//
//  Equatable+Extensions.swift
//  
//
//  Created by Christian Treffs on 21.07.19.
//

import simd
import GLKit
import QuartzCore

protocol DoubleArrayEquatable: Equatable {
    var array: [Double] { get }
}

extension GLKMatrix4 {
    init(_ f: [Float]) {
        self.init(m: (f[0], f[1], f[2], f[3], f[4], f[5], f[6], f[7], f[8], f[9], f[10], f[11], f[12], f[13], f[14], f[15]))
    }
}


extension DoubleArrayEquatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.array == rhs.array
    }
}

extension simd_float4x4: DoubleArrayEquatable {
    @inlinable var array: [Double] {
        return [columns.0, columns.1, columns.2, columns.3].map { SIMD4<Double>($0) }.flatMap { $0 }
    }
}

extension GLKMatrix4: DoubleArrayEquatable {
    @inlinable var array: [Double] {
        return [m00, m01, m02, m03,
                m10, m11, m12, m13,
                m20, m21, m22, m23,
                m30, m31, m32, m33].map { Double($0) }
    }
}

extension CATransform3D: DoubleArrayEquatable {
    @inlinable var array: [Double] {
        return [m11, m12, m13, m14,
                m21, m22, m23, m24,
                m31, m32, m33, m34,
                m41, m42, m43, m44].map { Double($0) }
    }
}

func == (lhs: simd_float4x4, rhs: GLKMatrix4) -> Bool {
    return lhs.columns.0[0] == rhs.m00 &&
        lhs.columns.0[1] == rhs.m01 &&
        lhs.columns.0[2] == rhs.m02 &&
        lhs.columns.0[3] == rhs.m03 &&
        
        lhs.columns.1[0] == rhs.m10 &&
        lhs.columns.1[1] == rhs.m11 &&
        lhs.columns.1[2] == rhs.m12 &&
        lhs.columns.1[3] == rhs.m13 &&
        
        lhs.columns.2[0] == rhs.m20 &&
        lhs.columns.2[1] == rhs.m21 &&
        lhs.columns.2[2] == rhs.m22 &&
        lhs.columns.2[3] == rhs.m23 &&
        
        lhs.columns.3[0] == rhs.m30 &&
        lhs.columns.3[1] == rhs.m31 &&
        lhs.columns.3[2] == rhs.m32 &&
        lhs.columns.3[3] == rhs.m33
}


func == (lhs: simd_float4x4, rhs: CATransform3D) -> Bool {
    return  lhs.columns.0[0] == Float(rhs.m11) &&
        lhs.columns.0[1] == Float(rhs.m12) &&
        lhs.columns.0[2] == Float(rhs.m13) &&
        lhs.columns.0[3] == Float(rhs.m14) &&
        
        lhs.columns.1[0] == Float(rhs.m21) &&
        lhs.columns.1[1] == Float(rhs.m22) &&
        lhs.columns.1[2] == Float(rhs.m23) &&
        lhs.columns.1[3] == Float(rhs.m24) &&
        
        lhs.columns.2[0] == Float(rhs.m31) &&
        lhs.columns.2[1] == Float(rhs.m32) &&
        lhs.columns.2[2] == Float(rhs.m33) &&
        lhs.columns.2[3] == Float(rhs.m34) &&
        
        lhs.columns.3[0] == Float(rhs.m41) &&
        lhs.columns.3[1] == Float(rhs.m42) &&
        lhs.columns.3[2] == Float(rhs.m43) &&
        lhs.columns.3[3] == Float(rhs.m44)
}

