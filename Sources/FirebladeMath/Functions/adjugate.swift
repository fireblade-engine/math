//
//  adjugate.swift
//
//
//  Created by Christian Treffs on 02.09.20.
//

public func adjugate(_ inMat: Mat4x4f) -> Mat4x4f {
    var out = Mat4x4f.identity

    out[0, 0] = inMat[1, 1] * inMat[2, 2] * inMat[3, 3] - inMat[1, 1] * inMat[2, 3] * inMat[3, 2]
    out[0, 0] += -inMat[2, 1] * inMat[1, 2] * inMat[3, 3] + inMat[2, 1] * inMat[1, 3] * inMat[3, 2]
    out[0, 0] += inMat[3, 1] * inMat[1, 2] * inMat[2, 3] - inMat[3, 1] * inMat[1, 3] * inMat[2, 2]

    out[1, 0] = -inMat[1, 0] * inMat[2, 2] * inMat[3, 3] + inMat[1, 0] * inMat[2, 3] * inMat[3, 2]
    out[1, 0] += inMat[2, 0] * inMat[1, 2] * inMat[3, 3] - inMat[2, 0] * inMat[1, 3] * inMat[3, 2]
    out[1, 0] += -inMat[3, 0] * inMat[1, 2] * inMat[2, 3] + inMat[3, 0] * inMat[1, 3] * inMat[2, 2]

    out[2, 0] = inMat[1, 0] * inMat[2, 1] * inMat[3, 3] - inMat[1, 0] * inMat[2, 3] * inMat[3, 1]
    out[2, 0] += -inMat[2, 0] * inMat[1, 1] * inMat[3, 3] + inMat[2, 0] * inMat[1, 3] * inMat[3, 1]
    out[2, 0] += inMat[3, 0] * inMat[1, 1] * inMat[2, 3] - inMat[3, 0] * inMat[1, 3] * inMat[2, 1]

    out[3, 0] = -inMat[1, 0] * inMat[2, 1] * inMat[3, 2] + inMat[1, 0] * inMat[2, 2] * inMat[3, 1]
    out[3, 0] += inMat[2, 0] * inMat[1, 1] * inMat[3, 2] - inMat[2, 0] * inMat[1, 2] * inMat[3, 1]
    out[3, 0] += -inMat[3, 0] * inMat[1, 1] * inMat[2, 2] + inMat[3, 0] * inMat[1, 2] * inMat[2, 1]

    out[0, 1] = -inMat[0, 1] * inMat[2, 2] * inMat[3, 3] + inMat[0, 1] * inMat[2, 3] * inMat[3, 2]
    out[0, 1] += inMat[2, 1] * inMat[0, 2] * inMat[3, 3] - inMat[2, 1] * inMat[0, 3] * inMat[3, 2]
    out[0, 1] += -inMat[3, 1] * inMat[0, 2] * inMat[2, 3] + inMat[3, 1] * inMat[0, 3] * inMat[2, 2]

    out[1, 1] = inMat[0, 0] * inMat[2, 2] * inMat[3, 3] - inMat[0, 0] * inMat[2, 3] * inMat[3, 2]
    out[1, 1] += -inMat[2, 0] * inMat[0, 2] * inMat[3, 3] + inMat[2, 0] * inMat[0, 3] * inMat[3, 2]
    out[1, 1] += inMat[3, 0] * inMat[0, 2] * inMat[2, 3] - inMat[3, 0] * inMat[0, 3] * inMat[2, 2]

    out[2, 1] = -inMat[0, 0] * inMat[2, 1] * inMat[3, 3] + inMat[0, 0] * inMat[2, 3] * inMat[3, 1]
    out[2, 1] += inMat[2, 0] * inMat[0, 1] * inMat[3, 3] - inMat[2, 0] * inMat[0, 3] * inMat[3, 1]
    out[2, 1] += -inMat[3, 0] * inMat[0, 1] * inMat[2, 3] + inMat[3, 0] * inMat[0, 3] * inMat[2, 1]

    out[3, 1] = inMat[0, 0] * inMat[2, 1] * inMat[3, 2] - inMat[0, 0] * inMat[2, 2] * inMat[3, 1]
    out[3, 1] += -inMat[2, 0] * inMat[0, 1] * inMat[3, 2] + inMat[2, 0] * inMat[0, 2] * inMat[3, 1]
    out[3, 1] += inMat[3, 0] * inMat[0, 1] * inMat[2, 2] - inMat[3, 0] * inMat[0, 2] * inMat[2, 1]

    out[0, 2] = inMat[0, 1] * inMat[1, 2] * inMat[3, 3] - inMat[0, 1] * inMat[1, 3] * inMat[3, 2]
    out[0, 2] += -inMat[1, 1] * inMat[0, 2] * inMat[3, 3] + inMat[1, 1] * inMat[0, 3] * inMat[3, 2]
    out[0, 2] += inMat[3, 1] * inMat[0, 2] * inMat[1, 3] - inMat[3, 1] * inMat[0, 3] * inMat[1, 2]

    out[1, 2] = -inMat[0, 0] * inMat[1, 2] * inMat[3, 3] + inMat[0, 0] * inMat[1, 3] * inMat[3, 2]
    out[1, 2] += inMat[1, 0] * inMat[0, 2] * inMat[3, 3] - inMat[1, 0] * inMat[0, 3] * inMat[3, 2]
    out[1, 2] += -inMat[3, 0] * inMat[0, 2] * inMat[1, 3] + inMat[3, 0] * inMat[0, 3] * inMat[1, 2]

    out[2, 2] = inMat[0, 0] * inMat[1, 1] * inMat[3, 3] - inMat[0, 0] * inMat[1, 3] * inMat[3, 1]
    out[2, 2] += -inMat[1, 0] * inMat[0, 1] * inMat[3, 3] + inMat[1, 0] * inMat[0, 3] * inMat[3, 1]
    out[2, 2] += inMat[3, 0] * inMat[0, 1] * inMat[1, 3] - inMat[3, 0] * inMat[0, 3] * inMat[1, 1]

    out[3, 2] = -inMat[0, 0] * inMat[1, 1] * inMat[3, 2] + inMat[0, 0] * inMat[1, 2] * inMat[3, 1]
    out[3, 2] += inMat[1, 0] * inMat[0, 1] * inMat[3, 2] - inMat[1, 0] * inMat[0, 2] * inMat[3, 1]
    out[3, 2] += -inMat[3, 0] * inMat[0, 1] * inMat[1, 2] + inMat[3, 0] * inMat[0, 2] * inMat[1, 1]

    out[0, 3] = -inMat[0, 1] * inMat[1, 2] * inMat[2, 3] + inMat[0, 1] * inMat[1, 3] * inMat[2, 2]
    out[0, 3] += inMat[1, 1] * inMat[0, 2] * inMat[2, 3] - inMat[1, 1] * inMat[0, 3] * inMat[2, 2]
    out[0, 3] += -inMat[2, 1] * inMat[0, 2] * inMat[1, 3] + inMat[2, 1] * inMat[0, 3] * inMat[1, 2]

    out[1, 3] = inMat[0, 0] * inMat[1, 2] * inMat[2, 3] - inMat[0, 0] * inMat[1, 3] * inMat[2, 2]
    out[1, 3] += -inMat[1, 0] * inMat[0, 2] * inMat[2, 3] + inMat[1, 0] * inMat[0, 3] * inMat[2, 2]
    out[1, 3] += inMat[2, 0] * inMat[0, 2] * inMat[1, 3] - inMat[2, 0] * inMat[0, 3] * inMat[1, 2]

    out[2, 3] = -inMat[0, 0] * inMat[1, 1] * inMat[2, 3] + inMat[0, 0] * inMat[1, 3] * inMat[2, 1]
    out[2, 3] += inMat[1, 0] * inMat[0, 1] * inMat[2, 3] - inMat[1, 0] * inMat[0, 3] * inMat[2, 1]
    out[2, 3] += -inMat[2, 0] * inMat[0, 1] * inMat[1, 3] + inMat[2, 0] * inMat[0, 3] * inMat[1, 1]

    out[3, 3] = inMat[0, 0] * inMat[1, 1] * inMat[2, 2] - inMat[0, 0] * inMat[1, 2] * inMat[2, 1]
    out[3, 3] += -inMat[1, 0] * inMat[0, 1] * inMat[2, 2] + inMat[1, 0] * inMat[0, 2] * inMat[2, 1]
    out[3, 3] += inMat[2, 0] * inMat[0, 1] * inMat[1, 2] - inMat[2, 0] * inMat[0, 2] * inMat[1, 1]

    return out
}

