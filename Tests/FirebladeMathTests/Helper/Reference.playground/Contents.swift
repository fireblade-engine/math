import GLKit
import SceneKit
import simd

// MARK: - Mat4x4f
let trans = GLKMatrix4Translate(GLKMatrix4Identity, 1.23, 4.56, 7.89)


let rotX = GLKMatrix4Rotate(GLKMatrix4Identity, radians(13), 1, 0, 0)
let rotY = GLKMatrix4Rotate(GLKMatrix4Identity, radians(53), 0, 1, 0)
let rotZ = GLKMatrix4Rotate(GLKMatrix4Identity, radians(79), 0, 0, 1)

let rotXZ = GLKMatrix4Rotate(GLKMatrix4Identity, radians(33), 1, 0, 1)



let quatMat = GLKMatrix4MakeWithQuaternion(GLKQuaternion(q: (1.23,4.56,7.89,0.12)))


let m0 = GLKMatrix4(m: (-0.963882,0.155028,0.216558,0.000000,
               0.110248,-0.507928,0.854315,0.000000,
               0.242439,0.847334,0.472491,0.000000,
               4.556310,64.323400,-2.345630,1.000000))

let t0 = GLKMatrix4Translate(m0, 7.56, 33.44, 98.32)


