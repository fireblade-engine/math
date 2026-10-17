#if canImport(Darwin)
@_exported import Darwin
#elseif canImport(Glibc)
@_exported import Glibc
#elseif canImport(Musl)
@_exported import Musl
#elseif canImport(Android)
@_exported import Android
#elseif canImport(Bionic)
@_exported import Bionic
#elseif canImport(WASILibc)
@_exported import WASILibc
#elseif canImport(ucrt)
@_exported import ucrt
#else
#error("FirebladeMath: unsupported platform, no C math library found.")
#endif

// Resolves the platform C library that provides <math.h> exactly once.
//
// This module is an implementation detail of FirebladeMath and is not a product.
// FirebladeMath calls libc functions module-qualified, e.g. `FirebladeMathLibC.cosf(x)`.
// Qualified lookup into this module finds the re-exported declarations above,
// so the module name works as a platform-independent alias for Darwin, Glibc, etc.
//
// The qualification is required: inside FirebladeMath an unqualified `cos(x)` binds to
// FirebladeMath's own public `cos` overlay, not to the C function.