public func adjugate(_ inMat: Mat4x4d) -> Mat4x4d {
    var out = Mat4x4d.identity

    out[0, 0] = inMat[1, 1] * inMat[2, 2] * inMat[3, 3] - inMat[1, 1] * inMat[2, 3] * inMat[3, 2]
    out[0, 0] += -inMat[2, 1] * inMat[1, 2] * inMat[3, 3] + inMat[2, 1] * inMat[1, 3] * inMat[3, 2]
    out[0, 0] += inMat[3, 1] * inMat[1, 2] * inMat[2, 3] - inMat[3, 1] * inMat[1, 3] * inMat[2, 2]

    out[1, 0] = -inMat[1, 0] * inMat[2, 2] * inMat[3, 3] + inMat[1, 0] * inMat[2, 3] * inMat[3, 2]
    out[1, 0] += inMat[2, 0] * inMat[1, 2] * inMat[3, 3] - inMat[2, 0] * inMat[1, 3] * inMat[3, 2]
    out[1, 0] += -inMat[3, 0] * inMat[1, 2] * inMat[2, 3] + inMat[3, 0] * inMat[1, 3] * inMat[2, 2]

    out[2, 0] = inMat[1, 0] * inMat[2, 1] * inMat[3, 3] - inMat[1, 0] * inMat[2, 3] * inMat[3, 1]
    out[2, 0] += -inMat[2, 0] * inMat[1, 1] * inMat[3, 3] + inMat[2, 0] * inMat[1, 3] * inMat[3, 1]
    out[2, 0] += inMat[3, 0] * inMat[1, 1] * inMat[2, 3] - inMat[3, 0] * inMat[1, 3] * inMat[2, 1]

    out[3, 0] = -inMat[1, 0] * inMat[2, 1] * inMat[3, 2] + inMat[1, 0] * inMat[2, 2] * inMat[3, 1]
    out[3, 0] += inMat[2, 0] * inMat[1, 1] * inMat[3, 2] - inMat[2, 0] * inMat[1, 2] * inMat[3, 1]
    out[3, 0] += -inMat[3, 0] * inMat[1, 1] * inMat[2, 2] + inMat[3, 0] * inMat[1, 2] * inMat[2, 1]

    out[0, 1] = -inMat[0, 1] * inMat[2, 2] * inMat[3, 3] + inMat[0, 1] * inMat[2, 3] * inMat[3, 2]
    out[0, 1] += inMat[2, 1] * inMat[0, 2] * inMat[3, 3] - inMat[2, 1] * inMat[0, 3] * inMat[3, 2]
    out[0, 1] += -inMat[3, 1] * inMat[0, 2] * inMat[2, 3] + inMat[3, 1] * inMat[0, 3] * inMat[2, 2]

    out[1, 1] = inMat[0, 0] * inMat[2, 2] * inMat[3, 3] - inMat[0, 0] * inMat[2, 3] * inMat[3, 2]
    out[1, 1] += -inMat[2, 0] * inMat[0, 2] * inMat[3, 3] + inMat[2, 0] * inMat[0, 3] * inMat[3, 2]
    out[1, 1] += inMat[3, 0] * inMat[0, 2] * inMat[2, 3] - inMat[3, 0] * inMat[0, 3] * inMat[2, 2]

    out[2, 1] = -inMat[0, 0] * inMat[2, 1] * inMat[3, 3] + inMat[0, 0] * inMat[2, 3] * inMat[3, 1]
    out[2, 1] += inMat[2, 0] * inMat[0, 1] * inMat[3, 3] - inMat[2, 0] * inMat[0, 3] * inMat[3, 1]
    out[2, 1] += -inMat[3, 0] * inMat[0, 1] * inMat[2, 3] + inMat[3, 0] * inMat[0, 3] * inMat[2, 1]

    out[3, 1] = inMat[0, 0] * inMat[2, 1] * inMat[3, 2] - inMat[0, 0] * inMat[2, 2] * inMat[3, 1]
    out[3, 1] += -inMat[2, 0] * inMat[0, 1] * inMat[3, 2] + inMat[2, 0] * inMat[0, 2] * inMat[3, 1]
    out[3, 1] += inMat[3, 0] * inMat[0, 1] * inMat[2, 2] - inMat[3, 0] * inMat[0, 2] * inMat[2, 1]

    out[0, 2] = inMat[0, 1] * inMat[1, 2] * inMat[3, 3] - inMat[0, 1] * inMat[1, 3] * inMat[3, 2]
    out[0, 2] += -inMat[1, 1] * inMat[0, 2] * inMat[3, 3] + inMat[1, 1] * inMat[0, 3] * inMat[3, 2]
    out[0, 2] += inMat[3, 1] * inMat[0, 2] * inMat[1, 3] - inMat[3, 1] * inMat[0, 3] * inMat[1, 2]

    out[1, 2] = -inMat[0, 0] * inMat[1, 2] * inMat[3, 3] + inMat[0, 0] * inMat[1, 3] * inMat[3, 2]
    out[1, 2] += inMat[1, 0] * inMat[0, 2] * inMat[3, 3] - inMat[1, 0] * inMat[0, 3] * inMat[3, 2]
    out[1, 2] += -inMat[3, 0] * inMat[0, 2] * inMat[1, 3] + inMat[3, 0] * inMat[0, 3] * inMat[1, 2]

    out[2, 2] = inMat[0, 0] * inMat[1, 1] * inMat[3, 3] - inMat[0, 0] * inMat[1, 3] * inMat[3, 1]
    out[2, 2] += -inMat[1, 0] * inMat[0, 1] * inMat[3, 3] + inMat[1, 0] * inMat[0, 3] * inMat[3, 1]
    out[2, 2] += inMat[3, 0] * inMat[0, 1] * inMat[1, 3] - inMat[3, 0] * inMat[0, 3] * inMat[1, 1]

    out[3, 2] = -inMat[0, 0] * inMat[1, 1] * inMat[3, 2] + inMat[0, 0] * inMat[1, 2] * inMat[3, 1]
    out[3, 2] += inMat[1, 0] * inMat[0, 1] * inMat[3, 2] - inMat[1, 0] * inMat[0, 2] * inMat[3, 1]
    out[3, 2] += -inMat[3, 0] * inMat[0, 1] * inMat[1, 2] + inMat[3, 0] * inMat[0, 2] * inMat[1, 1]

    out[0, 3] = -inMat[0, 1] * inMat[1, 2] * inMat[2, 3] + inMat[0, 1] * inMat[1, 3] * inMat[2, 2]
    out[0, 3] += inMat[1, 1] * inMat[0, 2] * inMat[2, 3] - inMat[1, 1] * inMat[0, 3] * inMat[2, 2]
    out[0, 3] += -inMat[2, 1] * inMat[0, 2] * inMat[1, 3] + inMat[2, 1] * inMat[0, 3] * inMat[1, 2]

    out[1, 3] = inMat[0, 0] * inMat[1, 2] * inMat[2, 3] - inMat[0, 0] * inMat[1, 3] * inMat[2, 2]
    out[1, 3] += -inMat[1, 0] * inMat[0, 2] * inMat[2, 3] + inMat[1, 0] * inMat[0, 3] * inMat[2, 2]
    out[1, 3] += inMat[2, 0] * inMat[0, 2] * inMat[1, 3] - inMat[2, 0] * inMat[0, 3] * inMat[1, 2]

    out[2, 3] = -inMat[0, 0] * inMat[1, 1] * inMat[2, 3] + inMat[0, 0] * inMat[1, 3] * inMat[2, 1]
    out[2, 3] += inMat[1, 0] * inMat[0, 1] * inMat[2, 3] - inMat[1, 0] * inMat[0, 3] * inMat[2, 1]
    out[2, 3] += -inMat[2, 0] * inMat[0, 1] * inMat[1, 3] + inMat[2, 0] * inMat[0, 3] * inMat[1, 1]

    out[3, 3] = inMat[0, 0] * inMat[1, 1] * inMat[2, 2] - inMat[0, 0] * inMat[1, 2] * inMat[2, 1]
    out[3, 3] += -inMat[1, 0] * inMat[0, 1] * inMat[2, 2] + inMat[1, 0] * inMat[0, 2] * inMat[2, 1]
    out[3, 3] += inMat[2, 0] * inMat[0, 1] * inMat[1, 2] - inMat[2, 0] * inMat[0, 2] * inMat[1, 1]

    return out
}
