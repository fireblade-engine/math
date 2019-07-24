// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebladeMath",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v11),
        .tvOS(.v11)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "FirebladeMath",
            targets: ["FirebladeMath"])
    ],
    dependencies: [
        //.package(url: "https://github.com/nicklockwood/VectorMath.git", from: "0.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "FirebladeMath",
            dependencies: []),
        .testTarget(
            name: "FirebladeMathTests",
            dependencies: ["FirebladeMath"])
    ]
)
