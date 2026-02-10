# Implementation Plan: Fix GitHub Actions CI

## Phase 1: Preparation & Deactivation [checkpoint: e889d55]
Configure the CI landscape by isolating macOS CI and deactivating other automated workflows.

- [x] Task: Create `ci-ios.yml` from `ci-macos.yml`
    - [x] Extract iOS job from `ci-macos.yml`.
    - [x] Create `.github/workflows/ci-ios.yml`.
    - [x] Set `on:` to `workflow_dispatch:` only for `ci-ios.yml`.
- [x] Task: Deactivate automated runs for Linux and Windows CI
    - [x] Modify `.github/workflows/ci-linux.yml` to use `workflow_dispatch:` only.
    - [x] Modify `.github/workflows/ci-windows.yml` to use `workflow_dispatch:` only.
- [x] Task: Conductor - User Manual Verification 'Phase 1: Preparation & Deactivation' (Protocol in workflow.md)

## Phase 2: Fix macOS CI Implementation
Modernize and stabilize the macOS CI pipeline to support Swift 6.1 and 6.2 with strict warning policies.

- [x] Task: Modernize `ci-macos.yml` setup
    - [x] Remove iOS job/matrix entries from `ci-macos.yml`.
    - [x] Update to `swift-actions/setup-swift@v2`.
    - [x] Ensure matrix targets Swift `6.1` and `6.2`.
- [x] Task: Implement optimized caching for SPM
    - [x] Configure `actions/cache@v4` (or latest) for `.build` directory.
    - [x] Ensure cache key includes `Package.resolved` hash and Swift version.
- [x] Task: Configure test execution with strict warnings
    - [x] Use `make test` for execution.
    - [x] Verify `Makefile` correctly passes `-Xswiftc -warnings-as-errors`.
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Fix macOS CI Implementation' (Protocol in workflow.md)

## Phase 3: Verification & Finalization
Ensure the CI system behaves as expected and satisfies all specification requirements.

- [ ] Task: Verify CI deactivation
    - [ ] Ensure Linux, Windows, and iOS workflows only have `workflow_dispatch`.
- [ ] Task: Final project-wide check
    - [ ] Run `make lint` locally to ensure no formatting/linting issues remain.
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Verification & Finalization' (Protocol in workflow.md)
