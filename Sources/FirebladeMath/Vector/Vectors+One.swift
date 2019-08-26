//
//  Vectors+One.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if swift(<5.1)
extension Vec2d {
    public static let one = SIMD2<Double>(repeating: 1)
}
extension Vec2f {
    public static let one = SIMD2<Float>(repeating: 1)
}
extension Vec2i {
    public static let one = SIMD2<Int>(repeating: 1)
}
extension Vec2u {
    public static let one = SIMD2<UInt>(repeating: 1)
}

extension Vec3d {
    public static let one = SIMD3<Double>(repeating: 1)
}
extension Vec3f {
    public static let one = SIMD3<Float>(repeating: 1)
}
extension Vec3i {
    public static let one = SIMD3<Int>(repeating: 1)
}
extension Vec3u {
    public static let one = SIMD3<UInt>(repeating: 1)
}

extension Vec4d {
    public static let one = SIMD4<Double>(repeating: 1)
}
extension Vec4f {
    public static let one = SIMD4<Float>(repeating: 1)
}
extension Vec4i {
    public static let one = SIMD4<Int>(repeating: 1)
}
extension Vec4u {
    public static let one = SIMD4<UInt>(repeating: 1)
}
#endif
