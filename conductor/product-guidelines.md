# Product Guidelines

## Project Commandments
1.  **Code Safety:** Zero tolerance for `fatalError`, force unwraps (`!`), or force tries (`try!`).
2.  **Legacy API Avoidance:** Avoid Objective-C based APIs (e.g., `NSMutableData`, `NSArray`, `NSError`) in favor of native Swift types (`Data`, `Array`, `Error`) unless required for strict framework interoperability. Discourage utilities like `NSTemporaryDirectory()` in favor of `FileManager` APIs.
3.  **Verification Standard:** Snapshot tests are the "Gold Standard". They must never be re-recorded without explicit, manual user verification.
4.  **Verification Rigor:** Image-based verification must be taken seriously; assumptions and loose sampling are prohibited.
5.  **Optimized Allocation:** Dynamic array appending is discouraged when the final size is known. Use `Array(unsafeUninitializedCapacity:initializingWith:)` for optimal performance. Consider `ContiguousArray` for non-bridged types.
6.  **Strict Error Handling:** Optional `try?` is prohibited. All errors must be handled or propagated.
7.  **Structured Types:** Error types and inner types must be namespaced via extensions to maintain clean type definitions.
8.  **Comprehensive Documentation:** All public APIs and significant internal logic must be documented using Swift's `///` format, including parameters, return values, errors, and algorithmic complexity where applicable.

## Documentation & API Design Style
*   **Technical & Precise (Engine Internals):** For the core engine (Fireblade) and performance-critical systems, documentation and API design must be rigorous. Focus on performance implications, memory safety, and explicit low-level details. Assumptions about memory ownership and thread safety must be clearly stated.
*   **Modular & Clear (Public API & Plugins):** The plugin system and game-facing APIs should emphasize modularity. Use clear naming conventions and ensure that the separation of concerns is obvious, making the "plug-and-play" nature of the engine intuitive.
*   **Educational Context (Where Applicable):** While precision is paramount, include "Why" explanations and examples for complex architectural decisions or common usage patterns to assist students and hobbyists in understanding the engine's design philosophy.

## Coding Standards
*   **Swift-First:** leverage Swift's type system, value semantics, and safety features (e.g., ARC, optionals) as the default.
    *   **Pure Swift Types:** strictly discourage the use of Objective-C and `NS*` APIs (e.g., `NSString`, `NSArray`). Use native Swift types (e.g., `String`, `Array`) exclusively unless interacting with legacy system frameworks.
*   **Performance-Critical Code:** In hot paths (rendering, ECS), prioritize performance over "swifty" syntax if necessary, but document the deviation.
*   **Interoperability:** Ensure C/C++ fallback code is strictly isolated and wrapped in safe Swift interfaces where possible.
*   **File Structure:** Adhere to the "One File Per Type" rule. Any `struct`, `class`, `enum`, or `protocol` definition exceeding 5 lines must reside in its own file named `<TypeName>.swift`.
    *   *Exceptions:* Private helper types or small extensions tightly coupled to the main type.
    *   **Inner Types:** Types defined within other types (nested types) MUST be defined in an extension of the outer type.
        *   *Correct:* `extension OuterType { struct InnerType { ... } }`
        *   *Incorrect:* `struct OuterType { struct InnerType { ... } }`
*   **Project Organization:**
    *   **Empty Folders:** We do not keep empty folders in the project. Any empty directory (excluding `.git`, `.build`, `.swiftpm`, `.vscode`, and explicitly required tool directories) must be removed.
    *   **Prefix-Based Grouping:** If more than 3 files share the same prefix (e.g., `VLK`, `SDL`), they must be grouped into a dedicated subfolder named after that prefix (or its mapped name, like `Vulkan` for `VLK`).
*   **Naming Conventions:**
    *   **Vulkan:** All Vulkan-related types and protocols must be prefixed with `VLK` (e.g., `VLKInstance`).
    *   **SDL:** All SDL-related types and protocols must be prefixed with `SDL` (e.g., `SDLWindow`).
