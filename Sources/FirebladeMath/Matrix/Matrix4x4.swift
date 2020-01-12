//
//  Matrix4x4.swift
//
//
//  Created by Christian Treffs on 05.09.19.
//

public struct Matrix4x4<Storage> where Storage: Storage4x4Protocol {
    public typealias Value = Storage.Value
    public typealias Vector = Storage.Column

    @usableFromInline var storage: Storage

    public init(storage: Storage) {
        self.storage = storage
    }
}

extension Matrix4x4 {
    public init(diagonal: Vector) {
        self.storage = Storage(diagonal: diagonal)
    }

    public init(_ columns: [Vector]) {
        precondition(columns.count == 4, "Matrix needs exacty 4 Column vectors")
        self.storage = Storage(columns)
    }

    public init(_ column0: Vector, _ column1: Vector, _ column2: Vector, _ column3: Vector) {
        self.init([column0, column1, column2, column3])
    }

    public init(_ values: [Value]) {
        precondition(values.count == 16, "Matrix needs exactly 16 values")
        self.init([Vector(values[0...3]),
                   Vector(values[4...7]),
                   Vector(values[8...11]),
                   Vector(values[12...15])])
    }
}

extension Matrix4x4 {
    public subscript(column: Int, row: Int) -> Value {
        get {
            return storage[column, row]
        }
        set {
            storage[column, row] = newValue
        }
    }

    public subscript(index: Int) -> Value {
        get {
            return storage[index]
        }
        set {
            storage[index] = newValue
        }
    }
}

extension Matrix4x4: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Value...) {
        self.init(elements)
    }
}

extension Matrix4x4: Sequence {
    public __consuming func makeIterator() -> IndexingIterator<[Storage.Value]> {
        return storage.makeIterator() as! IndexingIterator<[Storage.Value]>
    }

    @inlinable public var elements: [Value] {
        return [Value](self)
    }
}

extension Matrix4x4 {
    // swiftlint:disable large_tuple
    @inlinable public var columns: (Vector, Vector, Vector, Vector) {
        return storage.columns
    }
}

extension Matrix4x4: Equatable {
    public static func ==(lhs: Matrix4x4<Storage>, rhs: Matrix4x4<Storage>) -> Bool {
        return lhs.storage == rhs.storage
    }
}

// MARK: - euler
extension Matrix4x4 {
    /*
     @inlinable public var eulerAnglesXYZ: SIMD3<Value> {
     return upperLeft.eulerAnglesXYZ
     }

     @inlinable public var eulerAnglesXZY: SIMD3<Value> {
     return upperLeft.eulerAnglesXZY
     }

     @inlinable public var eulerAnglesYXZ: SIMD3<Value> {
     return upperLeft.eulerAnglesYXZ
     }

     @inlinable public var eulerAnglesZXY: SIMD3<Value> {
     return upperLeft.eulerAnglesZXY
     }

     @inlinable public var eulerAnglesZYX: SIMD3<Value> {
     return upperLeft.eulerAnglesZYX
     }*/
}

// MARK: - unused
extension Matrix4x4 {
    /*
     @inlinable public static func projectionPerspective2(fovy fovyRadians: Value, width: Value, height: Value, zNear: Value, zFar: Value) -> Matrix4x4 {
     // see: https://github.com/EpicGames/UnrealEngine/blob/master/Engine/Source/Runtime/Core/Public/Math/PerspectiveMatrix.h#L81

     precondition(fovyRadians > 0.0, "Field of view must be greater than 0.0")
     precondition(width > 0.0, "Width must be greater than 0.0")
     precondition(height > 0.0, "Height must be greater than 0.0")
     precondition(zNear > 0.0, "zNear must be greater than 0.0")
     precondition(zFar > zNear, "zFar must be greater than zNear and greater than 0.0")

     let cotan: Value = tanf(fovyRadians / 2.0)


     let m00: Value = 1.0 / cotan
     let m11: Value = width / cotan / height
     let m22: Value = zFar / (zFar - zNear)
     let m23: Value = 1.0
     let m32: Value = -zNear * zFar / (zFar - zNear)
     let m33: Value = 0.0


     return Matrix4x4(Column(m00, 0, 0, 0),
     Column(0, m11, 0, 0),
     Column(0, 0, m22, m23),
     Column(0, 0, m32, m33))
     }

     */

    /*
     @inlinable public var eulerAngles: SIMD3<Value> {

     let a11: Value = self[0][0]
     let a22: Value = self[1][1]
     let a33: Value = self[2][2]

     let a32: Value = self[2][1]
     let a23: Value = self[1][2]

     let a13: Value = self[0][2]
     let a31: Value = self[2][0]

     let a21: Value = self[1][0]
     let a12: Value = self[0][1]

     let θ: Value = acos((a11+a22+a33-1.0) / 2.0)

     let sinθ2: Value = 2 * sin(θ)

     let e1: Value = (a32 - a23) / sinθ2

     let e2: Value = (a13 - a31) / sinθ2

     let e3: Value = (a21 - a12) / sinθ2

     return SIMD3<Value>(e1, e2, e3)
     }
     */

    /*
     @inlinable public var eulerAngles: SIMD3<Value> {
     let sy: Value = sqrt(self[0][0] * self[0][0] + self[1][0] * self[1][0])

     let singular: Bool = sy < 1e-6; // If

     let x: Value, y: Value, z: Value
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
     return SIMD3<Value>(x, y, z)
     }
     */

    /*
     @inlinable public var eulerAngles: SIMD3<Value> {
     /// https://www.geometrictools.com/Documentation/EulerAngles.pdf

     let thetaX: Value, thetaY: Value, thetaZ: Value

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
     return SIMD3<Value>(thetaX, thetaY, thetaZ)
     }
     */

    /*
     @inlinable public var eulerAngles: SIMD3<Value> {
     /// see: https://stackoverflow.com/a/37558238
     let yaw: Value = atan2(self[1][0],self[0][0])
     let sq = sqrt((self[2][1] * self[2][1]) + (self[2][2] * self[2][2]))
     let pitch: Value = atan2(-self[2][0],sq)
     let roll: Value = atan2(self[2][1],self[2][2])

     return SIMD3<Value>(yaw, pitch, roll)
     }*/

    /*
     // FIXME: order of angles is wrong
     @inlinable internal var eulerAngles2: SIMD3<Value> {
     // https://github.com/JOML-CI/JOML/blob/master/src/org/joml/Matrix3f.java#L4158
     let m12: Value = self[1][2]
     let m22: Value = self[2][2]
     let m02: Value = self[0][2]

     let m01: Value = self[0][1]
     let m00: Value = self[0][0]

     let x = atan2(m12, m22)
     let y = atan2(-m02, sqrt(m12 * m12 + m22 * m22))
     let z = atan2(m01, m00)
     return SIMD3<Value>(x, y, z)
     }

     // FIXME: order of angles is wrong
     @inlinable internal var rotationAngles2: SIMD3<Value> {
     let rotX = atan2( self[1][2], self[2][2])
     let rotY = atan2(-self[0][2], hypot(self[1][2], self[2][2]))
     let rotZ = atan2( self[0][1], self[0][0])
     return SIMD3<Value>(rotX, rotY, rotZ)
     }
     */
}
