//
//  ReferenceFunctions.swift
//  FirebladeMathTests
//

// Every public FirebladeMath function registered for the reference-value tests, with its
// accuracy class and input domains. Scripts/check-reference-coverage.py fails CI if a public
// function is missing here.
//
// Accuracy classes (see ReferenceAccuracy):
// - exact: fully determined by IEEE 754 or by identical code on every platform.
// - libm: a single call into the platform's C math library.
// - composite: simd vs. portable evaluation order, or built on C math library calls.

import FirebladeMath

// swiftlint:disable line_length

extension ReferenceRegistry {
    /// All registered functions. Built once and never mutated.
    nonisolated(unsafe) static let all: [ReferenceFunction] = {
        var registry = ReferenceRegistry()

        registry.registerPart1()
        registry.registerPart2()
        registry.registerPart3()
        registry.registerPart4()
        registry.registerPart5()
        registry.registerPart6()
        registry.registerPart7()
        return registry.functions
    }()

    private mutating func registerPart1() {
        var r = self
        defer { self = r }
        r.add("acos(Float)", .libm(ulps: 4), .uniform(-1...1), specials: true, FirebladeMath.acos(_:) as (Float) -> Float)
        r.add("acos(Double)", .libm(ulps: 4), .uniform(-1...1), specials: true, FirebladeMath.acos(_:) as (Double) -> Double)
        r.add("acosh(Double)", .libm(ulps: 4), .uniform(1...100), specials: true, FirebladeMath.acosh(_:) as (Double) -> Double)
        r.add("acosh(Float)", .libm(ulps: 4), .uniform(1...100), specials: true, FirebladeMath.acosh(_:) as (Float) -> Float)
        r.add("adjugate(Mat3x3f)", .composite(.loose), .wellConditionedMatrix, FirebladeMath.adjugate(_:) as (Mat3x3f) -> Mat3x3f)
        r.add("adjugate(Mat3x3d)", .composite(.loose), .wellConditionedMatrix, FirebladeMath.adjugate(_:) as (Mat3x3d) -> Mat3x3d)
        r.add("adjugate(Mat4x4f)", .composite(.loose), .wellConditionedMatrix, FirebladeMath.adjugate(_:) as (Mat4x4f) -> Mat4x4f)
        r.add("adjugate(Mat4x4d)", .composite(.loose), .wellConditionedMatrix, FirebladeMath.adjugate(_:) as (Mat4x4d) -> Mat4x4d)
        r.add("angle(Quat4f)", .composite(.loose), .standard, FirebladeMath.angle(_:) as (Quat4f) -> Float)
        r.add("angle(Quat4d)", .composite(.loose), .standard, FirebladeMath.angle(_:) as (Quat4d) -> Double)
        r.add("asin(Double)", .libm(ulps: 4), .uniform(-1...1), specials: true, FirebladeMath.asin(_:) as (Double) -> Double)
        r.add("asin(Float)", .libm(ulps: 4), .uniform(-1...1), specials: true, FirebladeMath.asin(_:) as (Float) -> Float)
        r.add("asinh(Double)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.asinh(_:) as (Double) -> Double)
        r.add("asinh(Float)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.asinh(_:) as (Float) -> Float)
        r.add("atan(Double)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.atan(_:) as (Double) -> Double)
        r.add("atan(Float)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.atan(_:) as (Float) -> Float)
        r.add("atan2(Double, Double)", .libm(ulps: 4), .standard, .standard, specials: true, FirebladeMath.atan2(_:_:) as (Double, Double) -> Double)
        r.add("atan2(Float, Float)", .libm(ulps: 4), .standard, .standard, specials: true, FirebladeMath.atan2(_:_:) as (Float, Float) -> Float)
        r.add("atanh(Float)", .libm(ulps: 4), .uniform(-0.999...0.999), specials: true, FirebladeMath.atanh(_:) as (Float) -> Float)
        r.add("atanh(Double)", .libm(ulps: 4), .uniform(-0.999...0.999), specials: true, FirebladeMath.atanh(_:) as (Double) -> Double)
        r.add("axis(Quat4f)", .composite(.tight), .standard, FirebladeMath.axis(_:) as (Quat4f) -> SIMD3<Float>)
        r.add("axis(Quat4d)", .composite(.tight), .standard, FirebladeMath.axis(_:) as (Quat4d) -> SIMD3<Double>)
        r.add("ceil(Float)", .exact, .standard, specials: true, FirebladeMath.ceil(_:) as (Float) -> Float)
        r.add("ceil(Double)", .exact, .standard, specials: true, FirebladeMath.ceil(_:) as (Double) -> Double)
        r.add("clamp(Value, min: Value, max: Value) [Float]", .exact, .standard, .uniform(-10...0), .uniform(0...10), specials: true, FirebladeMath.clamp(_:min:max:) as (Float, Float, Float) -> Float)
        r.add("clamp(Value, min: Value, max: Value) [Double]", .exact, .standard, .uniform(-10...0), .uniform(0...10), specials: true, FirebladeMath.clamp(_:min:max:) as (Double, Double, Double) -> Double)
        r.add("clamp(Double, Double, Double)", .exact, .standard, .uniform(-10...0), .uniform(0...10), specials: true, FirebladeMath.clamp(_:_:_:) as (Double, Double, Double) -> Double)
        r.add("clamp(Float, Float, Float)", .exact, .standard, .uniform(-10...0), .uniform(0...10), specials: true, FirebladeMath.clamp(_:_:_:) as (Float, Float, Float) -> Float)
        r.add("conjugate(Quat4f)", .exact, .standard, FirebladeMath.conjugate(_:) as (Quat4f) -> Quat4f)
        r.add("conjugate(Quat4d)", .exact, .standard, FirebladeMath.conjugate(_:) as (Quat4d) -> Quat4d)
        r.add("copysign(Double, Double)", .exact, .standard, .standard, specials: true, FirebladeMath.copysign(_:_:) as (Double, Double) -> Double)
        r.add("copysign(Float, Float)", .exact, .standard, .standard, specials: true, FirebladeMath.copysign(_:_:) as (Float, Float) -> Float)
        r.add("cos(Float)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.cos(_:) as (Float) -> Float)
        r.add("cos(Double)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.cos(_:) as (Double) -> Double)
        r.add("cosh(Float)", .libm(ulps: 4), .uniform(-20...20), specials: true, FirebladeMath.cosh(_:) as (Float) -> Float)
        r.add("cosh(Double)", .libm(ulps: 4), .uniform(-20...20), specials: true, FirebladeMath.cosh(_:) as (Double) -> Double)
        r.add("cross(SIMD2<Double>, SIMD2<Double>)", .composite(.products), .standard, .standard, FirebladeMath.cross(_:_:) as (SIMD2<Double>, SIMD2<Double>) -> SIMD3<Double>)
        r.add("cross(SIMD2<Float>, SIMD2<Float>)", .composite(.products), .standard, .standard, FirebladeMath.cross(_:_:) as (SIMD2<Float>, SIMD2<Float>) -> SIMD3<Float>)
        r.add("cross(SIMD3<Double>, SIMD3<Double>)", .composite(.products), .standard, .standard, FirebladeMath.cross(_:_:) as (SIMD3<Double>, SIMD3<Double>) -> SIMD3<Double>)
        r.add("cross(SIMD3<Float>, SIMD3<Float>)", .composite(.products), .standard, .standard, FirebladeMath.cross(_:_:) as (SIMD3<Float>, SIMD3<Float>) -> SIMD3<Float>)
    }

    private mutating func registerPart2() {
        var r = self
        defer { self = r }
        r.add("degrees(Float)", .exact, .uniform(-1000...1000), specials: true, FirebladeMath.degrees(_:) as (Float) -> Float)
        r.add("degrees(Double)", .exact, .uniform(-1000...1000), specials: true, FirebladeMath.degrees(_:) as (Double) -> Double)
        r.add("degrees(Vec3f)", .exact, .uniform(-1000...1000), FirebladeMath.degrees(_:) as (Vec3f) -> Vec3f)
        r.add("determinant(Mat4x4f)", .composite(.loose), .wellConditionedMatrix, FirebladeMath.determinant(_:) as (Mat4x4f) -> Float)
        r.add("determinant(Mat3x3f)", .composite(.loose), .wellConditionedMatrix, FirebladeMath.determinant(_:) as (Mat3x3f) -> Float)
        r.add("determinant(Mat4x4d)", .composite(.loose), .wellConditionedMatrix, FirebladeMath.determinant(_:) as (Mat4x4d) -> Double)
        r.add("determinant(Mat3x3d)", .composite(.loose), .wellConditionedMatrix, FirebladeMath.determinant(_:) as (Mat3x3d) -> Double)
        r.add("distance(Float, Float)", .exact, .standard, .standard, specials: true, FirebladeMath.distance(_:_:) as (Float, Float) -> Float)
        r.add("distance(Double, Double)", .exact, .standard, .standard, specials: true, FirebladeMath.distance(_:_:) as (Double, Double) -> Double)
        r.add("dot(SIMD2<Double>, SIMD2<Double>)", .composite(.products), .standard, .standard, FirebladeMath.dot(_:_:) as (SIMD2<Double>, SIMD2<Double>) -> Double)
        r.add("dot(SIMD2<Float>, SIMD2<Float>)", .composite(.products), .standard, .standard, FirebladeMath.dot(_:_:) as (SIMD2<Float>, SIMD2<Float>) -> Float)
        r.add("dot(SIMD3<Double>, SIMD3<Double>)", .composite(.products), .standard, .standard, FirebladeMath.dot(_:_:) as (SIMD3<Double>, SIMD3<Double>) -> Double)
        r.add("dot(SIMD3<Float>, SIMD3<Float>)", .composite(.products), .standard, .standard, FirebladeMath.dot(_:_:) as (SIMD3<Float>, SIMD3<Float>) -> Float)
        r.add("dot(SIMD4<Double>, SIMD4<Double>)", .composite(.products), .standard, .standard, FirebladeMath.dot(_:_:) as (SIMD4<Double>, SIMD4<Double>) -> Double)
        r.add("dot(SIMD4<Float>, SIMD4<Float>)", .composite(.products), .standard, .standard, FirebladeMath.dot(_:_:) as (SIMD4<Float>, SIMD4<Float>) -> Float)
        r.add("exp(Float)", .libm(ulps: 4), .uniform(-80...80), specials: true, FirebladeMath.exp(_:) as (Float) -> Float)
        r.add("exp(Double)", .libm(ulps: 4), .uniform(-80...80), specials: true, FirebladeMath.exp(_:) as (Double) -> Double)
        r.add("exp2(Float)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.exp2(_:) as (Float) -> Float)
        r.add("exp2(Double)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.exp2(_:) as (Double) -> Double)
        r.add("faceforward(n: Float, i: Float, nref: Float)", .exact, .standard, .standard, .standard, specials: true, FirebladeMath.faceforward(n:i:nref:) as (Float, Float, Float) -> Float)
        r.add("faceforward(n: Double, i: Double, nref: Double)", .exact, .standard, .standard, .standard, specials: true, FirebladeMath.faceforward(n:i:nref:) as (Double, Double, Double) -> Double)
        r.add("floor(Float)", .exact, .standard, specials: true, FirebladeMath.floor(_:) as (Float) -> Float)
        r.add("floor(Double)", .exact, .standard, specials: true, FirebladeMath.floor(_:) as (Double) -> Double)
        r.add("fract(Double)", .exact, .standard, specials: true, FirebladeMath.fract(_:) as (Double) -> Double)
        r.add("fract(Float)", .exact, .standard, specials: true, FirebladeMath.fract(_:) as (Float) -> Float)
        r.add("hypot(Float, Float)", .libm(ulps: 4), .standard, .standard, specials: true, FirebladeMath.hypot(_:_:) as (Float, Float) -> Float)
        r.add("hypot(Double, Double)", .libm(ulps: 4), .standard, .standard, specials: true, FirebladeMath.hypot(_:_:) as (Double, Double) -> Double)
        r.add("inverse(Mat3x3f)", .composite(.loose), .wellConditionedMatrix, FirebladeMath.inverse(_:) as (Mat3x3f) -> Mat3x3f)
        r.add("inverse(Mat3x3d)", .composite(.loose), .wellConditionedMatrix, FirebladeMath.inverse(_:) as (Mat3x3d) -> Mat3x3d)
        r.add("inverse(Mat4x4f)", .composite(.loose), .wellConditionedMatrix, FirebladeMath.inverse(_:) as (Mat4x4f) -> Mat4x4f)
        r.add("inverse(Mat4x4d)", .composite(.loose), .wellConditionedMatrix, FirebladeMath.inverse(_:) as (Mat4x4d) -> Mat4x4d)
        r.add("inverse(Quat4f)", .composite(.loose), .standard, FirebladeMath.inverse(_:) as (Quat4f) -> Quat4f)
        r.add("inverse(Quat4d)", .composite(.loose), .standard, FirebladeMath.inverse(_:) as (Quat4d) -> Quat4d)
        r.add("isInfinite(Float)", .exact, .standard, specials: true, FirebladeMath.isInfinite(_:) as (Float) -> Bool)
        r.add("isInfinite(Double)", .exact, .standard, specials: true, FirebladeMath.isInfinite(_:) as (Double) -> Bool)
        r.add("isNegativeInfinity(Float)", .exact, .standard, specials: true, FirebladeMath.isNegativeInfinity(_:) as (Float) -> Bool)
        r.add("isNegativeInfinity(Double)", .exact, .standard, specials: true, FirebladeMath.isNegativeInfinity(_:) as (Double) -> Bool)
        r.add("isNegativeZero(Float)", .exact, .standard, specials: true, FirebladeMath.isNegativeZero(_:) as (Float) -> Bool)
        r.add("isNegativeZero(Double)", .exact, .standard, specials: true, FirebladeMath.isNegativeZero(_:) as (Double) -> Bool)
        r.add("isPositiveInfinity(Float)", .exact, .standard, specials: true, FirebladeMath.isPositiveInfinity(_:) as (Float) -> Bool)
    }

    private mutating func registerPart3() {
        var r = self
        defer { self = r }
        r.add("isPositiveInfinity(Double)", .exact, .standard, specials: true, FirebladeMath.isPositiveInfinity(_:) as (Double) -> Bool)
        r.add("isPositiveZero(Float)", .exact, .standard, specials: true, FirebladeMath.isPositiveZero(_:) as (Float) -> Bool)
        r.add("isPositiveZero(Double)", .exact, .standard, specials: true, FirebladeMath.isPositiveZero(_:) as (Double) -> Bool)
        r.add("length(SIMD2<Double>)", .composite(.tight), .standard, FirebladeMath.length(_:) as (SIMD2<Double>) -> Double)
        r.add("length(SIMD2<Float>)", .composite(.tight), .standard, FirebladeMath.length(_:) as (SIMD2<Float>) -> Float)
        r.add("length(SIMD3<Double>)", .composite(.tight), .standard, FirebladeMath.length(_:) as (SIMD3<Double>) -> Double)
        r.add("length(SIMD3<Float>)", .composite(.tight), .standard, FirebladeMath.length(_:) as (SIMD3<Float>) -> Float)
        r.add("length(SIMD4<Double>)", .composite(.tight), .standard, FirebladeMath.length(_:) as (SIMD4<Double>) -> Double)
        r.add("length(SIMD4<Float>)", .composite(.tight), .standard, FirebladeMath.length(_:) as (SIMD4<Float>) -> Float)
        r.add("length(Quat4f)", .composite(.tight), .standard, FirebladeMath.length(_:) as (Quat4f) -> Float)
        r.add("length(Quat4d)", .composite(.tight), .standard, FirebladeMath.length(_:) as (Quat4d) -> Double)
        r.add("interpolate(Value, Value, Value) [Float]", .exact, .standard, .standard, .uniform(-0.5...1.5), specials: true, FirebladeMath.interpolate(_:_:_:) as (Float, Float, Float) -> Float)
        r.add("interpolate(Value, Value, Value) [Double]", .exact, .standard, .standard, .uniform(-0.5...1.5), specials: true, FirebladeMath.interpolate(_:_:_:) as (Double, Double, Double) -> Double)
        r.add("lerpPrecise(Value, Value, Value) [Float]", .exact, .standard, .standard, .uniform(-0.5...1.5), specials: true, FirebladeMath.lerpPrecise(_:_:_:) as (Float, Float, Float) -> Float)
        r.add("lerpPrecise(Value, Value, Value) [Double]", .exact, .standard, .standard, .uniform(-0.5...1.5), specials: true, FirebladeMath.lerpPrecise(_:_:_:) as (Double, Double, Double) -> Double)
        r.add("lerp(Value, Value, Value) [Float]", .exact, .standard, .standard, .uniform(-0.5...1.5), specials: true, FirebladeMath.lerp(_:_:_:) as (Float, Float, Float) -> Float)
        r.add("lerp(Value, Value, Value) [Double]", .exact, .standard, .standard, .uniform(-0.5...1.5), specials: true, FirebladeMath.lerp(_:_:_:) as (Double, Double, Double) -> Double)
        r.add("mix(Double, Double, Double)", .composite(.tight), .standard, .standard, .uniform(-0.5...1.5), specials: true, FirebladeMath.mix(_:_:_:) as (Double, Double, Double) -> Double)
        r.add("mix(Float, Float, Float)", .composite(.tight), .standard, .standard, .uniform(-0.5...1.5), specials: true, FirebladeMath.mix(_:_:_:) as (Float, Float, Float) -> Float)
        r.add("log(Float)", .libm(ulps: 4), .logUniform(1e-6...1e6), specials: true, FirebladeMath.log(_:) as (Float) -> Float)
        r.add("log(Double)", .libm(ulps: 4), .logUniform(1e-6...1e6), specials: true, FirebladeMath.log(_:) as (Double) -> Double)
        r.add("log10(Float)", .libm(ulps: 4), .logUniform(1e-6...1e6), specials: true, FirebladeMath.log10(_:) as (Float) -> Float)
        r.add("log10(Double)", .libm(ulps: 4), .logUniform(1e-6...1e6), specials: true, FirebladeMath.log10(_:) as (Double) -> Double)
        r.add("log2(Float)", .libm(ulps: 4), .logUniform(1e-6...1e6), specials: true, FirebladeMath.log2(_:) as (Float) -> Float)
        r.add("log2(Double)", .libm(ulps: 4), .logUniform(1e-6...1e6), specials: true, FirebladeMath.log2(_:) as (Double) -> Double)
        r.add("matrix3x3(from: Quat4f)", .composite(.tight), .standard, FirebladeMath.matrix3x3(from:) as (Quat4f) -> Mat3x3f)
        r.add("matrix3x3(from: Quat4d)", .composite(.tight), .standard, FirebladeMath.matrix3x3(from:) as (Quat4d) -> Mat3x3d)
        r.add("matrix4x4(from: Quat4f)", .composite(.tight), .standard, FirebladeMath.matrix4x4(from:) as (Quat4f) -> Mat4x4f)
        r.add("matrix4x4(from: Quat4d)", .composite(.tight), .standard, FirebladeMath.matrix4x4(from:) as (Quat4d) -> Mat4x4d)
        r.add("mod(Float, Float)", .exact, .uniform(-100...100), .uniform(0.1...10), specials: true, FirebladeMath.mod(_:_:) as (Float, Float) -> Float)
        r.add("mod(Double, Double)", .exact, .uniform(-100...100), .uniform(0.1...10), specials: true, FirebladeMath.mod(_:_:) as (Double, Double) -> Double)
        r.add("normalize(SIMD2<Double>)", .composite(.tight), .standard, FirebladeMath.normalize(_:) as (SIMD2<Double>) -> SIMD2<Double>)
        r.add("normalize(SIMD2<Float>)", .composite(.tight), .standard, FirebladeMath.normalize(_:) as (SIMD2<Float>) -> SIMD2<Float>)
        r.add("normalize(SIMD3<Double>)", .composite(.tight), .standard, FirebladeMath.normalize(_:) as (SIMD3<Double>) -> SIMD3<Double>)
        r.add("normalize(SIMD3<Float>)", .composite(.tight), .standard, FirebladeMath.normalize(_:) as (SIMD3<Float>) -> SIMD3<Float>)
        r.add("normalize(SIMD4<Double>)", .composite(.tight), .standard, FirebladeMath.normalize(_:) as (SIMD4<Double>) -> SIMD4<Double>)
        r.add("normalize(SIMD4<Float>)", .composite(.tight), .standard, FirebladeMath.normalize(_:) as (SIMD4<Float>) -> SIMD4<Float>)
        r.add("normalize(Quat4f)", .composite(.tight), .standard, FirebladeMath.normalize(_:) as (Quat4f) -> Quat4f)
        r.add("normalize(Quat4d)", .composite(.tight), .standard, FirebladeMath.normalize(_:) as (Quat4d) -> Quat4d)
        r.add("pow(Float, Float)", .libm(ulps: 4), .uniform(0...10), .uniform(-10...10), specials: true, FirebladeMath.pow(_:_:) as (Float, Float) -> Float)
    }

    private mutating func registerPart4() {
        var r = self
        defer { self = r }
        r.add("pow(Double, Double)", .libm(ulps: 4), .uniform(0...10), .uniform(-10...10), specials: true, FirebladeMath.pow(_:_:) as (Double, Double) -> Double)
        r.add("pow2(Float)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.pow2(_:) as (Float) -> Float)
        r.add("pow2(Double)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.pow2(_:) as (Double) -> Double)
        r.add("quaternion(angle: Float, axis: SIMD3<Float>)", .composite(.loose), .standard, .unitVector, FirebladeMath.quaternion(angle:axis:) as (Float, SIMD3<Float>) -> Quat4f)
        r.add("quaternion(angle: Double, axis: SIMD3<Double>)", .composite(.loose), .standard, .unitVector, FirebladeMath.quaternion(angle:axis:) as (Double, SIMD3<Double>) -> Quat4d)
        r.add("quaternion(from: SIMD3<Float>, to: SIMD3<Float>)", .composite(.loose), .unitVector, .unitVector, FirebladeMath.quaternion(from:to:) as (SIMD3<Float>, SIMD3<Float>) -> Quat4f)
        r.add("quaternion(from: SIMD3<Double>, to: SIMD3<Double>)", .composite(.loose), .unitVector, .unitVector, FirebladeMath.quaternion(from:to:) as (SIMD3<Double>, SIMD3<Double>) -> Quat4d)
        r.add("quaternion(matrix: Mat3x3f)", .composite(.loose), .rotationMatrix, FirebladeMath.quaternion(matrix:) as (Mat3x3f) -> Quat4f)
        r.add("quaternion(matrix: Mat3x3d)", .composite(.loose), .rotationMatrix, FirebladeMath.quaternion(matrix:) as (Mat3x3d) -> Quat4d)
        r.add("quaternion(matrix: Mat4x4f)", .composite(.loose), .rotationMatrix, FirebladeMath.quaternion(matrix:) as (Mat4x4f) -> Quat4f)
        r.add("quaternion(matrix: Mat4x4d)", .composite(.loose), .rotationMatrix, FirebladeMath.quaternion(matrix:) as (Mat4x4d) -> Quat4d)
        r.add("radians(Float)", .exact, .uniform(-1000...1000), specials: true, FirebladeMath.radians(_:) as (Float) -> Float)
        r.add("radians(Double)", .exact, .uniform(-1000...1000), specials: true, FirebladeMath.radians(_:) as (Double) -> Double)
        r.add("radians(Vec3f)", .exact, .uniform(-1000...1000), FirebladeMath.radians(_:) as (Vec3f) -> Vec3f)
        r.add("reflect(Float, Float)", .exact, .standard, .standard, specials: true, FirebladeMath.reflect(_:_:) as (Float, Float) -> Float)
        r.add("reflect(Double, Double)", .exact, .standard, .standard, specials: true, FirebladeMath.reflect(_:_:) as (Double, Double) -> Double)
        r.add("refract(Float, Float, Float)", .exact, .uniform(-1...1), .uniform(-1...1), .uniform(0.5...2), specials: true, FirebladeMath.refract(_:_:_:) as (Float, Float, Float) -> Float)
        r.add("refract(Double, Double, Double)", .exact, .uniform(-1...1), .uniform(-1...1), .uniform(0.5...2), specials: true, FirebladeMath.refract(_:_:_:) as (Double, Double, Double) -> Double)
        r.add("rotate(Vec4f, Vec3f, Float)", .composite(.loose), .standard, .unitVector, .standard, FirebladeMath.rotate(_:_:_:) as (Vec4f, Vec3f, Float) -> Vec4f)
        r.add("rotate(Vec3f, Vec3f, Float)", .composite(.loose), .standard, .unitVector, .standard, FirebladeMath.rotate(_:_:_:) as (Vec3f, Vec3f, Float) -> Vec3f)
        r.add("rsqrt(Double)", .composite(.tight), .logUniform(1e-6...1e6), specials: true, FirebladeMath.rsqrt(_:) as (Double) -> Double)
        r.add("rsqrt(Float)", .composite(.tight), .logUniform(1e-6...1e6), specials: true, FirebladeMath.rsqrt(_:) as (Float) -> Float)
        r.add("saturate(Value) [Float]", .exact, .uniform(-2...2), specials: true, FirebladeMath.saturate(_:) as (Float) -> Float)
        r.add("saturate(Value) [Double]", .exact, .uniform(-2...2), specials: true, FirebladeMath.saturate(_:) as (Double) -> Double)
        r.add("sign(Double)", .exact, .standard, specials: true, FirebladeMath.sign(_:) as (Double) -> Double)
        r.add("sign(Float)", .exact, .standard, specials: true, FirebladeMath.sign(_:) as (Float) -> Float)
        r.add("sin(Float)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.sin(_:) as (Float) -> Float)
        r.add("sin(Double)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.sin(_:) as (Double) -> Double)
        r.add("sinh(Float)", .libm(ulps: 4), .uniform(-20...20), specials: true, FirebladeMath.sinh(_:) as (Float) -> Float)
        r.add("sinh(Double)", .libm(ulps: 4), .uniform(-20...20), specials: true, FirebladeMath.sinh(_:) as (Double) -> Double)
        r.add("smoothstep(Double, Double, Double)", .composite(.tight), .uniform(-10...0), .uniform(0.5...10), .standard, specials: true, FirebladeMath.smoothstep(_:_:_:) as (Double, Double, Double) -> Double)
        r.add("smoothstep(Float, Float, Float)", .composite(.tight), .uniform(-10...0), .uniform(0.5...10), .standard, specials: true, FirebladeMath.smoothstep(_:_:_:) as (Float, Float, Float) -> Float)
        r.add("sqrt(Float)", .exact, .logUniform(1e-6...1e6), specials: true, FirebladeMath.sqrt(_:) as (Float) -> Float)
        r.add("sqrt(Double)", .exact, .logUniform(1e-6...1e6), specials: true, FirebladeMath.sqrt(_:) as (Double) -> Double)
        r.add("step(Double, Double)", .exact, .standard, .standard, specials: true, FirebladeMath.step(_:_:) as (Double, Double) -> Double)
        r.add("step(Float, Float)", .exact, .standard, .standard, specials: true, FirebladeMath.step(_:_:) as (Float, Float) -> Float)
        r.add("tan(Float)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.tan(_:) as (Float) -> Float)
        r.add("tan(Double)", .libm(ulps: 4), .uniform(-100...100), specials: true, FirebladeMath.tan(_:) as (Double) -> Double)
        r.add("tanh(Float)", .libm(ulps: 4), .uniform(-20...20), specials: true, FirebladeMath.tanh(_:) as (Float) -> Float)
        r.add("tanh(Double)", .libm(ulps: 4), .uniform(-20...20), specials: true, FirebladeMath.tanh(_:) as (Double) -> Double)
    }

    private mutating func registerPart5() {
        var r = self
        defer { self = r }
        r.add("transpose(Mat3x3f)", .exact, .standard, FirebladeMath.transpose(_:) as (Mat3x3f) -> Mat3x3f)
        r.add("transpose(Mat3x3d)", .exact, .standard, FirebladeMath.transpose(_:) as (Mat3x3d) -> Mat3x3d)
        r.add("transpose(Mat4x4f)", .exact, .standard, FirebladeMath.transpose(_:) as (Mat4x4f) -> Mat4x4f)
        r.add("transpose(Mat4x4d)", .exact, .standard, FirebladeMath.transpose(_:) as (Mat4x4d) -> Mat4x4d)
        r.add("multiply(Mat4x4d, Mat4x4d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Mat4x4d, Mat4x4d) -> Mat4x4d)
        r.add("multiply(Double, Mat4x4d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Double, Mat4x4d) -> Mat4x4d)
        r.add("multiply(Vec4d, Mat4x4d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Vec4d, Mat4x4d) -> Vec4d)
        r.add("multiply(Mat4x4d, Vec4d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Mat4x4d, Vec4d) -> Vec4d)
        r.add("multiply(Mat4x4f, Mat4x4f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Mat4x4f, Mat4x4f) -> Mat4x4f)
        r.add("multiply(Float, Mat4x4f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Float, Mat4x4f) -> Mat4x4f)
        r.add("multiply(Vec4f, Mat4x4f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Vec4f, Mat4x4f) -> Vec4f)
        r.add("multiply(Mat4x4f, Vec4f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Mat4x4f, Vec4f) -> Vec4f)
        r.add("multiply(Mat3x3d, Mat3x3d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Mat3x3d, Mat3x3d) -> Mat3x3d)
        r.add("multiply(Double, Mat3x3d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Double, Mat3x3d) -> Mat3x3d)
        r.add("multiply(Vec3d, Mat3x3d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Vec3d, Mat3x3d) -> Vec3d)
        r.add("multiply(Mat3x3d, Vec3d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Mat3x3d, Vec3d) -> Vec3d)
        r.add("multiply(Mat3x3f, Mat3x3f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Mat3x3f, Mat3x3f) -> Mat3x3f)
        r.add("multiply(Float, Mat3x3f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Float, Mat3x3f) -> Mat3x3f)
        r.add("multiply(Vec3f, Mat3x3f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Vec3f, Mat3x3f) -> Vec3f)
        r.add("multiply(Mat3x3f, Vec3f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Mat3x3f, Vec3f) -> Vec3f)
        r.add("multiply(Mat2x2d, Mat2x2d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Mat2x2d, Mat2x2d) -> Mat2x2d)
        r.add("multiply(Double, Mat2x2d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Double, Mat2x2d) -> Mat2x2d)
        r.add("multiply(Vec2d, Mat2x2d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Vec2d, Mat2x2d) -> Vec2d)
        r.add("multiply(Mat2x2d, Vec2d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Mat2x2d, Vec2d) -> Vec2d)
        r.add("multiply(Mat2x2f, Mat2x2f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Mat2x2f, Mat2x2f) -> Mat2x2f)
        r.add("multiply(Float, Mat2x2f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Float, Mat2x2f) -> Mat2x2f)
        r.add("multiply(Vec2f, Mat2x2f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Vec2f, Mat2x2f) -> Vec2f)
        r.add("multiply(Mat2x2f, Vec2f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Mat2x2f, Vec2f) -> Vec2f)
        r.add("quaternionToEulerAngles_123(Quat4f)", .composite(.loose), .unitQuaternion, FirebladeMath.quaternionToEulerAngles_123(_:) as (Quat4f) -> Vec3f)
        r.add("quaternionToEulerAngles_132(Quat4f)", .composite(.loose), .unitQuaternion, FirebladeMath.quaternionToEulerAngles_132(_:) as (Quat4f) -> Vec3f)
        r.add("quaternionToEulerAngles_213(Quat4f)", .composite(.loose), .unitQuaternion, FirebladeMath.quaternionToEulerAngles_213(_:) as (Quat4f) -> Vec3f)
        r.add("quaternionToEulerAngles_231(Quat4f)", .composite(.loose), .unitQuaternion, FirebladeMath.quaternionToEulerAngles_231(_:) as (Quat4f) -> Vec3f)
        r.add("quaternionToEulerAngles_312(Quat4f)", .composite(.loose), .unitQuaternion, FirebladeMath.quaternionToEulerAngles_312(_:) as (Quat4f) -> Vec3f)
        r.add("quaternionToEulerAngles_321(Quat4f)", .composite(.loose), .unitQuaternion, FirebladeMath.quaternionToEulerAngles_321(_:) as (Quat4f) -> Vec3f)
        r.add("multiply(Float, Quat4f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Float, Quat4f) -> Quat4f)
        r.add("multiply(Quat4f, Float)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Quat4f, Float) -> Quat4f)
        r.add("multiply(Quat4f, Quat4f)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Quat4f, Quat4f) -> Quat4f)
        r.add("add(Quat4f, Quat4f)", .exact, .standard, .standard, FirebladeMath.add(_:_:) as (Quat4f, Quat4f) -> Quat4f)
        r.add("subtract(Quat4f, Quat4f)", .exact, .standard, .standard, FirebladeMath.subtract(_:_:) as (Quat4f, Quat4f) -> Quat4f)
        r.add("act(Quat4f, Vec3f)", .composite(.products), .standard, .standard, FirebladeMath.act(_:_:) as (Quat4f, Vec3f) -> Vec3f)
    }

    private mutating func registerPart6() {
        var r = self
        defer { self = r }
        r.add("act(Quat4d, Vec3d)", .composite(.products), .standard, .standard, FirebladeMath.act(_:_:) as (Quat4d, Vec3d) -> Vec3d)
        r.add("multiply(Double, Quat4d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Double, Quat4d) -> Quat4d)
        r.add("multiply(Quat4d, Double)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Quat4d, Double) -> Quat4d)
        r.add("multiply(Quat4d, Quat4d)", .composite(.products), .standard, .standard, FirebladeMath.multiply(_:_:) as (Quat4d, Quat4d) -> Quat4d)
        r.add("add(Quat4d, Quat4d)", .exact, .standard, .standard, FirebladeMath.add(_:_:) as (Quat4d, Quat4d) -> Quat4d)
        r.add("subtract(Quat4d, Quat4d)", .exact, .standard, .standard, FirebladeMath.subtract(_:_:) as (Quat4d, Quat4d) -> Quat4d)
        r.add("Mat3x3d.init(rotation: Double, axis: SIMD3<Double>)", .composite(.loose), .standard, .unitVector, Mat3x3d.init(rotation:axis:) as (Double, SIMD3<Double>) -> Mat3x3d)
        r.add("Mat3x3f.init(rotation: Float, axis: SIMD3<Float>)", .composite(.loose), .standard, .unitVector, Mat3x3f.init(rotation:axis:) as (Float, SIMD3<Float>) -> Mat3x3f)
        r.add("Mat4x4d.init(rotation: Double, axis: SIMD3<Double>)", .composite(.loose), .standard, .unitVector, Mat4x4d.init(rotation:axis:) as (Double, SIMD3<Double>) -> Mat4x4d)
        r.add("Mat4x4d.init(upperLeft: Mat3x3d)", .exact, .standard, Mat4x4d.init(upperLeft:) as (Mat3x3d) -> Mat4x4d)
        r.add("Mat4x4d.init(translation: SIMD3<Double>, scale: SIMD3<Double>)", .exact, .standard, .standard, Mat4x4d.init(translation:scale:) as (SIMD3<Double>, SIMD3<Double>) -> Mat4x4d)
        r.add("Mat4x4d.look(from: SIMD3<Double>, at: SIMD3<Double>, up: SIMD3<Double>)", .composite(.loose), .standard, .standard, .unitVector, Mat4x4d.look(from:at:up:) as (SIMD3<Double>, SIMD3<Double>, SIMD3<Double>) -> Mat4x4d)
        r.add("Mat4x4f.init(rotation: Float, axis: SIMD3<Float>)", .composite(.loose), .standard, .unitVector, Mat4x4f.init(rotation:axis:) as (Float, SIMD3<Float>) -> Mat4x4f)
        r.add("Mat4x4f.init(upperLeft: Mat3x3f)", .exact, .standard, Mat4x4f.init(upperLeft:) as (Mat3x3f) -> Mat4x4f)
        r.add("Mat4x4f.init(translation: SIMD3<Float>, scale: SIMD3<Float>)", .exact, .standard, .standard, Mat4x4f.init(translation:scale:) as (SIMD3<Float>, SIMD3<Float>) -> Mat4x4f)
        r.add("Mat4x4f.look(from: SIMD3<Float>, at: SIMD3<Float>, up: SIMD3<Float>)", .composite(.loose), .standard, .standard, .unitVector, Mat4x4f.look(from:at:up:) as (SIMD3<Float>, SIMD3<Float>, SIMD3<Float>) -> Mat4x4f)
        r.add("Mat4x4f.lookAt(eye: Vec3f, center: Vec3f, up: Vec3f)", .composite(.loose), .standard, .standard, .unitVector, Mat4x4f.lookAt(eye:center:up:) as (Vec3f, Vec3f, Vec3f) -> Mat4x4f)
        r.add("Mat4x4f.rotation(angle: Float, axis: Vec3f)", .composite(.loose), .standard, .unitVector, Mat4x4f.rotation(angle:axis:) as (Float, Vec3f) -> Mat4x4f)
        r.add("Mat4x4f.translation(x: Float, y: Float, z: Float)", .exact, .standard, .standard, .standard, specials: true, Mat4x4f.translation(x:y:z:) as (Float, Float, Float) -> Mat4x4f)
        r.add("Mat4x4f.scaling(x: Float, y: Float, z: Float)", .exact, .standard, .standard, .standard, specials: true, Mat4x4f.scaling(x:y:z:) as (Float, Float, Float) -> Mat4x4f)
        r.add("Mat4x4f.init(orientation: Quat4f)", .composite(.tight), .unitQuaternion, Mat4x4f.init(orientation:) as (Quat4f) -> Mat4x4f)
        r.add("Mat4x4f.perspectiveRH(fovy: Float, aspect: Float, zNear: Float, zFar: Float)", .composite(.loose), .uniform(0.1...3), .uniform(0.5...3), .uniform(0.01...1), .uniform(10...1000), Mat4x4f.perspectiveRH(fovy:aspect:zNear:zFar:) as (Float, Float, Float, Float) -> Mat4x4f)
        r.add("Mat4x4f.perspectiveLH(fovy: Float, aspect: Float, zNear: Float, zFar: Float)", .composite(.loose), .uniform(0.1...3), .uniform(0.5...3), .uniform(0.01...1), .uniform(10...1000), Mat4x4f.perspectiveLH(fovy:aspect:zNear:zFar:) as (Float, Float, Float, Float) -> Mat4x4f)
        r.add("Mat4x4f.orthographicRH(left: Float, right: Float, top: Float, bottom: Float, zNear: Float, zFar: Float)", .exact, .uniform(-10...(-1)), .uniform(1...10), .uniform(1...10), .uniform(-10...(-1)), .uniform(0.01...1), .uniform(10...100), Mat4x4f.orthographicRH(left:right:top:bottom:zNear:zFar:) as (Float, Float, Float, Float, Float, Float) -> Mat4x4f)
        r.add("Mat4x4f.orthographicLH(left: Float, right: Float, top: Float, bottom: Float, zNear: Float, zFar: Float)", .exact, .uniform(-10...(-1)), .uniform(1...10), .uniform(1...10), .uniform(-10...(-1)), .uniform(0.01...1), .uniform(10...100), Mat4x4f.orthographicLH(left:right:top:bottom:zNear:zFar:) as (Float, Float, Float, Float, Float, Float) -> Mat4x4f)
        r.add("Mat4x4d.perspectiveRH(fovy: Double, aspect: Double, zNear: Double, zFar: Double)", .composite(.loose), .uniform(0.1...3), .uniform(0.5...3), .uniform(0.01...1), .uniform(10...1000), Mat4x4d.perspectiveRH(fovy:aspect:zNear:zFar:) as (Double, Double, Double, Double) -> Mat4x4d)
        r.add("Mat4x4d.perspectiveLH(fovy: Double, aspect: Double, zNear: Double, zFar: Double)", .composite(.loose), .uniform(0.1...3), .uniform(0.5...3), .uniform(0.01...1), .uniform(10...1000), Mat4x4d.perspectiveLH(fovy:aspect:zNear:zFar:) as (Double, Double, Double, Double) -> Mat4x4d)
        r.add("Mat4x4d.orthographicRH(left: Double, right: Double, top: Double, bottom: Double, zNear: Double, zFar: Double)", .exact, .uniform(-10...(-1)), .uniform(1...10), .uniform(1...10), .uniform(-10...(-1)), .uniform(0.01...1), .uniform(10...100), Mat4x4d.orthographicRH(left:right:top:bottom:zNear:zFar:) as (Double, Double, Double, Double, Double, Double) -> Mat4x4d)
        r.add("Mat4x4d.orthographicLH(left: Double, right: Double, top: Double, bottom: Double, zNear: Double, zFar: Double)", .exact, .uniform(-10...(-1)), .uniform(1...10), .uniform(1...10), .uniform(-10...(-1)), .uniform(0.01...1), .uniform(10...100), Mat4x4d.orthographicLH(left:right:top:bottom:zNear:zFar:) as (Double, Double, Double, Double, Double, Double) -> Mat4x4d)
        r.add("Quat4d.init(Quat4f)", .exact, .standard, Quat4d.init(_:) as (Quat4f) -> Quat4d)
        r.add("Quat4d.init(angle: Double, axis: SIMD3<Double>)", .composite(.loose), .standard, .unitVector, Quat4d.init(angle:axis:) as (Double, SIMD3<Double>) -> Quat4d)
        r.add("Quat4d.init(rotation: Mat3x3d)", .composite(.loose), .rotationMatrix, Quat4d.init(rotation:) as (Mat3x3d) -> Quat4d)
        r.add("Quat4d.init(rotation: Mat4x4d)", .composite(.loose), .rotationMatrix, Quat4d.init(rotation:) as (Mat4x4d) -> Quat4d)
        r.add("Quat4d.init(from: SIMD3<Double>, to: SIMD3<Double>)", .composite(.loose), .unitVector, .unitVector, Quat4d.init(from:to:) as (SIMD3<Double>, SIMD3<Double>) -> Quat4d)
        r.add("Quat4d.init(pitch: Double, yaw: Double, roll: Double)", .composite(.loose), .uniform(-3.14...3.14), .uniform(-3.14...3.14), .uniform(-3.14...3.14), specials: true, Quat4d.init(pitch:yaw:roll:) as (Double, Double, Double) -> Quat4d)
        r.add("Quat4f.fromEulerAngles_123(Vec3f)", .composite(.loose), .uniform(-3.14...3.14), Quat4f.fromEulerAngles_123(_:) as (Vec3f) -> Quat4f)
        r.add("Quat4f.fromEulerAngles_132(Vec3f)", .composite(.loose), .uniform(-3.14...3.14), Quat4f.fromEulerAngles_132(_:) as (Vec3f) -> Quat4f)
        r.add("Quat4f.fromEulerAngles_213(Vec3f)", .composite(.loose), .uniform(-3.14...3.14), Quat4f.fromEulerAngles_213(_:) as (Vec3f) -> Quat4f)
        r.add("Quat4f.fromEulerAngles_231(Vec3f)", .composite(.loose), .uniform(-3.14...3.14), Quat4f.fromEulerAngles_231(_:) as (Vec3f) -> Quat4f)
        r.add("Quat4f.fromEulerAngles_312(Vec3f)", .composite(.loose), .uniform(-3.14...3.14), Quat4f.fromEulerAngles_312(_:) as (Vec3f) -> Quat4f)
    }

    private mutating func registerPart7() {
        var r = self
        defer { self = r }
        r.add("Quat4f.fromEulerAngles_321(Vec3f)", .composite(.loose), .uniform(-3.14...3.14), Quat4f.fromEulerAngles_321(_:) as (Vec3f) -> Quat4f)
        r.add("Quat4f.init(pitch: Float, yaw: Float, roll: Float)", .composite(.loose), .uniform(-3.14...3.14), .uniform(-3.14...3.14), .uniform(-3.14...3.14), specials: true, Quat4f.init(pitch:yaw:roll:) as (Float, Float, Float) -> Quat4f)
        r.add("Quat4f.init(angle: Float, axis: SIMD3<Float>)", .composite(.loose), .standard, .unitVector, Quat4f.init(angle:axis:) as (Float, SIMD3<Float>) -> Quat4f)
        r.add("Quat4f.init(rotation: Mat3x3f)", .composite(.loose), .rotationMatrix, Quat4f.init(rotation:) as (Mat3x3f) -> Quat4f)
        r.add("Quat4f.init(rotation: Mat4x4f)", .composite(.loose), .rotationMatrix, Quat4f.init(rotation:) as (Mat4x4f) -> Quat4f)
        r.add("Quat4f.init(from: SIMD3<Float>, to: SIMD3<Float>)", .composite(.loose), .unitVector, .unitVector, Quat4f.init(from:to:) as (SIMD3<Float>, SIMD3<Float>) -> Quat4f)
        r.add("Mat4x4f.eulerAnglesXYZ", .composite(.loose), .rotationMatrix) { (matrix: Mat4x4f) in matrix.eulerAnglesXYZ }
        r.add("Mat4x4d.eulerAnglesXYZ", .composite(.loose), .rotationMatrix) { (matrix: Mat4x4d) in matrix.eulerAnglesXYZ }
    }

}

// swiftlint:enable line_length