*   **Math Development:**
    *   **Consolidation:** ALWAYS prefer using types and functions from the `FirebladeMath` package. Avoid reimplementing common math logic in the main `Fireblade` module.
    *   **Generic Extensions:** If a new math function is needed and it is generic enough to be useful outside the core engine (e.g., generic vector/matrix operations), it MUST be implemented as an extension within the `FirebladeMath` package itself, not in the `Fireblade` engine code. Prefer generic implementations in `Matrix` extensions where possible, falling back to explicit `Float`/`Double` variants only when necessary for API compatibility or optimization.
    *   **Precision and Compatibility:** Math types must adhere to strict memory layout standards to ensure compatibility with C/C++ (Vulkan/Metal). Verify layout with tests when introducing new core types.
    *   **Quality Standard:** The `FirebladeMath` library must maintain a code coverage of >90%. New features must include comprehensive unit tests using the `Testing` module.
    *   **Tooling:** Development in `FirebladeMath` should follow the standardized tooling (Mint, SwiftFormat, and Make) defined in its local environment to ensure consistency with the main project.
*   **Coordinate System:**
    *   **World Space:** Right-Handed, +Y Up, +Z Forward (coming out of the screen), +X Right.
    *   **Winding Order:** Counter-Clockwise (CCW) defines the front face in World Space.
    *   **Normalized Device Coordinates (NDC):** Vulkan standard (Y-down, Z 0-1). The projection matrix MUST handle the flip from World Space (+Y Up) to Clip Space (Y-down) transparently.
        *   **Architectural Note:** The projection matrix performs a Y-flip (`y_clip = -y_world`) to map World Up (+Y) to NDC Up (-Y). This reflection, combined with the Y-down NDC coordinate system, effectively preserves the visual winding order. Therefore, the RHI pipeline uses `frontFace = VK_FRONT_FACE_COUNTER_CLOCKWISE` (standard) to correctly render CCW world-space geometry. Backface culling remains `VK_CULL_MODE_BACK_BIT`.
*   **Stability:** All existing examples (e.g., `HelloWindow`, `HelloTriangle`) MUST continue to compile and run correctly after any changes.
*   **Error Handling (No fatalError):** 
    *   **Strict Ban:** The use of `fatalError`, `preconditionFailure`, `assert`, `assertionFailure` or any other crashing mechanism is **strictly prohibited**!
    *   **No Force/Optional Try:** The use of `try!` and `try?` is **strictly prohibited**. Use `do-catch` blocks with `try` to handle errors explicitly.
    *   **Graceful Recovery:** All failures (initialization, resource loading, logic errors) MUST be handled gracefully using Swift's `throw`, `Result`, or by returning optional `nil`.
        *   **Logging:** Every error MUST be logged at its point of origin using `swift-log` with an appropriate level (e.g., `.error`, `.critical`).
        *   **Vulkan Debug Logging:** Vulkan-specific validation messages and debug events must be captured via a dedicated `VLKDebugMessenger` and logged using the `com.fireblade.vulkan.debug` logger label.
        *   **Resilience:** The application main loop MUST be resilient to sub-system failures.
     A rendering error should not crash the app but should be logged, and the system should attempt to recover or degrade gracefully.

## Architectural Principles: "The Fireblade Way"
*   **Modularity:** All systems should be loosely coupled. The engine core should not depend on specific game logic.
*   **Data-Oriented (DOD):** Prefer data-oriented design over object-oriented design for high-volume systems.
    *   **ECS:** Use a centralized `Nexus` for entity and component management. Components must be simple, data-holding types (structs preferred).
*   **Resource Management:** Use a centralized `AssetManager` with `AssetRef` handles. Implement lazy loading and reference counting via unique `AssetID` (UUID) to ensure efficient memory usage and asset reuse.
*   **Event Handling:** Utilize a unified `PlatformEvent` system with a variant-based approach for cross-platform input and window events. Decouple input from logic via an abstraction layer (PAL).
*   **Game Loop:** Adhere to a "fixed update, variable render" loop. Use an accumulator to ensure consistent logic/physics updates regardless of frame rate, and provide interpolation values for smooth rendering.
*   **Cross-Platform:** All core systems must be designed with cross-platform abstraction in mind from day one (via SDL3).

## Rendering Architecture: Fireblade RHI
*   **Decoupled Design:** Use a modular Render Hardware Interface (RHI) to separate high-level rendering logic from low-level graphics APIs.
*   **Explicit Control:** The RHI must provide explicit control over command recording, queue submission, and resource state transitions, mirroring modern APIs like Vulkan and Metal.
*   **Core RHI Components:**
    *   **Backend:** Global entry point for API-specific initialization.
    *   **Device:** Virtual representation of the GPU.
    *   **CommandQueue & CommandBuffer:** Primary mechanisms for submitting GPU work.
    *   **Swapchain:** Manages the presentation of rendered images to the window surface.
