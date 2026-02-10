extension Mat2x2f {
    public static var identity: Mat2x2f {
        Mat2x2f(diagonal: Vector(1, 1))
    }
}

extension Mat2x2d {
    public static var identity: Mat2x2d {
        Mat2x2d(diagonal: Vector(1, 1))
    }
}

extension Mat3x3f {
    public static var identity: Mat3x3f {
        Mat3x3f(diagonal: Vector(1, 1, 1))
    }
}

extension Mat3x3d {
    public static var identity: Mat3x3d {
        Mat3x3d(diagonal: Vector(1, 1, 1))
    }
}

extension Mat4x4f {
    public static var identity: Mat4x4f {
        Mat4x4f(diagonal: Vector(1, 1, 1, 1))
    }
}

extension Mat4x4d {
    public static var identity: Mat4x4d {
        Mat4x4d(diagonal: Vector(1, 1, 1, 1))
    }
}
