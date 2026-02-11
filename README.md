# FirebladeMath

[![license](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE)
[![macOS](https://github.com/fireblade-engine/math/actions/workflows/ci-macos.yml/badge.svg)](https://github.com/fireblade-engine/math/actions/workflows/ci-macos.yml)
[![Linux](https://github.com/fireblade-engine/math/actions/workflows/ci-linux.yml/badge.svg)](https://github.com/fireblade-engine/math/actions/workflows/ci-linux.yml)
[![Windows](https://github.com/fireblade-engine/math/actions/workflows/ci-windows.yml/badge.svg)](https://github.com/fireblade-engine/math/actions/workflows/ci-windows.yml)
[![swift-version-compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ffireblade-engine%2Fmath%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/fireblade-engine/math) 
[![platform-compatilibilty](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ffireblade-engine%2Fmath%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/fireblade-engine/math) 
[![Documentation](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ffireblade-engine%2Fmath%2Fbadge%3Ftype%3Ddocumentation)](https://swiftpackageindex.com/fireblade-engine/math/documentation) 

A dependency-free, lightweight, fast math library for 2D and 3D vectors, quaternions, and matrices in Swift with (optional) SIMD support. It is developed and maintained as part of the [Fireblade Game Engine project](https://github.com/fireblade-engine).

## ✨ Features

- **Vectors:** `Vec2`, `Vec3`, `Vec4` for `Float`, `Double`, `Int`, and `UInt`.
- **Matrices:** `Mat2x2`, `Mat3x3`, `Mat4x4` for `Float` and `Double`.
- **Quaternions:** `Quat4f` and `Quat4d`.
- **Geometric Types:** `Point`, `Size`, `Rect`.
- **Math Functions:** A comprehensive set of functions including `sin`, `cos`, `tan`, `asin`, `acos`, `atan2`, `dot`, `cross`, `normalize`, `reflect`, `refract`, and many more.
- **SIMD Support:** Leveraging hardware acceleration where available, with a fallback implementation when SIMD is not supported.
- **Swift 6 Ready:** Fully compatible with Swift 6 and `Sendable` conformance.

## 🚀 Getting Started

### 📋 Prerequisites

* Swift 6.1 or higher
* Swift Package Manager (SPM)

### 💻 Installation

Add Fireblade Math as a dependency to your `Package.swift` file:

```swift
// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "YourPackageName",
    dependencies: [
        .package(url: "https://github.com/fireblade-engine/math.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "YourTargetName",
            dependencies: ["FirebladeMath"])
    ]
)
```

For more detailed information and API reference, please refer to the [comprehensive documentation](https://swiftpackageindex.com/fireblade-engine/math/documentation).

### 🛠 SIMD Traits

Starting with version 1.0.0, FirebladeMath uses Swift traits to manage SIMD support. By default, SIMD is enabled on Apple platforms. You can manually control it in your package configuration if needed.

## 📖 Documentation

Comprehensive documentation for FirebladeMath is available online:

- [Latest Documentation on Swift Package Index](https://swiftpackageindex.com/fireblade-engine/math/documentation)
- [Main Branch Documentation on GitHub Pages](https://fireblade-engine.github.io/math/main/documentation/fireblademath/)

## 📖 Usage Examples

### Vectors

```swift
import FirebladeMath

let v1 = Vec3f(1, 2, 3)
let v2 = Vec3f(4, 5, 6)

let dotProduct = dot(v1, v2)
let crossProduct = cross(v1, v2)
let unitVector = normalize(v1)
```

### Matrices

```swift
import FirebladeMath

// Create a transformation matrix
var modelMatrix = Mat4x4f.identity
modelMatrix.translate(by: [10, 20, 30])
modelMatrix.rotate(by: .pi / 2, axis: [0, 1, 0])

// Project a point
let projection = Mat4x4f.perspectiveRH(fovy: .pi / 4, aspect: 16/9, zNear: 0.1, zFar: 100)
```

### Quaternions

```swift
import FirebladeMath

let q = Quat4f(angle: .pi / 4, axis: [0, 1, 0])
let rotatedVector = q * Vec3f(1, 0, 0)
```

## 💁 How to contribute

If you want to contribute please see the [CONTRIBUTION GUIDE](CONTRIBUTING.md) first. 

1. `git clone git@github.com:fireblade-engine/math.git`
2. `cd math`
3. `make setupEnvironment`

Before committing code please ensure to run:

- `make precommit`

This project is currently maintained by [@ctreffs](https://github.com/ctreffs).   
See also the list of [contributors](https://github.com/fireblade-engine/math/contributors) who participated in this project.

## 🔏 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ♻ Alternatives

- [alejandro-isaza/Upsurge](https://github.com/alejandro-isaza/Upsurge)
- [capnslipp/SCNMathExtensions](https://github.com/capnslipp/SCNMathExtensions)
- [davidskrundz/math](https://github.com/davidskrundz/math)
- [dn-m/Math](https://github.com/dn-m/Math)
- [Jounce/Surge](https://github.com/Jounce/Surge)
- [jph00/basemath](https://github.com/jph00/basemath)
- [mattt/euler](https://github.com/mattt/euler)
- [nicklockwood/VectorMath](https://github.com/nicklockwood/VectorMath)
- [SwiftGFX/SwiftMath](https://github.com/SwiftGFX/SwiftMath)
- [SwiftGL/Math](https://github.com/SwiftGL/Math)
- [taketo1024/swiftymath](https://github.com/taketo1024/swiftymath)
- [timsearle/euclid](https://github.com/timsearle/euclid)