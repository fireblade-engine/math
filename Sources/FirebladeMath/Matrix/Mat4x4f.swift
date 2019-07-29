//
//  Mat4x4f.swift
//  
//
//  Created by Christian Treffs on 22.07.19.
//

import struct simd.matrix.simd_float4x4
import func simd.simd_inverse
import func simd.simd_determinant
import func simd.simd_quaternion
import func simd.normalize
import func simd.cross
import func simd.dot
import func simd.simd_mul
import func simd.matrix_multiply

public typealias Mat4x4f = simd_float4x4

extension Mat4x4f {
    public init(_ array: [Float]) {
        precondition(array.count == 16, "Mat4x4f needs exactly 16 values")
        self.init(SIMD4<Float>(array[0], array[1], array[2], array[3]),
                  SIMD4<Float>(array[4], array[5], array[6], array[7]),
                  SIMD4<Float>(array[8], array[9], array[10], array[11]),
                  SIMD4<Float>(array[12], array[13], array[14], array[15]))
    }

    public init(columns columnA: Vec4f, _ columnB: Vec4f, _ columnC: Vec4f, _ columnD: Vec4f) {
        self.init(columnA, columnB, columnC, columnD)
    }

    public init(translation tVec: Vec3f = .zero, scale sVec: Vec3f = .one) {
        self.init([sVec.x, 0, 0, 0,
                   0, sVec.y, 0, 0,
                   0, 0, sVec.z, 0,
                   tVec.x, tVec.y, tVec.z, 1])
    }

    public init(rotation angleRadians: Float, axis: Vec3f) {
        self.init(upperLeft: Mat3x3f(rotation: angleRadians, axis: axis))
    }

    public init(orientation quaternion: Quat4f) {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        let nQuat: Vec4f = quaternion.normalized.vector

        let x: Float = nQuat[0]
        let y: Float = nQuat[1]
        let z: Float = nQuat[2]
        let w: Float = nQuat[3]

        let _2x: Float = x + x
        let _2y: Float = y + y
        let _2z: Float = z + z
        let _2w: Float = w + w

        self.init(
            Vec4f(1.0 - _2y * y - _2z * z,
                  _2x * y + _2w * z,
                  _2x * z - _2w * y,
                  0.0),
            Vec4f(_2x * y - _2w * z,
                  1.0 - _2x * x - _2z * z,
                  _2y * z + _2w * x,
                  0.0),
            Vec4f(_2x * z + _2w * y,
                  _2y * z - _2w * x,
                  1.0 - _2x * x - _2y * y,
                  0.0),
            Vec4f(0.0, 0.0, 0.0, 1.0)
        )
    }

    public init(upperLeft matrix3x3: Mat3x3f) {
        self.init(Vec4f(matrix3x3.columns.0, 0),
                  Vec4f(matrix3x3.columns.1, 0),
                  Vec4f(matrix3x3.columns.2, 0),
                  Vec4f(0, 0, 0, 1))
    }

    public init(_ matrix4x4: Mat4x4d) {
        self.init(Vec4f(matrix4x4.columns.0),
                  Vec4f(matrix4x4.columns.1),
                  Vec4f(matrix4x4.columns.2),
                  Vec4f(matrix4x4.columns.3))
    }

    public init(eulerAngles angles: Vec3f) {
        self.init(upperLeft: Mat3x3f(eulerAngles: angles))
    }

    public init(yaw: Float, pitch: Float, roll: Float) {
        self.init(Quat4f(yaw: yaw, pitch: pitch, roll: roll))
    }
}

// MARK: - computed properties
extension Mat4x4f {
    @inlinable public var upperLeft: Mat3x3f {
        return Mat3x3f(Vec3f(columns.0.xyz),
                       Vec3f(columns.1.xyz),
                       Vec3f(columns.2.xyz))
    }

    @inlinable public var inverted: Mat4x4f {
        return simd.simd_inverse(self)
    }

    @inlinable public var determinant: Float {
        return simd.simd_determinant(self)
    }

    @inlinable public var scale: Vec3f {
        let sx = columns.0.length
        let sy = columns.1.length
        let sz = columns.2.length

        return Vec3f(sx, sy, sz)
    }

    @inlinable public var translation: Vec3f {
        return Vec3f(columns.3[0], columns.3[1], columns.3[2])
    }

