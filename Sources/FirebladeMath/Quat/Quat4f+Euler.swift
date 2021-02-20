//
//  Quat4f+Euler.swift
//
//
//  Created by Christian Treffs on 19.02.21.
//

// https://www.geometrictools.com/Documentation/EulerAngles.pdf
// https://ntrs.nasa.gov/api/citations/19770024290/downloads/19770024290.pdf
// https://marc-b-reynolds.github.io/math/2017/04/18/TaitEuler.html
// http://www.euclideanspace.com/maths/geometry/rotations/conversions/quaternionToEuler/
// https://github.com/godotengine/godot/blob/master/core/math/basis.cpp
// https://github.com/LinuxCNC/linuxcnc/blob/master/src/libnml/posemath/_posemath.c
// https://github.com/OGRECave/ogre/blob/84ae9396322a39f766b7acaeb9a1b15f4c51d261/OgreMain/src/OgreMatrix3.cpp#L858
// https://github.com/g-truc/glm/blob/master/glm/gtx/euler_angles.inl
// https://github.com/bulletphysics/bullet3/blob/abea1a848411cf53385fb8288c89db05e5751ef7/src/Bullet3Common/b3Quaternion.h#L162
// https://github.com/demianmnave/CML/blob/9ebc0ed72637959fe7323d2a6a12664236509031/cml/mathlib/quaternion/rotation.h#L101
// http://de.mathworks.com/matlabcentral/fileexchange/20696-function-to-convert-between-dcm--euler-angles--quaternions--and-euler-vectors
// https://scholar.google.de/scholar?cluster=3204262265835591787
// http://de.mathworks.com/help/robotics/ref/quat2eul.html
// https://math.stackexchange.com/a/1803746
// https://hanspeterschaub.info/AVS-Code.html
// https://marc-b-reynolds.github.io/math/2017/04/18/TaitEuler.html

extension Quat4f {
    //  public static func fromEulerAngles_121(_ e: Vec3f) -> Quat4f {
    //      let e1 = e.x / 2
    //      let e2 = e.y / 2
    //      let e3 = e.z / 2
    //
    //      let q4 = cos(e2) * cos(e1 + e3)
    //      let q3 = cos(e2) * sin(e1 + e3)
    //      let q2 = sin(e2) * cos(e1 - e3)
    //      let q1 = sin(e2) * sin(e1 - e3)
    //
    //      return Quat4f(q1, q2, q3, q4)
    //  }

    public static func fromEulerAngles_123(_ e: Vec3f) -> Quat4f {
        let c1 = cos(e.x / 2)
        let s1 = sin(e.x / 2)
        let c2 = cos(e.y / 2)
        let s2 = sin(e.y / 2)
        let c3 = cos(e.z / 2)
        let s3 = sin(e.z / 2)

        let q4 = c1 * c2 * c3 - s1 * s2 * s3
        let q3 = s1 * c2 * c3 + c1 * s2 * s3
        let q2 = c1 * s2 * c3 - s1 * c2 * s3
        let q1 = c1 * c2 * s3 + s1 * s2 * c3

        return Quat4f(q1, q2, q3, q4)
    }

    // public static func fromEulerAngles_131(_ e: Vec3f) -> Quat4f {
    //     let e1 = e.x / 2
    //     let e2 = e.y / 2
    //     let e3 = e.z / 2
    //
    //     let q4 = cos(e2) * cos(e1 + e3)
    //     let q3 = cos(e2) * sin(e1 + e3)
    //     let q2 = sin(e2) * sin(-e1 + e3)
    //     let q1 = sin(e2) * cos(-e1 + e3)
    //
    //     return Quat4f(q1, q2, q3, q4)
    // }

