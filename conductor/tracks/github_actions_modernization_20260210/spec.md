# Specification - GitHub Actions Modernization (github_actions_modernization_20260210)

## Overview
This track aims to modernize, fix, and optimize the GitHub Actions workflows for the `FirebladeMath` repository. It also establishes a baseline for the agent to autonomously assess CI status using the GitHub CLI (`gh`).

## Goals
- **Modernize:** Update all GitHub Action versions to their latest stable releases (e.g., `actions/checkout@v4`).
- **Fix:** Identify and resolve current CI failures across Linux, macOS, and Windows.
- **Optimize:** Refactor workflows for better performance and maintainability, specifically moving towards Matrix builds and improved caching strategies within each platform's workflow.
- **Stability:** Ensure stable, predictable workflow and job names for GitHub's "Status checks that are required" protection rules.
- **Enable Autonomy:** Ensure the environment is set up for the agent to use `gh` to inspect workflow runs and logs.

## Functional Requirements
1.  **Environment Readiness:**
    - Verify `gh` CLI installation and authentication.
    - Confirm the agent has sufficient permissions to read workflow runs.
2.  **Workflow Update:**
    - Update `ci-linux.yml`, `ci-macos.yml`, and `ci-windows.yml` to use latest actions.
    - Update `markdown-link-check.yml`.
    - **Apple Platform Support:** Ensure `ci-macos.yml` properly tests both **macOS** and **iOS** targets (via destination specifiers).
    - **Platform Coverage:** Verify that Linux, Windows, macOS, and iOS are actively tested. (Android is deprioritized).
3.  **Refactoring:**
    - **Strict Separation:** Maintain one CI workflow file per platform (`ci-linux.yml`, `ci-macos.yml`, `ci-windows.yml`).
    - **Optimization:** Optimize these individual files using Matrix builds (e.g., for Swift versions) and improved caching strategies.
    - **Reusable Job Names:** Ensure that job names (e.g., `test-macos`) are consistent and do not change dynamically based on implementation details (e.g., avoid `macos-13-swift-5.9` unless strictly necessary for separation). This allows "Status checks that are required" to remain valid.
4.  **CI Failure Resolution:**
    - Analyze recent failures using `gh run view`.
    - Apply fixes to code or configuration to achieve a "Green" CI state.

## Non-Functional Requirements
- **Maintainability:** Workflows should be easy to read and follow GitHub's best practices.
- **Performance:** Significant reduction in CI turnaround time through better caching and parallelization.

## Acceptance Criteria
- [ ] `gh auth status` returns success in the agent's environment.
- [ ] All workflows are updated to the latest major versions of official actions.
- [ ] All workflows (`linux`, `macos` (including iOS), `windows`, `markdown`) pass successfully on the track branch.
- [ ] The build time for a "no-change" run is reduced due to effective caching.
- [ ] Required status checks in GitHub settings do not need updating after this modernization.

## Out of Scope
- Adding new deployment pipelines (CD).
- Rewriting the `Makefile` or `Package.swift` unless strictly required to fix CI.
- **Android CI:** Explicitly not prioritized for this modernization effort.
