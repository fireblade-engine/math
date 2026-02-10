# Product Definition: Fireblade Game Engine

## Vision
To build a modern, modular, and high-performance 3D/2D game engine using Swift as the primary language. Fireblade aims to provide a robust foundation for game development, ranging from low-level engine architecture to high-level tooling, accessible to indie developers, AAA studios, and hobbyists alike.

## Target Audience
1.  **Indie Game Developers:** seeking a modern, performant, and accessible engine.
2.  **AAA Game Studios:** requiring a modular and scalable architecture for complex projects.
3.  **Hobbyists & Students:** interested in learning modern game engine architecture and Swift for game development.
4.  **Modders:** creating content and extensions for Fireblade-based games through its plugin system.

## Core Components
### 1. Fireblade (Core Engine)
The heart of the ecosystem, housing all essential systems:
*   **Platform Abstraction Layer (PAL):** Built on SDL3 for cross-platform hardware access.
*   **Rendering:** Primary Vulkan backend supporting high-fidelity 3D and 2D graphics.
*   **Text Rendering:** High-performance, resolution-independent MSDF (Multi-channel Signed Distance Field) text system for 3D world labels and 2D HUDs.
*   **ECS (Entity-Component-System):** A data-oriented architecture for performance and modularity.
*   **Input Systems:** Built-in support for Action-Based Input mapping and standard first-person controls.
*   **Audio & Physics:** Integrated low-level systems.
*   **Plugin System:** Games and extensions are dynamically linked libraries (plugins) and asset packs.

### 2. Fireforge (Editor)
A full-featured 3D editor for creating Fireblade games, comparable to Unity or Unreal Editor.
*   **Supported Platforms:** macOS, Linux, Windows.
*   **GUI:** Built with ImGui for a responsive and customizable workflow.

### 3. Firestorm (Runtime)
The standalone executable responsible for running Fireblade games efficiently.
*   **Purpose:** Pure execution environment for end-users.
*   **Supported Platforms:** macOS, Linux, Windows, iOS, Android (Web planned).

## Directory Structure
The engine's source code is organized into a clean, modular hierarchy under `Sources/Fireblade/`:

*   **Core:** The engine's heart, containing the primary `Engine` logic, configuration, and fundamental logging facilities.
*   **ECS:** Data-oriented Entity-Component-System architecture.
*   **Font:** MSDF font parsing and generation logic.
*   **GFX:** High-level graphics and rendering systems.
    *   **Render:** High-level renderers (Scene, HUD, Text).
    *   **RHI:** Rendering Hardware Interface (Vulkan backend).
    *   **Geometry:** Vertex definitions and procedural mesh generation.
*   **Math:** Linear algebra and geometric primitives.
*   **PAL:** Platform Abstraction Layer (SDL3/GLFW) for windowing, input, and hardware events.
*   **Resources:** Asset loading and management (Fonts, Shaders).
*   **Scene:** Scene graph, camera systems, and spatial organization.
*   **Utils:** General-purpose helpers and utilities (FPS Counter, Debugging tools).

## Key Technologies
*   **Primary Language:** Swift 6.2+
*   **Toolchain:** Xcode 26.2+ (Official Swift Toolchain)
*   **Fallback Languages:** C, C++ (only where strictly necessary)
*   **Platform Layer:** SDL3
*   **Graphics API:** Vulkan (Primary)
*   **GUI (Editor/HUD):** ImGui

## Initial Concept
The project is called "Fireblade Game Engine". This is a pretty massive project to write an entire 3D (and 2D) game engine in a modern, modular way. There are three main components: 1. "Fireblade", the core game engine, housing everything that makes the engine work from, platform abstraction layer (PAL), 3D and 2D rendering (pimary Vulkan render backend), Entity-Component-System (ECS), Audio and every other building block for making a game, except the actual Game implementation. Games will be implemented as plugins (e.g. dynamically linked libraries) and asset packs. 2. "Fireforge" is the 3D editor (GUI) to create Fireblade games. It is a full flegded game editor similar to Unreal or Unity. 3. "Firestorm" is the runtime application executing Fireblade games. Its sole purpose is to run the game efficiently and on every platform. We support multiple platforms for Fireblade and Firestorm: macOS, Linux, Windows, iOS and Android - in the future maybe even the Web. For Fireforge we support macOS, Linux and Windows. The main programming language for the entire project is Swift (6.2+), but we fall back to C and C++ where not avoidable. For Platform abstraction we use SDL3. For editor GUI and in-game HUD we use ImGui. This is the basis for the project, but I want to specify a lot in detail one after the other.