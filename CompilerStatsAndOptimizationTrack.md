# FirebladeMath Compiler Profiling & Optimization Track

## 1. Overview & Objectives

This track guides the next engineer/agent through profiling `FirebladeMath` compiler statistics and applying targeted Swift compiler optimizations to eliminate severe type-checker constraint solver bottlenecks.

Empirical profiling data shows that `FirebladeMath` takes **279.6s total wall-clock time** across compiler worker passes—executing **179.2 Billion CPU instructions** for just 30,376 lines of Swift code (5.9 Million instructions per source line).

---

## 2. Step-by-Step Instructions to Generate Profile Analysis

1. **Clean Environment & Generate Diagnostics:**
   Run `swift build` with the compiler statistics flag:
   ```bash
   rm -rf _diagnostics/stats .build
   mkdir -p _diagnostics/stats
   swift build --disable-sandbox -Xswiftc -stats-output-dir -Xswiftc _diagnostics/stats
   ```
2. **Analyze Output JSON Files:**
   Parse all `_diagnostics/stats/stats-*.json` files to extract:
   - `Frontend.NumInstructionsExecuted` (CPU instructions)
   - `AST.NumSourceLines` (Source line count)
   - `time.swift.perform-whole-module-type-checking.wall` (Sema / Type checking time)
   - `time.swift.SILGen.wall` (SIL Generation time)

---

## 3. Hotspot Analysis & Optimization Hints

### 3.1 Hotspot 1: `Sources/FirebladeMath/Constants.swift`
- **Measured Metric:** **23.975s Wall Time** | 10.6 Billion Instructions | 448 Lines
- **Root Cause:** Un-annotated numeric literals in generic matrix and SIMD constants force the Swift type checker (`Sema`) to explore exponential constraint search trees.
- **Optimization Hints:**
  - Explicitly type-annotate all SIMD/matrix literals.
  - Example: Replace `public static let identity = Matrix4x4([1, 0, 0, 0, ...])` with `public static let identity = Matrix4x4<Float>(SIMD4<Float>(1.0, 0.0, 0.0, 0.0), ...)` or concrete type initializers.
  - Avoid literal array type inference inside generic initializer calls.

### 3.2 Hotspot 2: `Sources/FirebladeMath/Quat/Quat.swift`
- **Measured Metric:** **19.892s Wall Time** | 8.1 Billion Instructions | 1,129 Lines
- **Root Cause:** Generic operator overload resolution (`*`, `+`, `-`) across quaternions, vectors, and matrices.
- **Optimization Hints:**
  - Break complex chained arithmetic expressions into separate local variables with explicit types.
  - Provide concrete `Float` and `Double` specialized helper methods or inline implementations alongside generic signatures.

### 3.3 Hotspot 3: `Sources/FirebladeMath/Matrix/Matrix+Operators.swift`
- **Measured Metric:** **17.453s Wall Time** | 9.3 Billion Instructions | 1,848 Lines
- **Root Cause:** Overloaded matrix multiplication operators with unconstrained generic parameters.
- **Optimization Hints:**
  - Explicitly annotate return types on all operator overload functions.
  - Disambiguate matrix-vector vs matrix-matrix operator definitions.

### 3.4 Hotspot 4: `Sources/FirebladeMath/Functions/tan.swift`
- **Measured Metric:** **16.212s Wall Time** | 8.4 Billion Instructions | 1,358 Lines
- **Root Cause:** Elementwise SIMD trigonometry functions (`tan`, `atan`, `atan2`) with generic type parameters.
- **Optimization Hints:**
  - Add explicit parameter and return type signatures to SIMD mapping functions.
  - Use `SIMD.Scalar` explicit constraints instead of broad protocol conformances.

---

## 4. Verification & Acceptance Criteria

1. **Functionality Verification:**
   Run all tests to ensure math correctness is unaffected:
   ```bash
   swift test
   ```
2. **Performance Verification:**
   Re-run compiler diagnostics profiling (`swift build -Xswiftc -stats-output-dir -Xswiftc _diagnostics/stats`).
   - **Success Target:** `FirebladeMath` total wall-clock compilation time drops from **279.6s** to **<30s**.