    public static func fromEulerAngles_132(_ e: Vec3f) -> Quat4f {
        let c1 = cos(e.x / 2)
        let s1 = sin(e.x / 2)
        let c2 = cos(e.y / 2)
        let s2 = sin(e.y / 2)
        let c3 = cos(e.z / 2)
        let s3 = sin(e.z / 2)

        let q4 = c1 * c2 * c3 + s1 * s2 * s3
        let q3 = s1 * c2 * c3 - c1 * s2 * s3
        let q2 = c1 * c2 * s3 - s1 * s2 * c3
        let q1 = c1 * s2 * c3 + s1 * c2 * s3

        return Quat4f(q1, q2, q3, q4)
    }

    //  public static func fromEulerAngles_212(_ e: Vec3f) -> Quat4f {
    //      let e1 = e.x / 2
    //      let e2 = e.y / 2
    //      let e3 = e.z / 2
    //
    //      let q4 = cos(e2) * cos(e1 + e3)
    //      let q3 = sin(e2) * cos(-e1 + e3)
    //      let q2 = cos(e2) * sin(e1 + e3)
    //      let q1 = sin(e2) * sin(-e1 + e3)
    //
    //      return Quat4f(q1, q2, q3, q4)
    //  }

    public static func fromEulerAngles_213(_ e: Vec3f) -> Quat4f {
        let c1 = cos(e.x / 2)
        let s1 = sin(e.x / 2)
        let c2 = cos(e.y / 2)
        let s2 = sin(e.y / 2)
        let c3 = cos(e.z / 2)
        let s3 = sin(e.z / 2)

        let q4 = c1 * c2 * c3 + s1 * s2 * s3
        let q3 = c1 * s2 * c3 + s1 * c2 * s3
        let q2 = s1 * c2 * c3 - c1 * s2 * s3
        let q1 = c1 * c2 * s3 - s1 * s2 * c3

        return Quat4f(q1, q2, q3, q4)
    }

    public static func fromEulerAngles_231(_ e: Vec3f) -> Quat4f {
        let c1 = cos(e.x / 2)
        let s1 = sin(e.x / 2)
        let c2 = cos(e.y / 2)
        let s2 = sin(e.y / 2)
        let c3 = cos(e.z / 2)
        let s3 = sin(e.z / 2)

        let q4 = c1 * c2 * c3 - s1 * s2 * s3
        let q3 = c1 * c2 * s3 + s1 * s2 * c3
        let q2 = s1 * c2 * c3 + c1 * s2 * s3
        let q1 = c1 * s2 * c3 - s1 * c2 * s3

        return Quat4f(q1, q2, q3, q4)
    }

    // public static func fromEulerAngles_232(_ e: Vec3f) -> Quat4f {
    //     let e1 = e.x / 2
    //     let e2 = e.y / 2
    //     let e3 = e.z / 2
    //
    //     let q4 = cos(e2) * cos(e1 + e3)
    //     let q3 = sin(e2) * sin(e1 - e3)
    //     let q2 = cos(e2) * sin(e1 + e3)
    //     let q1 = sin(e2) * cos(e1 - e3)
    //
    //     return Quat4f(q1, q2, q3, q4)
    // }

    public static func fromEulerAngles_312(_ e: Vec3f) -> Quat4f {
        let c1 = cos(e.x / 2)
        let s1 = sin(e.x / 2)
        let c2 = cos(e.y / 2)
        let s2 = sin(e.y / 2)
        let c3 = cos(e.z / 2)
        let s3 = sin(e.z / 2)

        let q4 = c1 * c2 * c3 - s1 * s2 * s3
        let q3 = c1 * s2 * c3 - s1 * c2 * s3
        let q2 = c1 * c2 * s3 + s1 * s2 * c3
        let q1 = s1 * c2 * c3 + c1 * s2 * s3

        return Quat4f(q1, q2, q3, q4)
    }