    /// Construct a quaternion from a 4x4 rotation `matrix`.
    ///
    /// The last row and column of the matrix are ignored. This
    /// function is equivalent to calling simd_quaternion with the upper-left 3x3
    /// submatrix.
    @inlinable public var quaternion: Quat4f {
        return simd_quaternion(self)
    }

    @inlinable public var eulerAngles: Vec3f {
        return Quat4f(self).eulerAngles
    }
}

// MARK: - mutating operations
extension Mat4x4f {
    @discardableResult
    @inlinable public mutating func translate(by vec: Vec3f) -> Mat4x4f {
        self = simd_mul(self, Mat4x4f(translation: vec))
        return self
    }

    @discardableResult
    @inlinable public mutating func scale(by vec: Vec3f) -> Mat4x4f {
        self = simd_mul(self, Mat4x4f(scale: vec))
        return self
    }

    @discardableResult
    @inlinable public mutating func rotate(by angleRadians: Float, axis: Vec3f) -> Mat4x4f {
        self = simd_mul(self, Mat4x4f(rotation: angleRadians, axis: axis))
        return self
    }
}

// MARK: - static functions
extension Mat4x4f: IdentitiyProviding {
    public static let identity = Mat4x4f(diagonal: .one)
}

extension Mat4x4f {
    @inlinable public static func look(from eyePosition: Vec3f, at lookAtPosition: Vec3f, up: Vec3f) -> Mat4x4f {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        let ev: Vec3f = eyePosition
        let cv: Vec3f = lookAtPosition
        let uv: Vec3f = up

        let n: Vec3f = normalize(ev - cv)
        let u: Vec3f = normalize(cross(uv, n))
        let v: Vec3f = cross(n, u)

        return Mat4x4f(
            Vec4f(u.x, v.x, n.x, 0.0),
            Vec4f(u.y, v.y, n.y, 0.0),
            Vec4f(u.z, v.z, n.z, 0.0),
            Vec4f(dot(-u, ev), dot(-v, ev), dot(-n, ev), 1.0)
        )
    }

    @inlinable public static func perspective(fovy fovyRadians: Float, width: Float, height: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        // see: <GLKit.framework/.../Headers/GLKMatrix4.h>
        precondition(fovyRadians > 0.0, "Field of view must be greater than 0.0")
        precondition(width > 0.0, "Width must be greater than 0.0")
        precondition(height > 0.0, "Height must be greater than 0.0")
        precondition(zNear > 0.0, "zNear must be greater than 0.0")
        precondition(zFar > zNear, "zFar must be greater than zNear and greater than 0.0")

        let aspect: Float = width / height
        let cotan: Float = 1.0 / tan(fovyRadians / 2.0)

        let m00: Float = cotan / aspect
        let m11: Float = cotan
        let m22: Float = (zFar + zNear) / (zNear - zFar)
        let m23: Float = -1.0
        let m32: Float = (2.0 * zFar * zNear) / (zNear - zFar)
        let m33: Float = 0.0

        return Mat4x4f(Vec4f(m00, 0.0, 0.0, 0.0),
                       Vec4f(0.0, m11, 0.0, 0.0),
                       Vec4f(0.0, 0.0, m22, m23),
                       Vec4f(0.0, 0.0, m32, m33))
    }

    /// Returns a 4x4 orthographic projection matrix.
    /// - Parameter left: The left coordinate of the projection volume in eye coordinates.
    /// - Parameter right: The right coordinate of the projection volume in eye coordinates.
    /// - Parameter bottom: The bottom coordinate of the projection volume in eye coordinates.
    /// - Parameter top: The top coordinate of the projection volume in eye coordinates.
    /// - Parameter zNear: The near coordinate of the projection volume in eye coordinates.
    /// - Parameter zFar: The far coordinate of the projection volume in eye coordinates.
    @inlinable public static func orthographic(left: Float, right: Float, bottom: Float, top: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        let ral: Float = right + left
        let rsl: Float = right - left
        let tab: Float = top + bottom
        let tsb: Float = top - bottom
        let fan: Float = zFar + zNear
        let fsn: Float = zFar - zNear

        return Mat4x4f(
            Vec4f(2.0 / rsl, 0.0, 0.0, 0.0),
            Vec4f(0.0, 2.0 / tsb, 0.0, 0.0),
            Vec4f(0.0, 0.0, -2.0 / fsn, 0.0),
            Vec4f(-ral / rsl, -tab / tsb, -fan / fsn, 1.0)
        )
    }
}