*   **Vulkan-First Priority:** While backend-agnostic, the RHI design is primarily informed by Vulkan's requirements to ensure optimal performance on the primary backend.
    *   **Backend Abstraction:** User code must interact with high-level Fireblade abstractions (e.g., `Engine`, `RHI` interfaces) and never directly instantiate specific backends (e.g., `VulkanSDLBackend`) or import platform-specific modules.
    *   **Concurrency:** Explicit Render Thread model. Main thread records commands; Render thread owns RHI/GPU submission. Synchronization via double-buffered ring buffers.
*   **Resource Loading Strategy:** Hybrid Model.
    *   **Primary (Scene-Driven):** Resources are prioritized and pre-loaded based on Scene/Zone residency to ensure smooth streaming.
    *   **Fallback (Demand-Based):** If a resource is requested but not loaded, trigger an asynchronous load and render a placeholder (e.g., checkerboard texture) to prevent pipeline stalls.
*   **Renderer Architecture (Forward+):**
    *   **Pipeline Sequence:** Z-Prepass (Depth) -> Light Culling (Compute) -> Geometry (Forward) -> Transparent -> Post-Process -> UI.
    *   **Concurrency:** Explicit Render Thread model. Main thread records commands; Render thread owns RHI/GPU submission. Synchronization via double-buffered ring buffers.
    *   **Shader System:** Abstracted assets with async compilation and live-reloading (hot-swap). Reflection used for automated pipeline layout generation.

## Main Runloop Execution Strategy: Engine-Driven Hybrid
*   **Primary Driver (Desktop):** Use an engine-owned `while` loop on the main thread. This provides maximum control and familiar linear flow for desktop development.
*   **Engine Lifecycle:** Use a centralized `Engine` singleton (isolated to `@MainActor`) to manage the core state and backend lifecycle.
*   **Invertible Architecture:** Decouple the "Frame Step" logic (Event Processing, Fixed Update, Variable Update, Render) into a standalone protocol or interface. This allows the engine to be driven by external callbacks (e.g., SDL3's `SDL_AppIterate`) on platforms like iOS or Web (Emscripten) where control inversion is required.
*   **Swift 6 Concurrency Integration:**
    *   **MainActor Isolation:** The main runloop and all SDL/Windowing calls must be isolated to the `@MainActor`.
    *   **Non-Blocking Logic:** Offload performance-heavy or asynchronous tasks (e.g., resource loading, networking) to Swift Actors or background Tasks to keep the main runloop responsive.
    *   **Synchronization:** Use modern Swift concurrency primitives to synchronize between the main thread and background worker threads.

## Dependency Management & Portability
*   **Self-Contained Portability:** The project must be "plug and play." A developer should be able to clone the repository and build the engine with minimal system-level installations.
*   **Vendor Strategy:**
    *   **Swift Package Manager (SPM):** SPM is the primary tool for all dependency and project management.
    *   Vulkan & SDL3: These are critical, platform-heavy dependencies. They must be vendored locally in the `Dependencies/` directory as local Swift Packages. This ensures that the engine always compiles against a known-good version of these libraries and their headers.
    *   **Remote Dependencies:** Standard Swift-only libraries or well-maintained Swift wrappers (e.g., ImGui, Logging) may remain as remote SPM dependencies to simplify updates.
*   **Advanced SPM Features:**
    *   **SE-0342:** Consider "Statically link runtime libraries by default" for self-contained deployments.
    *   **SE-0482:** Leverage "Binary targets for non-Apple platforms" for pre-compiled dependencies on Linux/Windows.
*   **One-Step Setup:** All environment bootstrapping (downloading binaries, setting up paths) must be automated via a single, cross-platform command (primary: `swift run setup`).

## Agent Interaction Standards
*   **Protocol Over Speed:** The agent must prioritize correctness and protocol adherence above all else. Speed that leads to mistakes is a failure.
*   **Zero Assumption Policy:** The agent must **NEVER** assume the state of the repository, file system, or build. Every action that modifies state must be preceded by a verification step (e.g., `ls`, `git status`, `read_file`).
*   **User is Final Authority:** The agent's perception of "done" is irrelevant; only the user's satisfaction defines completion.
*   **Strict Verification:** The agent must never mark a task or track as complete without explicit user confirmation, especially for visual or runtime behaviors.
*   **Iterative Refinement:** If the user rejects a result, the agent must immediately pivot to correction mode and loop until the user is satisfied. The agent should never argue or assume correctness in the face of user feedback.