    // public static func fromEulerAngles_313(_ e: Vec3f) -> Quat4f {
    //     let e1 = e.x / 2
    //     let e2 = e.y / 2
    //     let e3 = e.z / 2
    //
    //     let q4 = cos(e2) * cos(e1 + e3)
    //     let q3 = sin(e2) * cos(e1 - e3)
    //     let q2 = sin(e2) * sin(e1 - e3)
    //     let q1 = cos(e2) * sin(e1 + e3)
    //
    //     return Quat4f(q1, q2, q3, q4)
    // }

    public static func fromEulerAngles_321(_ e: Vec3f) -> Quat4f {
        let c1 = cos(e.x / 2)
        let s1 = sin(e.x / 2)
        let c2 = cos(e.y / 2)
        let s2 = sin(e.y / 2)
        let c3 = cos(e.z / 2)
        let s3 = sin(e.z / 2)

        let q4 = c1 * c2 * c3 + s1 * s2 * s3
        let q3 = c1 * c2 * s3 - s1 * s2 * c3
        let q2 = c1 * s2 * c3 + s1 * c2 * s3
        let q1 = s1 * c2 * c3 - c1 * s2 * s3

        return Quat4f(q1, q2, q3, q4)
    }

    // public static func fromEulerAngles_323(_ e: Vec3f) -> Quat4f {
    //    let e1 = e.x / 2
    //    let e2 = e.y / 2
    //    let e3 = e.z / 2

    //    let q4 = cos(e2) * cos(e1 + e3)
    //    let q3 = sin(e2) * sin(-e1 + e3)
    //    let q2 = sin(e2) * cos(-e1 + e3)
    //    let q1 = cos(e2) * sin(e1 + e3)

    //    return Quat4f(q1, q2, q3, q4)
    // }
}

// MARK: - Quaternion to euler angles

// public func quaternionToEulerAngles_121(_ q: Quat4f) -> Vec3f {
//    let t1 = atan2(q.w, q.z)
//    let t2 = atan2(q.y, q.x)
//
//    let e1 = t1 + t2
//    let e2 = 2 * acos(sqrt(q.x * q.x + q.y * q.y))
//    let e3 = t2 - t1
//
//    return Vec3f(e1, e2, e3)
// }

public func quaternionToEulerAngles_123(_ q: Quat4f) -> Vec3f {
    let q0 = q.w
    let q1 = q.z
    let q2 = q.y
    let q3 = q.x

    let e1 = atan2(-2 * (q2 * q3 - q0 * q1), q0 * q0 - q1 * q1 - q2 * q2 + q3 * q3)
    let e2 = asin(2 * (q1 * q3 + q0 * q2))
    let e3 = atan2(-2 * (q1 * q2 - q0 * q3), q0 * q0 + q1 * q1 - q2 * q2 - q3 * q3)

    return Vec3f(e1, e2, e3)
}

// public func quaternionToEulerAngles_131(_ q: Quat4f) -> Vec3f {
//    let t1 = atan2(q.z, q.w)
//    let t2 = atan2(q.y, q.x)
//
//    let e1 = t2 - t1
//    let e2 = 2 * acos(sqrt(q.x * q.x + q.y * q.y))
//    let e3 = t2 + t1
//    return Vec3f(e1, e2, e3)
// }

public func quaternionToEulerAngles_132(_ q: Quat4f) -> Vec3f {
    let q0 = q.w
    let q1 = q.z
    let q2 = q.y
    let q3 = q.x

    let e1 = atan2(2 * (q2 * q3 + q0 * q1), q0 * q0 - q1 * q1 + q2 * q2 - q3 * q3)
    let e2 = asin(-2 * (q1 * q2 - q0 * q3))
    let e3 = atan2(2 * (q1 * q3 + q0 * q2), q0 * q0 + q1 * q1 - q2 * q2 - q3 * q3)

    return Vec3f(e1, e2, e3)
}

// public func quaternionToEulerAngles_212(_ q: Quat4f) -> Vec3f {
//    let t1 = atan2(q.w, q.y)
//    let t2 = atan2(q.z, q.x)
//
//    let e1 = t2 - t1
//    let e2 = 2 * acos(sqrt(q.x * q.x + q.z * q.z))
//    let e3 = t2 + t1
//
//    return Vec3f(e1, e2, e3)
// }

