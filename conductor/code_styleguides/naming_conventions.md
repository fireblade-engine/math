# Naming Conventions & File Structure

## 1. File Structure

### One File Per Type
*   **Rule:** Every `struct`, `class`, `enum`, or `protocol` definition that exceeds **5 lines of code** must reside in its own dedicated file.
*   **Filename:** The file must be named exactly after the type it contains, including case sensitivity.
    *   *Example:* `struct VLKDevice` -> `VLKDevice.swift`
*   **Exceptions:**
    *   **Private/Internal Helpers:** Helper types that are `private` or `internal` and are tightly coupled to a main type may remain in the same file as the main type, provided they are not used elsewhere.
    *   **Small Extensions:** `extension` blocks that are small (e.g., protocol conformance) may remain in the same file as the definition or usage context.

## 2. Naming Conventions

### Vulkan Types
*   **Prefix:** `VLK`
*   **Scope:** All types, protocols, and enums that interface with, wrap, or represent Vulkan entities.
*   **Examples:**
    *   `VulkanInstance` -> `VLKInstance`
    *   `VulkanDevice` -> `VLKDevice`
    *   `VulkanBuffer` -> `VLKBuffer`

### SDL Types
*   **Prefix:** `SDL`
*   **Scope:** All types, protocols, and enums that interface with, wrap, or represent SDL entities.
*   **Examples:**
    *   `Window` (SDL wrapper) -> `SDLWindow`
    *   `Surface` (SDL wrapper) -> `SDLSurface`
    *   `Event` (SDL wrapper) -> `SDLEvent`

### General
*   **Clarity:** Names should be descriptive and unambiguous.
*   ** consistency:** Follow Swift API Design Guidelines for general naming (camelCase for properties/methods, PascalCase for types).
