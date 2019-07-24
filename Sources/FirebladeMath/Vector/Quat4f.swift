//
//  Quat4f.swift
//  
//
//  Created by Christian Treffs on 23.07.19.
//

import simd

public typealias Quat4f = simd_quatf

extension Quat4f: IdentitiyProviding {
    public static let identity = Quat4f(ix: 0, iy: 0, iz: 0, r: 1)
}

extension Quat4f {
    /*public init(yaw: Float, pitch: Float, roll: Float) {
        let _roll  = roll * 0.5
        let _pitch = pitch * 0.5
        let _yaw   = yaw * 0.5
        
        let cr: Float = cos(_roll)
        let cp: Float = cos(_pitch)
        let cy: Float = cos(_yaw)
        
        let sr: Float = sin(_roll)
        let sp: Float = sin(_pitch)
        let sy: Float = sin(_yaw)
        
        let cpcy: Float = cp * cy
        let spsy: Float = sp * sy
        let spcy: Float = sp * cy
        let cpsy: Float = cp * sy
        
        let ix   = ( sr * cpcy - cr * spsy)
        let iy   = ( cr * spcy + sr * cpsy)
        let iz   = ( cr * cpsy - sr * spcy)
        let r   = cr * cpcy + sr * spsy
        
        self.init(ix: ix, iy: iy, iz: iz, r: r)
    }*/

    public init(yaw: Float, pitch: Float, roll: Float) {
        let atCos: Float = cos(roll / 2)
        let atSin: Float = sin(roll / 2)
        let leftCos: Float = cos(pitch / 2)
        let leftSin: Float = sin(pitch / 2)
        let upCos: Float = cos(yaw / 2)
        let upSin: Float = sin(yaw / 2)
        let atLeftCos: Float = atCos * leftCos
        let atLeftSin: Float = atSin * leftSin

        let X: Float = atSin * leftCos * upCos + atCos * leftSin * upSin
        let Y: Float = atCos * leftSin * upCos - atSin * leftCos * upSin
        let Z: Float = atLeftCos * upSin + atLeftSin * upCos
        let W: Float = atLeftCos * upCos - atLeftSin * upSin

        self.init(ix: X, iy: Y, iz: Z, r: W)
    }
}
