# Technology Stack: Fireblade Game Engine

## Core Languages
*   **Primary:** Swift 6.2+ (Leveraging modern features like Macros, C++ Interoperability, and Structured Concurrency).
    *   **Native-First Directive:** strictly prioritize pure Swift types (e.g., `String`, `Array`, `Data`) over Objective-C bridged types (`NSString`, `NSArray`, `NSData`). Avoid `Foundation` types that rely on Objective-C runtime where native Swift equivalents exist.
    *   **Toolchain:** Official Swift Toolchain from Xcode 26.2+ (macOS) or equivalent (Linux/Windows).
*   **Fallback:** C, C++ (Used for low-level system interaction or existing library integration where Swift is not feasible).

## Graphics & Rendering
*   **API:** Vulkan (Primary backend for high-performance 3D and 2D rendering).
*   **Abstraction Layer:** Fireblade RHI (Modular, protocol-based Rendering Hardware Interface).
    *   **Texture Support:** Support for specific pixel formats (`rgba8Unorm`, `bgra8UnormSrgb`) to handle linear data (SDF/MSDF) and color data correctly.
*   **Text Rendering:** Dedicated MSDF (Multi-channel Signed Distance Field) system.
    *   **Pipeline:** Dual pipelines for World-Space (3D) and Screen-Space (HUD) text.
    *   **Generator:** Pure Swift offline tool for generating MSDF atlases from font files.
*   **Validation:** `ValidationConfiguration` for structured control over Vulkan validation layers and debug messengers.
*   **Libraries:** `Vulkan` (Swift Vulkan bindings), `SDL3` (Platform/Surface).
*   **Shading Language:** SPIR-V (Targeted via GLSL or Slang).
*   **Shader Toolchain:**
    *   **Compilation:** `glslang` (GLSL to SPIR-V).
    *   **Reflection:** `SPIRV-Cross` (Reflection and cross-compilation).

## Platform & Systems

*   **Platform Abstraction Layer (PAL):**
    *   **Selection:** Managed via **Swift Package Manager Traits** (Swift 6.1+).
    *   **SDL3 (Default):** Primary backend for cross-platform handling of windows, input, and hardware events. Enabled via the `sdl` trait. Defines `FRB_USE_SDL`.
    *   **GLFW (Alternative):** Lightweight backend for windowing and input. Enabled via the `glfw` trait. Defines `FRB_USE_GLFW`.
    *   **Switching:** Use `swift build --trait glfw` to switch to GLFW.
*   **Operating Systems:** 
    *   **Engine/Runtime:** macOS, Linux, Windows, iOS, Android.
    *   **Editor:** macOS, Linux, Windows.

## User Interface
*   **Editor & Debug GUI:** Dear ImGui (For efficient, immediate-mode UI).
*   **In-Game HUD:** Dear ImGui (Primary).

## Project Management & Build
*   **Build System:** Swift Package Manager (SPM).
*   **Task Automation:** GNU Make (Central entry point for setup, build, test, lint).
*   **Tool Management:** [Mint](https://github.com/yonaskolb/Mint) (For consistent tool versions across the team).
*   **Macros:** Centralized `FirebladeMacros` package in `Macros/` for project-wide source transformations (e.g., `@StaticMemberMirror`).
*   **App Bundling:** [swift-bundler](https://github.com/stackotter/swift-bundler) (For cross-platform app packaging).
*   **Architecture Pattern:** Entity-Component-System (ECS) - Data-oriented core.

## Code Structure & Conventions
*   **One Major Type Per File:** Every `struct`, `class`, `enum`, or `protocol` definition that exceeds 5 lines of code must reside in its own dedicated file.
*   **Type-Filename Correspondence:** The source filename MUST always match the top-level/root type name (e.g., `struct Entity` <-> `Entity.swift`).
*   **Source of Truth:** The Type Name is the source of truth for the Filename.
*   **Inner Types:** Must be defined in an extension of the outer type, not nested inside the struct/class body.

## Testing
*   **Framework:** `Testing` module (Swift 6 native testing).
*   **Constraint:** `XCTest` is **strictly prohibited**.
*   **Standard:** All tests must pass with **zero warnings**.
*   **CI Execution:** macOS CI builds and tests in Release mode (`-c release`) with strict warnings (`-Xswiftc -warnings-as-errors`).

## Error Handling & Safety
*   **Primary Strategy:** Use Swift's `throw` / `try` / `catch` for all synchronous error propagation.
*   **Secondary Strategy:** Use `Result` types or optional binding (`if let`, `guard let`) for asynchronous or fallible operations where throwing is not appropriate.
*   **Zero Tolerance:** The following patterns are **strictly prohibited** and treated as build failures:
    *   `fatalError()`
    *   Force unwrapping (`!`)
    *   Force try (`try!`)
    *   Force cast (`as!`)
    *   `try?` (swallows errors; use `do-catch`)
    *   `NSError` (Use native Swift `Error` enums).

## Legacy API Avoidance (Native-First Directive)
Strictly prioritize native Swift types over bridged Foundation/Objective-C types.

| Legacy (Avoid) | Swift (Preferred) | Notes |
| :--- | :--- | :--- |
| `NSMutableData` | `Data`, `[UInt8]` | Use `Data(capacity:)` or `Array(unsafeUninitializedCapacity:)` for manual buffer management. |
| `NSMutableArray` | `Array`, `[Element]` | Standard Swift arrays are performant and value types. |
| `NSMutableDictionary` | `Dictionary` | |
| `NSNumber` | `Int`, `Double`, etc. | |
| `NSTemporaryDirectory()` | `FileManager.default.temporaryDirectory` | |
| `NSString`, `NSArray` | `String`, `Array` | |

## External Dependencies
*   **Logging:** [swift-log](https://github.com/apple/swift-log)
*   **UI:** [SwiftImGui](https://github.com/ctreffs/SwiftImGui) (Docking branch)
*   **Serialization:** [Yams](https://github.com/jpsim/Yams) (YAML support)
*   **CLI:** [swift-argument-parser](https://github.com/apple/swift-argument-parser)

## Dependency Management & Portability
*   **Strategy:** Vendored Approach. Core dependencies (Vulkan, SDL3) reside locally in the `Dependencies/` directory to ensure "plug and play" capability across different machines.
*   **Primary Tool:** Swift Package Manager (SPM).
*   **Vulkan/SDL3:** Managed as local Swift Packages wrapping pre-compiled binaries (XCFrameworks for Apple, .so/.dll for others).
*   **Input & Windowing:** Extended PAL with cursor mode control (normal, hidden, captured) and keyboard polling support.
*   **Advanced Features:**
    *   **SE-0342:** Consider "Statically link runtime libraries by default" for self-contained deployments.
    *   **SE-0482:** Leverage "Binary targets for non-Apple platforms" to support pre-compiled dependencies on Linux/Windows.
*   **ImGui:** Referenced as a remote SPM dependency to minimize maintenance of stable, third-party Swift wrappers.
*   **Automation:** The `Makefile` (run `make setup`) is used to bootstrap the environment, install tools via Mint, and download vendored binaries.

