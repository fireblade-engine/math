//
//  rotate.swift
//
//
//  Created by Christian Treffs on 10.06.20.
//

public func rotate(_ vector: Vec4f, _ axis: Vec3f, _ angle: Float) -> Vec4f {
    Mat4x4f(rotation: angle, axis: axis) * vector
}

public func rotate(_ vector: Vec3f, _ axis: Vec3f, _ angle: Float) -> Vec3f {
    rotate(Vec4f(vector, 1), axis, angle).xyz
}