public func quaternionToEulerAngles_213(_ q: Quat4f) -> Vec3f {
    let q0 = q.w
    let q1 = q.z
    let q2 = q.y
    let q3 = q.x

    let e1 = atan2(2 * (q1 * q3 + q0 * q2), q0 * q0 - q1 * q1 - q2 * q2 + q3 * q3)
    let e2 = asin(-2 * (q2 * q3 - q0 * q1))
    let e3 = atan2(2 * (q1 * q2 + q0 * q3), q0 * q0 - q1 * q1 + q2 * q2 - q3 * q3)

    return Vec3f(e1, e2, e3)
}

public func quaternionToEulerAngles_231(_ q: Quat4f) -> Vec3f {
    let q0 = q.w
    let q1 = q.z
    let q2 = q.y
    let q3 = q.x

    let e1 = atan2(-2 * (q1 * q3 - q0 * q2), q0 * q0 + q1 * q1 - q2 * q2 - q3 * q3)
    let e2 = asin(2 * (q1 * q2 + q0 * q3))
    let e3 = atan2(-2 * (q2 * q3 - q0 * q1), q0 * q0 - q1 * q1 + q2 * q2 - q3 * q3)

    return Vec3f(e1, e2, e3)
}

// public func quaternionToEulerAngles_232(_ q: Quat4f) -> Vec3f {
//    let t1 = atan2(q.y, q.w)
//    let t2 = atan2(q.z, q.x)
//
//    let e1 = t1 + t2
//    let e2 = 2 * acos(sqrt(q.x * q.x + q.z * q.z))
//    let e3 = t2 - t1
//
//    return Vec3f(e1, e2, e3)
// }

public func quaternionToEulerAngles_312(_ q: Quat4f) -> Vec3f {
    let q0 = q.w
    let q1 = q.z
    let q2 = q.y
    let q3 = q.x

    let e1 = atan2(-2 * (q1 * q2 - q0 * q3), q0 * q0 - q1 * q1 + q2 * q2 - q3 * q3)
    let e2 = asin(2 * (q2 * q3 + q0 * q1))
    let e3 = atan2(-2 * (q1 * q3 - q0 * q2), q0 * q0 - q1 * q1 - q2 * q2 + q3 * q3)

    return Vec3f(e1, e2, e3)
}

// public func quaternionToEulerAngles_313(_ q: Quat4f) -> Vec3f {
//    let t1 = atan2(q.z, q.y)
//    let t2 = atan2(q.w, q.x)
//
//    let e1 = t1 + t2
//    let e2 = 2 * acos(sqrt(q.x * q.x + q.w * q.w))
//    let e3 = t2 - t1
//
//    return Vec3f(e1, e2, e3)
// }

public func quaternionToEulerAngles_321(_ q: Quat4f) -> Vec3f {
    let q0 = q.w
    let q1 = q.z
    let q2 = q.y
    let q3 = q.x

    let e1 = atan2(2 * (q1 * q2 + q0 * q3), q0 * q0 + q1 * q1 - q2 * q2 - q3 * q3)
    let e2 = asin(-2 * (q1 * q3 - q0 * q2))
    let e3 = atan2(2 * (q2 * q3 + q0 * q1), q0 * q0 - q1 * q1 - q2 * q2 + q3 * q3)

    return Vec3f(e1, e2, e3)
}

// public func quaternionToEulerAngles_323(_ q: Quat4f) -> Vec3f {
//    let t1 = atan2(q.y, q.z)
//    let t2 = atan2(q.w, q.x)
//
//    let e1 = t2 - t1
//    let e2 = 2 * acos(sqrt(q.x * q.x + q.w * q.w))
//    let e3 = t2 + t1
//
//    return Vec3f(e1, e2, e3)
// }
