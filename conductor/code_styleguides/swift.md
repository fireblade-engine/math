# Swift Style Guide: Fireblade 2026

This style guide is synthesized from the most recent legacy Fireblade repositories.

## 1. Formatting (swiftformat)

### General Options
- **Line Length:** Maximum 220 characters.
- **Semicolons:** Never use semicolons.
- **Indentation:** Use 4 spaces for indentation.
- **Commas:** Use inline commas.

### Rules
- **Self Removal:** Explicit `self` is removed where not required by the compiler (except in closures where needed).
- **Extension ACL:** Use `on-declarations` for extension access control level.
- **Header:** Strip file headers.
- **Opaque Generic Parameters:** Disabled (for now).
- **KeyPath Preference:** Disabled.

## 2. Linting (swiftlint)

### Core Rules
- **identifier_name:** Exclude `id` from the name length/format checks.
- **line_length:** 220 characters.
- **number_separator:** Minimum length of 5.

### Opt-in & Analyzer Rules
- **explicit_self:** Required to detect missing self when intended (balanced with swiftformat's self removal).
- **unused_declaration:** Enabled.
- **unused_import:** Enabled.
- **number_separator:** Enabled for long numeric literals.

## 3. Architecture Specifics
- **Data-Oriented:** Prioritize `struct` over `class` where possible.
- **ECS Integration:** Components should be simple POD (Plain Old Data) structs.

## 4. Type Structure & Nesting
*   **Inner Types:** Nested types (classes, structs, enums) MUST be declared in a dedicated `extension`. Do NOT declare inner types inside the main type body.
    *   **Bad:** `struct A { struct Inner { ... } }`
    *   **Good:** `struct A { ... } extension A { struct Inner { ... } }`

## 5. Error Handling
*   **Definition:** All error enums/structs MUST be defined as an extension of their associated type.
*   **Naming:** The error type itself MUST be named `Error`.
    *   **Example:** `extension MyType { public enum Error: Swift.Error { case invalidInput } }`
*   **Prohibition:** usage of `try?` is STRICTLY PROHIBITED. Always use `do-catch` blocks or explicit `try` calls that propagate errors.

## 6. Logging
*   **Primary API:** Use `swift-log` via `Logging.logger` for all logging within the `Sources/` directory.
*   **Prohibited:** Direct use of `print()` in production source code is STRICTLY PROHIBITED.
*   **Log Levels:** Map messages to appropriate log levels:
    *   `error`: Critical failures preventing operation.
    *   `warning`: Recoverable issues.
## 7. Math Implementation
*   **Frozen & Sendable:** Core math types (vectors, matrices, quaternions) MUST be marked as `@frozen` and conform to `Sendable`.
*   **Centralization:** Generic math functionality (e.g., projection matrix math, vector transformations) MUST be implemented in the `FirebladeMath` package. 
*   **Extension Policy:** Do not add math extensions to `Fireblade` engine types if they are generic. Extend the underlying `FirebladeMath` types instead.
*   **C-Compatibility:** Verify memory layout of math types via tests to ensure they are compatible with GPU buffer expectations (e.g., SIMD alignment).