// MARK: - euler
extension Mat4x4f {
    @inlinable public var eulerAnglesXYZ: Vec3f {
        return upperLeft.eulerAnglesXYZ
    }

    @inlinable public var eulerAnglesXZY: Vec3f {
        return upperLeft.eulerAnglesXZY
    }

    @inlinable public var eulerAnglesYXZ: Vec3f {
        return upperLeft.eulerAnglesYXZ
    }

    @inlinable public var eulerAnglesZXY: Vec3f {
        return upperLeft.eulerAnglesZXY
    }

    @inlinable public var eulerAnglesZYX: Vec3f {
        return upperLeft.eulerAnglesZYX
    }
}

// MARK: - operators
extension Mat4x4f {
    /*
     matrix_multiply(_ __x: simd_float4, _ __y: simd_float4x4) -> simd_float4
     matrix_multiply(_ __x: simd_float4x4, _ __y: simd_float4) -> simd_float4
     matrix_multiply(_ __x: simd_float4x4, _ __y: simd_float4x4) -> simd_float4x4
     matrix_scale(_ __a: Float, _ __x: simd_float4x4) -> simd_float4x4
     simd_add(_ __x: simd_float4x4, _ __y: simd_float4x4) -> simd_float4x4
     simd_almost_equal_elements(_ __x: simd_float4x4, _ __y: simd_float4x4, _ __tol: Float) -> simd_bool
     simd_almost_equal_elements_relative(_ __x: simd_float4x4, _ __y: simd_float4x4, _ __tol: Float) -> simd_bool
     simd_determinant(_ __x: simd_float4x4) -> Float
     simd_diagonal_matrix(_ __x: simd_float4) -> simd_float4x4
     simd_equal(_ __x: simd_float4x4, _ __y: simd_float4x4) -> simd_bool
     simd_inverse(_ __x: simd_float4x4) -> simd_float4x4
     simd_linear_combination(_ __a: Float, _ __x: simd_float4x4, _ __b: Float, _ __y: simd_float4x4) -> simd_float4x4
     simd_matrix(_ col0: simd_float4, _ col1: simd_float4, _ col2: simd_float4, _ col3: simd_float4) -> simd_float4x4
     simd_matrix4x4(_ q: simd_quatf) -> simd_float4x4
     simd_matrix_from_rows(_ row0: simd_float4, _ row1: simd_float4, _ row2: simd_float4, _ row3: simd_float4) -> simd_float4x4
     simd_mul(_ __a: Float, _ __x: simd_float4x4) -> simd_float4x4
     simd_mul(_ __x: simd_float4, _ __y: simd_float4x4) -> simd_float4
     simd_mul(_ __x: simd_float4x4, _ __y: simd_float4) -> simd_float4
     simd_mul(_ __x: simd_float4x4, _ __y: simd_float4x4) -> simd_float4x4
     simd_sub(_ __x: simd_float4x4, _ __y: simd_float4x4) -> simd_float4x4
     simd_transpose(_ __x: simd_float4x4) -> simd_float4x4
     matrix_identity_float4x4: simd_float4x4
     
     */
    public static func * (lhs: Mat4x4f, rhs: Mat4x4f) -> Mat4x4f {
        return simd_mul(lhs, rhs)
    }

    public static func * (lhs: Float, rhs: Mat4x4f) -> Mat4x4f {
        return simd_mul(lhs, rhs)
    }

    public static func * (lhs: Vec4f, rhs: Mat4x4f) -> Vec4f {
        return simd_mul(lhs, rhs)
    }

    public static func * (lhs: Mat4x4f, rhs: Vec4f) -> Vec4f {
        return simd_mul(lhs, rhs)
    }
}

// MARK: - unused
extension Mat4x4f {
    /*
     @inlinable public static func projectionPerspective2(fovy fovyRadians: Float, width: Float, height: Float, zNear: Float, zFar: Float) -> Mat4x4f {
     // see: https://github.com/EpicGames/UnrealEngine/blob/master/Engine/Source/Runtime/Core/Public/Math/PerspectiveMatrix.h#L81
     
     precondition(fovyRadians > 0.0, "Field of view must be greater than 0.0")
     precondition(width > 0.0, "Width must be greater than 0.0")
     precondition(height > 0.0, "Height must be greater than 0.0")
     precondition(zNear > 0.0, "zNear must be greater than 0.0")
     precondition(zFar > zNear, "zFar must be greater than zNear and greater than 0.0")
     
     let cotan: Float = tanf(fovyRadians / 2.0)
     
     
     let m00: Float = 1.0 / cotan
     let m11: Float = width / cotan / height
     let m22: Float = zFar / (zFar - zNear)
     let m23: Float = 1.0
     let m32: Float = -zNear * zFar / (zFar - zNear)
     let m33: Float = 0.0
     
     
     return Mat4x4f(Vec4f(m00, 0, 0, 0),
     Vec4f(0, m11, 0, 0),
     Vec4f(0, 0, m22, m23),
     Vec4f(0, 0, m32, m33))
     }
     
     */

