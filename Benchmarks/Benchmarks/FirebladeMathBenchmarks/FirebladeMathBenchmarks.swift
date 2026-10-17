import Benchmark
import FirebladeMath

let benchmarks: @Sendable () -> Void = {
    Benchmark.defaultConfiguration = .init(
        metrics: [.wallClock, .throughput, .mallocCountTotal],
        scalingFactor: .kilo,
        maxDuration: .seconds(2),
        thresholds: [.mallocCountTotal: .init(absolute: [.p90: 0])]
    )

    let axis = normalize(Vec3f(1, 2, 3))
    let rotation = Quat4f(angle: 0.7, axis: axis)
    let transform = Mat4x4f(rotation: 0.3, axis: Vec3f(0, 1, 0)) * Mat4x4f(translation: Vec3f(1, 2, 3))

    // MARK: - Own implementation on every platform

    //
    // Some of these compose FirebladeMath's thin vector/libm wrappers (normalize, cross, sin, ...),
    // but the algorithm itself is FirebladeMath's own.

    Benchmark("Mat4x4f.adjugate") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(adjugate(identity(transform)))
        }
    }

    Benchmark("Mat4x4f.initRotation") { benchmark in
        for index in benchmark.scaledIterations {
            blackHole(Mat4x4f(rotation: Float(index) * 0.001, axis: identity(axis)))
        }
    }

    Benchmark("Mat4x4f.lookAt") { benchmark in
        for index in benchmark.scaledIterations {
            let eye = Vec3f(Float(index) * 0.001, 2, 5)
            blackHole(Mat4x4f.look(from: eye, at: identity(Vec3f.zero), up: Vec3f(0, 1, 0)))
        }
    }

    Benchmark("Mat4x4f.perspectiveRH") { benchmark in
        for index in benchmark.scaledIterations {
            let aspect = 1.5 + Float(index % 100) * 0.001
            blackHole(Mat4x4f.perspectiveRH(fovy: 1.2, aspect: aspect, zNear: 0.1, zFar: identity(100)))
        }
    }

    Benchmark("Quat4f.fromEulerAngles123") { benchmark in
        for index in benchmark.scaledIterations {
            blackHole(Quat4f.fromEulerAngles_123(Vec3f(Float(index) * 0.001, 0.2, 0.3)))
        }
    }

    Benchmark("Quat4f.toEulerAngles123") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(quaternionToEulerAngles_123(identity(rotation)))
        }
    }

    Benchmark("Mat4x4f.flatSubscript") { benchmark in
        for _ in benchmark.scaledIterations {
            let source = identity(transform)
            var sum: Float = 0
            for index in 0..<16 {
                sum += source[index]
            }
            blackHole(sum)
        }
    }

    Benchmark("Quat4f.iteration") { benchmark in
        for _ in benchmark.scaledIterations {
            var sum: Float = 0
            for component in identity(rotation) {
                sum += component
            }
            blackHole(sum)
        }
    }

    // MARK: - Own implementation on the portable (non-simd) path

    //
    // With the `simd` trait (default on Apple platforms) these forward to Apple's simd library.
    // Their numbers describe FirebladeMath's code only on Linux/Windows (CI) or locally with
    // FRB_MATH_BENCHMARK_NO_SIMD=1.

    Benchmark("Mat4x4f.initColumns") { benchmark in
        let column0 = Vec4f(1, 2, 3, 4)
        let column1 = Vec4f(5, 6, 7, 8)
        let column2 = Vec4f(9, 10, 11, 12)
        let column3 = Vec4f(13, 14, 15, 16)
        for index in benchmark.scaledIterations {
            let scale = Float(index)
            blackHole(Mat4x4f(column0 * scale, column1 * scale, column2 * scale, column3 * scale))
        }
    }

    Benchmark("Mat4x4f.multiply") { benchmark in
        var matrix = Mat4x4f(diagonal: Vec4f(repeating: 0.5))
        let factor = Mat4x4f(diagonal: Vec4f(repeating: 1.0000001))
        for _ in benchmark.scaledIterations {
            matrix = identity(matrix * factor)
        }
        blackHole(matrix)
    }

    Benchmark("Mat4x4f.inverse") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(inverse(identity(transform)))
        }
    }

    Benchmark("Mat4x4f.fromQuaternion") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(matrix4x4(from: identity(rotation)))
        }
    }

    Benchmark("Quat4f.fromMatrix") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(quaternion(matrix: identity(transform)))
        }
    }

    Benchmark("Quat4f.multiply") { benchmark in
        var quaternion = rotation
        for _ in benchmark.scaledIterations {
            quaternion = identity(quaternion * rotation)
        }
        blackHole(quaternion)
    }

    Benchmark("Quat4f.actNormalize") { benchmark in
        var vector = Vec3f(1, 2, 3)
        let step = Quat4f(angle: 0.001, axis: axis)
        for _ in benchmark.scaledIterations {
            vector = identity(normalize(act(step, vector)))
        }
        blackHole(vector)
    }
}
