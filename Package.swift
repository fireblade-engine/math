// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

/// We define global swift settings to control SIMD usage.
/// The gist is, that we will import and use SIMD implementations where available.
/// Otherwise we fall back to our own implementation.
let swiftSettings: [SwiftSetting]?
#if canImport(simd)
swiftSettings = [
    .define("FRB_USE_SIMD")
]
#else
swiftSettings = nil
#endif


let package = Package(
    name: "FirebladeMath",
    products: [
        .library(
            name: "FirebladeMath",
            type: .static,
            targets: ["FirebladeMath"])
    ],
    targets: [
        .target(
            name: "FirebladeMath",
            dependencies: [],
            swiftSettings: swiftSettings),
        .testTarget(
            name: "FirebladeMathTests",
            dependencies: ["FirebladeMath"],
            swiftSettings: swiftSettings)
    ]
)
