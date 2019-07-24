//
//  Mat4x4f+Transforms.swift
//  FirebladeGFX
//
//  Created by Christian Treffs on 27.01.18.
//  Copyright © 2018 Fireblade. All rights reserved.
//

/*
// SEE: https://github.com/g-truc/glm/blob/master/glm/gtc/matrix_transform.inl
public extension Mat4x4f {
    init(translation: Vec3f = .zero, scale: Vec3f = .one) {
        
        
        self.init([Vec4f(scale.x, 0, 0, 0),
                   Vec4f(0, scale.y, 0, 0),
                   Vec4f(0, 0, scale.z, 0),
                   Vec4f(translation, 1)])
    }
    
    init(angle radians: AngleRadians, axis: Vec3f) {
        let v: Vec3f = normalize(axis)
        let cos: Float = cosf(radians)
        let cosp: Float = 1.0 - cos
        let sin: Float = sinf(radians)
        
        self.init([
            Vec4f(cos + cosp * v[0] * v[0],
             cosp * v[0] * v[1] + v[2] * sin,
             cosp * v[0] * v[2] - v[1] * sin,
             0.0),
            Vec4f(cosp * v[0] * v[1] - v[2] * sin,
             cos + cosp * v[1] * v[1],
             cosp * v[1] * v[2] + v[0] * sin,
             0.0),
            Vec4f(cosp * v[0] * v[2] + v[1] * sin,
             cosp * v[1] * v[2] - v[0] * sin,
             cos + cosp * v[2] * v[2],
             0.0),
            Vec4f(0.0,
             0.0,
             0.0,
             1.0)
        ])
    }
    
    /// Euler angles in radians.
    init(eulerAngles: Vec3f) {
        let sx = sin(eulerAngles.x)
        let cx = cos(eulerAngles.x)
        let sy = sin(eulerAngles.y)
        let cy = cos(eulerAngles.y)
        let sz = sin(eulerAngles.z)
        let cz = cos(eulerAngles.z)
        
        self.init([ Vec4f(           cy * cz, cy * sz, -sy, 0),
                    Vec4f(cz * sx * sy - cx * sz, cx * cz + sx * sy * sz, cy * sx, 0),
                    Vec4f(cx * cz * sy + sx * sz, -cz * sx + cx * sy * sz, cx * cy, 0),
                    Vec4f(               0, 0, 0, 1) ])
    }
    
    
    @inlinable var upperLeft: Mat3x3f {
        return Mat3x3f(self[0].xyz,
                       self[1].xyz,
                       self[2].xyz)
    }
    
    /// The direction along the x-axis.
    @inlinable var right: Vec3f {
        return columns.0.xyz
    }
    
    /// The direction along the y-axis.
    @inlinable var up: Vec3f {
        return columns.1.xyz
    }
    
    /// The direction along the z-axis.
    @inlinable var forward: Vec3f {
        return columns.2.xyz
    }
    
    @inlinable var translation: Vec3f {
        return columns.3.xyz
    }
    
    @inlinable var scale: Vec3f {
        return Vec3f(columns.0.length,
                     columns.1.length,
                     columns.2.length)
    }
    
    @inlinable var eulerAngles: Vec3f {
        return upperLeft.rotationEuler
    }
    
    @inlinable var orientation: Quat4f {
        return simd_quaternion(self)
    }
    
    /// Creates a perspective projection matrix
    ///
    /// - Parameters:
    ///   - fovy: field of view
    ///   - aspect: aspect ratio
    ///   - zNear: near plane
    ///   - zFar: far plane
    /// - Returns: perspective projection matrix
    static func perspectiveProjection(fovy: AngleRadians, aspect: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        assert(aspect > 0.0)
        assert(zNear > 0.0)
        assert(zFar > zNear)
        assert(fovy > AngleRadians(0.0))
        //TODO: Float.pi - FLT_EPSILON
        //TODO: precondition(fovy <= Angle<T>(radians: T.pi - T.epsilon))
        
        switch kCoordinateSystem {
        case .leftHanded:
            return perspectiveProjectionLH(fovy: fovy, aspect: aspect, zNear: zNear, zFar: zFar)
            
        case .rightHanded:
            return perspectiveProjectionRH(fovy: fovy, aspect: aspect, zNear: zNear, zFar: zFar)
        }
    }
    // swiftlint:disable identifier_name
    /// Constructs a view matrix that is positioned at `eye` and looks toward `center`,
    /// with the `up` pointing up.
    ///
    /// - Parameters:
    ///   - eye: eye position
    ///   - center: look point
    ///   - up: up vector
    /// - Returns: view matrix
    static func lookAt(eye: Vec3f, center: Vec3f, up: Vec3f) -> Mat4x4f {
        let z: Vec3f = normalize(eye - center)
        let x: Vec3f = normalize(cross(up, z))
        let y: Vec3f = cross(z, x)
        let t = Vec3f(-dot(x, eye), -dot(y, eye), -dot(z, eye))
        
        return Mat4x4f(
            columns:
            (
                Vec4f(x.x, y.x, z.x, 0.0),
                Vec4f(x.y, y.y, z.y, 0.0),
                Vec4f(x.z, y.z, z.z, 0.0),
                Vec4f(t.x, t.y, t.z, 1.0)
            )
        )
    }
    
    /// https://www.scratchapixel.com/lessons/mathematics-physics-for-computer-graphics/lookat-function
    /// https://learnopengl.com/Getting-started/Camera
    static func lookAt(from: Vec3f, to: Vec3f, upAxis: Vec3f = .axisY) -> Mat4x4f {
        let forward: Vec3f = normalize(from - to)
        let right: Vec3f = cross(normalize(upAxis), forward)
        let up: Vec3f = cross(forward, right)
        
        return Mat4x4f(Vec4f(forward, 0),
                       Vec4f(right, 0),
                       Vec4f(up, 0),
                       Vec4f(from, 1))
    }
    
    /*
     
     @inlinable var orientation: Quat4f {
     get {
     return simd_quaternion(self)
     }
     set {
     self = simd_matrix4x4(newValue)
     }
     }
     */
    
    /*static func rotation(angle: AngleRadians, axis: Vec3f) -> Mat4x4f {
     let unitAxis: Vec3f = normalize(axis)
     let cost: Float = cos(angle)
     let sint: Float = sin(angle)
     let cosi: Float = 1 - cost
     let x: Float = unitAxis.x
     let y: Float = unitAxis.y
     let z: Float = unitAxis.z
     return Mat4x4f(
     columns:
     (
     Vec4f(    cost + x * x * cosi, y * x * cosi + z * sint, z * x * cosi - y * sint, 0),
     Vec4f(x * y * cosi - z * sint, cost + y * y * cosi, z * y * cosi + x * sint, 0),
     Vec4f(x * z * cosi + y * sint, y * z * cosi - x * sint, cost + z * z * cosi, 0),
     Vec4f(                  0, 0, 0, 1)
     )
     )
     }*/
    
    /*init(translation: Vec3f, scale: Vec3f, orientation: Quat4f) {
     // Ordering:
     //    1. Scale
     //    2. Rotate
     //    3. Translate
     
     // TRS
     self = Mat4x4f(translation: translation) * Mat4x4f(orientation: orientation) * Mat4x4f(scale: scale)
     // SRT
     //self = Mat4x4f(scale: scale) * Mat4x4f(orientation: orientation) * Mat4x4f(translation: translation)
     
     
     
     /*
     
     simd_matrix4x4(orientation)
     
     let rot: Mat3x3f = simd_matrix3x3(orientation)
     var mat = Mat4x4f.identity
     
     mat[0][0] = scale.x * rot[0][0]; mat[0][1] = scale.y * rot[0][1]; mat[0][2] = scale.z * rot[0][2]; mat[0][3] = 0
     mat[1][0] = scale.x * rot[1][0]; mat[1][1] = scale.y * rot[1][1]; mat[1][2] = scale.z * rot[1][2]; mat[1][3] = 0
     mat[2][0] = scale.x * rot[2][0]; mat[2][1] = scale.y * rot[2][1]; mat[2][2] = scale.z * rot[2][2]; mat[2][3] = 0
     mat[3][0] = position.x; mat[3][1] = position.y; mat[3][2] = position.z; mat[3][3] = 1
     
     self = mat
     
     */
     }*/
}

