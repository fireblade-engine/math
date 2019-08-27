//
//  Vectors+One.swift
//  FirebladeMath
//
//  Created by Christian Treffs on 26.08.19.
//

#if swift(<5.1)
extension Vec2d {
    public static let one = Vec2d(repeating: 1)
}
extension Vec2f {
    public static let one = Vec2f(repeating: 1)
}
extension Vec2i {
    public static let one = Vec2i(repeating: 1)
}
extension Vec2u {
    public static let one = Vec2u(repeating: 1)
}

extension Vec3d {
    public static let one = Vec3d(repeating: 1)
}
extension Vec3f {
    public static let one = Vec3f(repeating: 1)
}
extension Vec3i {
    public static let one = Vec3i(repeating: 1)
}
extension Vec3u {
    public static let one = Vec3u(repeating: 1)
}

extension Vec4d {
    public static let one = Vec4d(repeating: 1)
}
extension Vec4f {
    public static let one = Vec4f(repeating: 1)
}
extension Vec4i {
    public static let one = Vec4i(repeating: 1)
}
extension Vec4u {
    public static let one = Vec4u(repeating: 1)
}
#endif
