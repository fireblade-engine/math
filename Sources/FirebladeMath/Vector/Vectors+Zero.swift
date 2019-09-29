//
//  Vectors+Zero.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if swift(<5.1)
extension Vec2d {
    public static let zero = SIMD2<Double>(repeating: 0)
}
extension Vec2f {
    public static let zero = SIMD2<Float>(repeating: 0)
}
extension Vec2i {
    public static let zero = SIMD2<Int>(repeating: 0)
}
extension Vec2u {
    public static let zero = SIMD2<UInt>(repeating: 0)
}

extension Vec3d {
    public static let zero = SIMD3<Double>(repeating: 0)
}
extension Vec3f {
    public static let zero = SIMD3<Float>(repeating: 0)
}
extension Vec3i {
    public static let zero = SIMD3<Int>(repeating: 0)
}
extension Vec3u {
    public static let zero = SIMD3<UInt>(repeating: 0)
}

extension Vec4d {
    public static let zero = SIMD4<Double>(repeating: 0)
}
extension Vec4f {
    public static let zero = SIMD4<Float>(repeating: 0)
}
extension Vec4i {
    public static let zero = SIMD4<Int>(repeating: 0)
}
extension Vec4u {
    public static let zero = SIMD4<UInt>(repeating: 0)
}
#endif