// MARK: - private

private extension Mat4x4f {
    static func perspectiveProjectionLH(fovy: AngleRadians, aspect: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        var mat = Mat4x4f(0.0)
        
        let tanHalfFovy: Float = tan(fovy * 0.5)
        
        mat[0][0] = 1.0 / (aspect * tanHalfFovy)
        mat[1][1] = 1.0 / tanHalfFovy
        mat[2][3] = 1.0
        
        switch kDepthClipSpace {
        case .zeroToOne:
            mat[2][2] = zFar / (zFar - zNear)
            mat[3][2] = -(zFar * zNear) / (zFar - zNear)
            
        case .negOneToOne:
            mat[2][2] = (zFar + zNear) / (zFar - zNear)
            mat[3][2] = -(zFar * zNear * 2.0) / (zFar - zNear)
        }
        
        return mat
    }
    
    static func perspectiveProjectionRH(fovy: AngleRadians, aspect: Float, zNear: Float, zFar: Float) -> Mat4x4f {
        var mat = Mat4x4f(0.0)
        
        let tanHalfFovy: Float = tan(fovy * 0.5)
        
        mat[0][0] = 1.0 / (aspect * tanHalfFovy)
        mat[1][1] = 1.0 / tanHalfFovy
        mat[2][3] = -1.0
        
        switch kDepthClipSpace {
        case .zeroToOne:
            mat[2][2] = zFar / (zNear - zFar)
            mat[3][2] = -(zFar * zNear) / (zFar - zNear)
            
        case .negOneToOne:
            mat[2][2] = -(zFar + zNear) / (zFar - zNear)
            mat[3][2] = -(zFar * zNear * 2.0) / (zFar - zNear)
        }
        
        return mat
    }
}

// FIXME: --- refactor
/*func matrix_perspective_right_hand(fovyRadians fovy: Float, aspectRatio: Float, nearZ: Float, farZ: Float) -> matrix_float4x4 {
 let ys: Float = 1 / tanf(fovy * 0.5)
 let xs: Float = ys / aspectRatio
 let zs: Float = farZ / (nearZ - farZ)
 return matrix_float4x4.init(columns: (vector_float4(xs, 0, 0, 0),
 vector_float4( 0, ys, 0, 0),
 vector_float4( 0, 0, zs, -1),
 vector_float4( 0, 0, zs * nearZ, 0)))
 }*/
*/
