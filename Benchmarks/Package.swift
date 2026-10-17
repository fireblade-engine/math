// swift-tools-version: 6.3
// Runtime benchmarks for FirebladeMath, kept in a separate package so that the
// benchmark dependency never becomes part of FirebladeMath's dependency graph.
//
// Run from this directory:
//   swift package benchmark
// Benchmark the portable (non-simd) code path on Apple platforms:
//   FRB_MATH_BENCHMARK_NO_SIMD=1 swift package benchmark

import class Foundation.ProcessInfo
import PackageDescription

let disableSIMD = ProcessInfo.processInfo.environment["FRB_MATH_BENCHMARK_NO_SIMD"] != nil

let package = Package(
    name: "FirebladeMathBenchmarks",
    platforms: [.macOS(.v13)],
    dependencies: [
        // The package identity of a path dependency is its directory name, i.e. the repository name.
        .package(path: "..", traits: disableSIMD ? [] : [.defaults]),
        .package(url: "https://github.com/ordo-one/benchmark", .upToNextMajor(from: "1.38.0"))
    ],
    targets: [
        .executableTarget(
            name: "FirebladeMathBenchmarks",
            dependencies: [
                .product(name: "FirebladeMath", package: "math"),
                .product(name: "Benchmark", package: "benchmark")
            ],
            path: "Benchmarks/FirebladeMathBenchmarks",
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "benchmark")
            ]
        )
    ]
)
