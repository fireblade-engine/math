# FirebladeMath

[![license](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE)
[![macOS](https://github.com/fireblade-engine/math/actions/workflows/ci-macos.yml/badge.svg)](https://github.com/fireblade-engine/math/actions/workflows/ci-macos.yml)
[![Linux](https://github.com/fireblade-engine/math/actions/workflows/ci-linux.yml/badge.svg)](https://github.com/fireblade-engine/math/actions/workflows/ci-linux.yml)
[![Windows](https://github.com/fireblade-engine/math/actions/workflows/ci-windows.yml/badge.svg)](https://github.com/fireblade-engine/math/actions/workflows/ci-windows.yml)
[![swift-version-compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ffireblade-engine%2Fmath%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/fireblade-engine/math) 
[![platform-compatilibilty](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ffireblade-engine%2Fmath%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/fireblade-engine/math) 

A dependency-free, lightweight, fast math library for 2D and 3D vectors, quaternions, and matrices in Swift with (optional) SIMD support. It is developed and maintained as part of the [Fireblade Game Engine project](https://github.com/fireblade-engine).

## ✨ Features

- **Vectors:** `Vec2`, `Vec3`, `Vec4` for `Float`, `Double`, `Int`, and `UInt`.
- **Matrices:** `Mat2x2`, `Mat3x3`, `Mat4x4` for `Float` and `Double`.
- **Quaternions:** `Quat4f` and `Quat4d`.
- **Geometric Types:** `Point`, `Size`, `Rect`.
- **Math Functions:** A comprehensive set of functions including `sin`, `cos`, `tan`, `asin`, `acos`, `atan2`, `dot`, `cross`, `normalize`, `reflect`, `refract`, and many more.
- **One import, every platform:** `import FirebladeMath` is all you need, including the scalar functions (`sin`, `sqrt`, `pow`, ...). FirebladeMath resolves the platform's C library (Darwin, Glibc, Musl, Bionic, WASILibc, ucrt) itself, so the API is the same on macOS, iOS, Linux, Windows, WebAssembly, and Android.
- **SIMD Support:** Uses Apple's `simd` where available, with a portable implementation everywhere else.
- **Identical results up to rounding:** Every public function is checked against reference values recorded on macOS on each platform CI tests on, and the portable implementation is compared against Apple's `simd`.
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
        .package(url: "https://github.com/fireblade-engine/math.git", from: "1.4.0")
    ],
    targets: [
        .target(
            name: "YourTargetName",
            dependencies: ["FirebladeMath"])
    ]
)
```

For more detailed information and API reference, please refer to the [comprehensive documentation](https://fireblade-engine.github.io/math/documentation/fireblademath/).

### 🛠 SIMD Trait

FirebladeMath uses the Swift package trait `simd` to select its implementation. The trait is enabled by default on Apple platforms, where FirebladeMath builds on Apple's `simd`; on all other platforms the portable implementation is used. Both produce the same results up to rounding.

To use the portable implementation on Apple platforms as well, depend on the package without its default traits:

```swift
.package(url: "https://github.com/fireblade-engine/math.git", from: "1.4.0", traits: [])
```

## 📖 Documentation

Comprehensive documentation for FirebladeMath is available online:

- [Documentation](https://fireblade-engine.github.io/math/documentation/fireblademath/)

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
3. `make setup`

Before committing code please ensure to run:

- `make pre-commit` (formats, lints, and runs the tests)

Further checks, all run in CI:

| Command | Purpose |
| --- | --- |
| `make test-portable` | Runs the tests without the `simd` trait; on Apple platforms this compares the portable implementation against Apple's `simd`. |
| `make check-inlinable` | Verifies that the public API is inlinable across module boundaries. |
| `make check-simd-coverage` | Verifies that every `simd`-backed function has a portable-vs-`simd` comparison test. |
| `make check-reference-coverage` | Verifies that every public function has cross-platform reference values. |
| `make reference-values` | Regenerates the reference values (macOS, default traits) after an intentional change of results. |
| `make benchmark` | Runs the benchmarks of FirebladeMath's own implementations in [`Benchmarks/`](Benchmarks). |
| `make benchmark-thresholds-check` | Checks the benchmarks' allocation thresholds (`make benchmark-thresholds-update` records new ones). |

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
