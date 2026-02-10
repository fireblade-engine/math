# Specification: Fix GitHub Actions CI

## Overview
This track aims to fix and modernize the GitHub Actions CI pipelines for the Fireblade Math project, focusing exclusively on macOS for now.

## Functional Requirements
1.  **Split iOS CI:** Extract the iOS testing job from `ci-macos.yml` (previously "Apple") into a dedicated `ci-ios.yml` workflow, but set it to `workflow_dispatch` only (deactivated).
2.  **Deactivate Non-macOS CI:** Update `ci-linux.yml`, `ci-windows.yml`, and the new `ci-ios.yml` to trigger ONLY on `workflow_dispatch`, effectively deactivating them from automatic runs without removing the files.
3.  **Fix macOS CI (`ci-macos.yml`):**
    *   Target Swift versions 6.1 and 6.2.
    *   Use `swift-actions/setup-swift@v2` for environment setup.
    *   Execute tests using `make test`, ensuring Swift compiler warnings are treated as errors (as configured in the Makefile).
    *   **Triggers:**
        *   `push` to `master`, `main`, and `track/*` branches.
        *   `pull_request` targeting `master` or `main`.
        *   Manual trigger via `workflow_dispatch`.
    *   **Caching:** Implement caching for Swift Package Manager external dependencies to optimize build times.

## Non-Functional Requirements
-   **CI Speed:** Use caching effectively to keep CI runs under 5 minutes where possible.
-   **Reliability:** Ensure CI failures are actionable and clearly reported.

## Acceptance Criteria
-   `ci-macos.yml` runs successfully for Swift 6.1 and 6.2 on macOS.
-   `ci-ios.yml`, `ci-linux.yml`, and `ci-windows.yml` do not run automatically on push or PR.
-   Warnings in Swift code cause CI failure on macOS.
-   All CI workflows are correctly configured with `workflow_dispatch` triggers.
