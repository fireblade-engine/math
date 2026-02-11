#if FRB_MATH_USE_SIMD
import simd
#endif

extension Mat4x4f {
    /// Creates a 4x4 rotation matrix.
    /// - Parameters:
    ///   - angleRadians: The angle of rotation in radians.
    ///   - axis: The axis of rotation.
    public init(rotation angleRadians: Float, axis: SIMD3<Float>) {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        let v = normalize(axis)
        let icos = cos(angleRadians)
        let icosp = 1.0 - icos
        let isin = sin(angleRadians)

        self.init(
            Vector(icos + icosp * v.x * v.x,
                   icosp * v.x * v.y + v.z * isin,
                   icosp * v.x * v.z - v.y * isin,
                   0),
            Vector(icosp * v.x * v.y - v.z * isin,
                   icos + icosp * v.y * v.y,
                   icosp * v.y * v.z + v.x * isin,
                   0),
            Vector(icosp * v.x * v.z + v.y * isin,
                   icosp * v.y * v.z - v.x * isin,
                   icos + icosp * v.z * v.z,
                   0),
            Vector(0, 0, 0, 1)
        )
    }

    /// The scale factor of the matrix.
    @inlinable public var scale: SIMD3<Float> {
        let sx = length(storage.columns.0)
        let sy = length(storage.columns.1)
        let sz = length(storage.columns.2)
        return SIMD3<Float>(sx, sy, sz)
    }

    /// Creates a 4x4 matrix from a 3x3 upper-left matrix.
    /// - Parameter matrix3x3: The 3x3 matrix.
    public init(upperLeft matrix3x3: Mat3x3f) {
        self.init(Vector(matrix3x3.columns.0, 0),
                  Vector(matrix3x3.columns.1, 0),
                  Vector(matrix3x3.columns.2, 0),
                  Vector(0, 0, 0, 1))
    }

    /// The upper-left 3x3 matrix.
    @inlinable public var upperLeft: Mat3x3f {
        Mat3x3f(SIMD3<Float>(columns.0.x, columns.0.y, columns.0.z),
                SIMD3<Float>(columns.1.x, columns.1.y, columns.1.z),
                SIMD3<Float>(columns.2.x, columns.2.y, columns.2.z))
    }

    /// The translation vector of the matrix.
    @inlinable public var translation: SIMD3<Float> {
        get {
            let c3 = columns.3
            return SIMD3<Float>(c3[0], c3[1], c3[2])
        }
        set {
            self[3, 0] = newValue.x
            self[3, 1] = newValue.y
            self[3, 2] = newValue.z
        }
    }

    /// The rotation part of the matrix represented as a 4D vector.
    @inlinable public var rotation: SIMD4<Float> {
        let quat = Quat4f(rotation: self)
        return SIMD4<Float>(quat.x, quat.y, quat.z, quat.w)
    }

    /// Creates a 4x4 matrix with the specified translation and scale.
    /// - Parameters:
    ///   - tVec: The translation vector.
    ///   - sVec: The scale vector.
    public init(translation tVec: SIMD3<Float> = .zero, scale sVec: SIMD3<Float> = .one) {
        self.init(diagonal: Vector(sVec.x, sVec.y, sVec.z, 1.0))
        translation = tVec
    }

    /// Translates the matrix by the given vector.
    /// - Parameter vec: The translation vector.
    /// - Returns: The translated matrix.
    @discardableResult
    @inlinable
    public mutating func translate(by vec: SIMD3<Float>) -> Mat4x4f {
        self = multiply(self, Mat4x4f(translation: vec))
        return self
    }

    /// Scales the matrix by the given vector.
    /// - Parameter vec: The scale vector.
    /// - Returns: The scaled matrix.
    @discardableResult
    @inlinable
    public mutating func scale(by vec: SIMD3<Float>) -> Mat4x4f {
        self = multiply(self, Mat4x4f(translation: .zero, scale: vec))
        return self
    }

    /// Rotates the matrix by the given angle around the specified axis.
    /// - Parameters:
    ///   - angleRadians: The angle in radians.
    ///   - axis: The rotation axis.
    /// - Returns: The rotated matrix.
    @discardableResult
    @inlinable
    public mutating func rotate(by angleRadians: Float, axis: SIMD3<Float>) -> Mat4x4f {
        self = multiply(self, Mat4x4f(rotation: angleRadians, axis: axis))
        return self
    }

    /// The inverted matrix.
    @inlinable public var inverted: Mat4x4f {
        inverse(self)
    }

    /// The transposed matrix.
    @inlinable public var transposed: Mat4x4f {
        transpose(self)
    }

    /// Creates a 4x4 view matrix for a camera at `eyePosition` looking at `lookAtPosition`.
    /// - Parameters:
    ///   - eyePosition: The position of the camera.
    ///   - lookAtPosition: The position to look at.
    ///   - up: The up vector.
    /// - Returns: The view matrix.
    @inlinable
    public static func look(from eyePosition: SIMD3<Float>, at lookAtPosition: SIMD3<Float>, up: SIMD3<Float>) -> Mat4x4f {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        let ev = eyePosition
        let cv = lookAtPosition
        let uv = up

        let n = normalize(ev - cv)
        let u = normalize(cross(uv, n))
        let v = cross(n, u)

        return Mat4x4f(
            Vector(u.x, v.x, n.x, 0.0),
            Vector(u.y, v.y, n.y, 0.0),
            Vector(u.z, v.z, n.z, 0.0),
            Vector(dot(-u, ev), dot(-v, ev), dot(-n, ev), 1.0)
        )
    }

