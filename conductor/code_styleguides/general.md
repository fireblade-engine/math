# General Code Style Principles

This document outlines general coding principles that apply across all languages and frameworks used in this project.

## Readability
- Code should be easy to read and understand by humans.
- Avoid overly clever or obscure constructs.

## Consistency
- Follow existing patterns in the codebase.
- Maintain consistent formatting, naming, and structure.

## Simplicity
- Prefer simple solutions over complex ones.
- Break down complex problems into smaller, manageable parts.

## Maintainability
- Write code that is easy to modify and extend.
- Minimize dependencies and coupling.

## Documentation
- Document *why* something is done, not just *what*.
- Keep documentation up-to-date with some changes.

## Math Logic and Dependencies
- Centralize all generic mathematical logic in the `FirebladeMath` dependency.
- Avoid local reimplementations of vector, matrix, or quaternion math within the main engine.
- Extend the math package for generic functionality instead of adding extensions to the engine codebase.