    /*
     @inlinable public var eulerAngles: Vec3f {
     
     let a11: Float = self[0][0]
     let a22: Float = self[1][1]
     let a33: Float = self[2][2]
     
     let a32: Float = self[2][1]
     let a23: Float = self[1][2]
     
     let a13: Float = self[0][2]
     let a31: Float = self[2][0]
     
     let a21: Float = self[1][0]
     let a12: Float = self[0][1]
     
     let θ: Float = acos((a11+a22+a33-1.0) / 2.0)
     
     let sinθ2: Float = 2 * sin(θ)
     
     let e1: Float = (a32 - a23) / sinθ2
     
     let e2: Float = (a13 - a31) / sinθ2
     
     let e3: Float = (a21 - a12) / sinθ2
     
     return Vec3f(e1, e2, e3)
     }
     */

    /*
     @inlinable public var eulerAngles: Vec3f {
     let sy: Float = sqrt(self[0][0] * self[0][0] + self[1][0] * self[1][0])
     
     let singular: Bool = sy < 1e-6; // If
     
     let x: Float, y: Float, z: Float
     if !singular
     {
     x = atan2(self[2][1] , self[2][2])
     y = atan2(-self[2][0], sy)
     z = atan2(self[1][0], self[0][0])
     }
     else
     {
     x = atan2(-self[1][2], self[1][1])
     y = atan2(-self[2][0], sy)
     z = 0
     }
     return Vec3f(x, y, z)
     }
     */

    /*
    @inlinable public var eulerAngles: Vec3f {
        /// https://www.geometrictools.com/Documentation/EulerAngles.pdf
        
        let thetaX: Float, thetaY: Float, thetaZ: Float
        
        if self[0][2] < 1.0 {
            if self[0][2] > -1.0 {
                thetaX = atan2(-self[1][2],self[2][2])
                thetaY = asin(self[0][2])
                thetaZ = atan2(-self[0][1],self[0][0])
            }
            else  { // r02 = −1
                
                thetaX = -atan2(self[1][0],self[1][1])
                thetaY = -.pi / 2.0
                thetaZ = 0
            }
            
        }
        else  { // r02 = +1
            
            thetaX = atan2(self[1][0],self[1][1])
            thetaY = .pi / 2.0
            thetaZ = 0
            
        }
        return Vec3f(thetaX, thetaY, thetaZ)
    }
    */

    /*
    @inlinable public var eulerAngles: Vec3f {
        /// see: https://stackoverflow.com/a/37558238
        let yaw: Float = atan2(self[1][0],self[0][0])
        let sq = sqrt((self[2][1] * self[2][1]) + (self[2][2] * self[2][2]))
        let pitch: Float = atan2(-self[2][0],sq)
        let roll: Float = atan2(self[2][1],self[2][2])
        
        return Vec3f(yaw, pitch, roll)
    }*/

    // FIXME: order of angles is wrong
    @inlinable internal var _eulerAngles: Vec3f {
        // https://github.com/JOML-CI/JOML/blob/master/src/org/joml/Matrix3f.java#L4158
        let m12: Float = self[1][2]
        let m22: Float = self[2][2]
        let m02: Float = self[0][2]

        let m01: Float = self[0][1]
        let m00: Float = self[0][0]

        let x = atan2(m12, m22)
        let y = atan2(-m02, sqrt(m12 * m12 + m22 * m22))
        let z = atan2(m01, m00)
        return Vec3f(x, y, z)
    }

    // FIXME: order of angles is wrong
    @inlinable internal var _rotationAngles: Vec3f {
            let rotX = atan2( self[1][2], self[2][2])
            let rotY = atan2(-self[0][2], hypot(self[1][2], self[2][2]))
            let rotZ = atan2( self[0][1], self[0][0])
            return Vec3f(rotX, rotY, rotZ)
        }
}
