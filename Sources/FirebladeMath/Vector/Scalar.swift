//
//  Scalar.swift
//
//
//  Created by Christian Treffs on 25.08.19.
//

import protocol SGLMath.ArithmeticType
import protocol SGLMath.FloatingPointArithmeticType

public typealias Scalar = SIMDScalar & Numeric & ArithmeticType

public typealias FloatingPointScalar = Scalar & FloatingPointArithmeticType