    /// Alias for `look(from:at:up:)`.
    @inlinable
    public static func lookAt(eye: Vec3f, center: Vec3f, up: Vec3f) -> Mat4x4f {
        look(from: eye, at: center, up: up)
    }

    /// Creates a 4x4 rotation matrix.
    /// - Parameters:
    ///   - angle: The angle in radians.
    ///   - axis: The rotation axis.
    /// - Returns: The rotation matrix.
    @inlinable
    public static func rotation(angle: Float, axis: Vec3f) -> Mat4x4f {
        Mat4x4f(rotation: angle, axis: axis)
    }

    /// Creates a 4x4 translation matrix.
    /// - Parameters:
    ///   - x: The translation along the x-axis.
    ///   - y: The translation along the y-axis.
    ///   - z: The translation along the z-axis.
    /// - Returns: The translation matrix.
    @inlinable
    public static func translation(x: Float, y: Float, z: Float) -> Mat4x4f {
        Mat4x4f(translation: Vec3f(x, y, z))
    }

    /// Creates a 4x4 scaling matrix.
    /// - Parameters:
    ///   - x: The scale along the x-axis.
    ///   - y: The scale along the y-axis.
    ///   - z: The scale along the z-axis.
    /// - Returns: The scaling matrix.
    @inlinable
    public static func scaling(x: Float, y: Float, z: Float) -> Mat4x4f {
        Mat4x4f(translation: .zero, scale: Vec3f(x, y, z))
    }

    /// Transforms a 3D point by the matrix.
    /// - Parameter point: The 3D point to transform.
    /// - Returns: The transformed point.
    @inlinable
    public func transformPoint(_ point: Vec3f) -> Vec3f {
        let p4 = Vec4f(point.x, point.y, point.z, 1.0)
        let res = multiply(self, p4)
        return Vec3f(res.x, res.y, res.z)
    }

    /// Transforms a 3D direction vector by the matrix.
    /// - Parameter dir: The 3D direction vector to transform.
    /// - Returns: The transformed direction vector.
    @inlinable
    public func transformDirection(_ dir: Vec3f) -> Vec3f {
        let d4 = Vec4f(dir.x, dir.y, dir.z, 0.0)
        let res = multiply(self, d4)
        return Vec3f(res.x, res.y, res.z)
    }

    /// Rotates the matrix around the x-axis.
    /// - Parameter angle: The angle in radians.
    @inlinable
    public mutating func pitch(by angle: Float) {
        rotate(by: angle, axis: Vec3f(1, 0, 0))
    }

    /// Rotates the matrix around the y-axis.
    /// - Parameter angle: The angle in radians.
    @inlinable
    public mutating func yaw(by angle: Float) {
        rotate(by: angle, axis: Vec3f(0, 1, 0))
    }

    /// Rotates the matrix around the z-axis.
    /// - Parameter angle: The angle in radians.
    @inlinable
    public mutating func roll(by angle: Float) {
        rotate(by: angle, axis: Vec3f(0, 0, 1))
    }

    /// The right direction vector (positive x-axis) in view space.
    @inlinable public var right: Vec3f {
        get {
            Vec3f(self[0, 0],
                  self[1, 0],
                  self[2, 0])
        }
        set {
            self[0, 0] = newValue.x
            self[1, 0] = newValue.y
            self[2, 0] = newValue.z
        }
    }

    /// The up direction vector (positive y-axis) in view space.
    @inlinable public var up: Vec3f {
        get {
            Vec3f(self[0, 1],
                  self[1, 1],
                  self[2, 1])
        }
        set {
            self[0, 1] = newValue.x
            self[1, 1] = newValue.y
            self[2, 1] = newValue.z
        }
    }

    /// The forward direction vector (positive z-axis) in view space.
    @inlinable public var forward: Vec3f {
        get {
            Vec3f(self[0, 2],
                  self[1, 2],
                  self[2, 2])
        }
        set {
            self[0, 2] = newValue.x
            self[1, 2] = newValue.y
            self[2, 2] = newValue.z
        }
    }

    /// Returns the Euler angles (pitch, yaw, roll) for this matrix in radians.
    /// - Returns: A 3D vector where x is pitch, y is yaw, and z is roll.
    @inline(__always) public var eulerAnglesXYZ: Vec3f {
        // /// https://www.geometrictools.com/Documentation/EulerAngles.pdf
        let thetaX: Float
        let thetaY: Float
        let thetaZ: Float

        if self[0, 2] < +1 {
            if self[0, 2] > -1 {
                thetaY = asin(self[0, 2])
                thetaX = atan2(-self[1, 2], self[2, 2])
                thetaZ = atan2(-self[0, 1], self[0, 0])
            } else { // = -1
                // Not a unique solution: thetaZ - thetaX = atan2(self[1,0], self[1,1])
                thetaY = -.pi / 2
                thetaX = -atan2(self[1, 0], self[1, 1])
                thetaZ = 0
            }
        } else { // self[0,2] = +1
            // Not a unique solution: thetaZ + thetaX = atan2(self[1,0],self[1,1])
            thetaY = +.pi / 2
            thetaX = atan2(self[1, 0], self[1, 1])
            thetaZ = 0
        }

        return Vec3f(thetaX, thetaY, thetaZ)
    }
}