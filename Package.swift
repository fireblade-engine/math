// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .define("FRB_MATH_USE_SIMD", .when(traits: ["simd"]))
]

let defaultTraits: [String]
#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
defaultTraits = ["simd"]
#else
defaultTraits = []
#endif

let package = Package(
    name: "FirebladeMath",
    products: [
        .library(
            name: "FirebladeMath",
            targets: ["FirebladeMath"])
    ],
    traits: [
        .trait(name: "simd"),
        .trait(name: "default", enabledTraits: Set(defaultTraits))
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.4.6")
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
