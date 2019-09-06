// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
#if canImport(simd)
let swiftSettings: [SwiftSetting] = [
    //.define("USE_SIMD", .when(platforms: [.iOS, .macOS, .tvOS, .watchOS])),
    //.define("NO_SIMD", .when(platforms: [.linux])),
    

    .define("USE_SIMD")

    //.define("NO_SIMD")
]
#endif
let package = Package(
    name: "FirebladeMath",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "FirebladeMath",
            targets: ["FirebladeMath"])
    ],
    dependencies: [
        //.package(url: "https://github.com/SwiftGL/Math.git", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "FirebladeMath",
            dependencies: [],
            swiftSettings: swiftSettings),
        .testTarget(
            name: "FirebladeMathTests",
            dependencies: ["FirebladeMath"],
            swiftSettings: swiftSettings),
    ]
)
