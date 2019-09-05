import GLKit
import SceneKit
import simd

// MARK: - Mat4x4f
let trans = GLKMatrix4Translate(GLKMatrix4Identity, 1.23, 4.56, 7.89)

let rotX = GLKMatrix4Rotate(GLKMatrix4Identity, radians(13), 1, 0, 0)
let rotY = GLKMatrix4Rotate(GLKMatrix4Identity, radians(53), 0, 1, 0)
let rotZ = GLKMatrix4Rotate(GLKMatrix4Identity, radians(79), 0, 0, 1)

let rotXZ = GLKMatrix4Rotate(GLKMatrix4Identity, radians(33), 1, 0, 1)

let quatMat = GLKMatrix4MakeWithQuaternion(GLKQuaternion(q: (1.23, 4.56, 7.89, 0.12)))

let m0 = GLKMatrix4(m: (-0.963_882, 0.155_028, 0.216_558, 0.000_000,
                        0.110_248, -0.507_928, 0.854_315, 0.000_000,
                        0.242_439, 0.847_334, 0.472_491, 0.000_000,
                        4.556_310, 64.323_400, -2.345_630, 1.000_000))

let t0 = GLKMatrix4Translate(m0, 7.56, 33.44, 98.32)

let s0 = GLKMatrix4Scale(m0, 3.23, 0.543, -4.5)

let r0 = GLKMatrix4Rotate(m0, radians(91), 0, 1, 1)

let look = GLKMatrix4MakeLookAt(10.0, 45.0, -3.0,
                                4.0, 6.4, 0.45,
                                0.0, 1.0, 0.0)

let perspective = GLKMatrix4MakePerspective(radians(83.7), 2880.0 / 1800.0, 0.001, 100.0)

let width: Float = 2880.0
let height: Float = 1800.0
let ortho = GLKMatrix4MakeOrtho(-width / 2.0, width / 2.0, -height / 2.0, height / 2.0, 0.001, 100.0)

// MARK: - Quat4f

let qI = GLKQuaternionIdentity
qI

let q = GLKQuaternion(q: (1.23, 4.56, 7.89, 0.12))
q

String(format: "%.7f", GLKQuaternionLength(q))

let axisVec = GLKQuaternionAxis(q)
axisVec

let angle = GLKQuaternionAngle(q)
String(format: "%.7f", angle)

let invQ = GLKQuaternionInvert(q)
invQ

let conj = GLKQuaternionConjugate(q)
conj

let qNorm = GLKQuaternionNormalize(q)
qNorm

let q0 = GLKQuaternion(q: (1, 2, 3, 4))
let q1 = GLKQuaternion(q: (4, 3, 2, 1))
let q2 = GLKQuaternion(q: (1, 2, 3, 1))

GLKQuaternionMultiply(q0, q1)
GLKQuaternionAdd(q0, q1)
GLKQuaternionSubtract(q0, q1)

GLKQuaternionMakeWithAngleAndAxis(radians(33), 1, 0, 0)
GLKQuaternionMakeWithAngleAndAxis(radians(51), 0, 1, 0)
GLKQuaternionMakeWithAngleAndAxis(radians(79), 0, 0, 1)

GLKQuaternionMakeWithAngleAndAxis(radians(123), 1, 1, 0)

let mat3x3rot = GLKMatrix3MakeRotation(radians(33), 1, 0, 1)
GLKQuaternionMakeWithMatrix3(mat3x3rot)

let mat4x4rot = GLKMatrix4MakeRotation(radians(33), 1, 0, 1)
GLKQuaternionMakeWithMatrix4(mat4x4rot)

GLKQuaternionRotateVector3(q2, GLKVector3Make(5, 6, 7)) // aka act
