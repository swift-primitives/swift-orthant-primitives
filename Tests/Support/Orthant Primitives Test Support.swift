// Orthant Primitives Test Support.swift
// Test Support spine per [MOD-024]: re-exports the lowest in-scope upstream Test Support
// (Ordinal, which chains to Cardinal) so Cardinal/Ordinal ExpressibleByIntegerLiteral
// conformances are visible in test files comparing `count`/`ordinal` to integer literals.

@_exported public import Ordinal_Primitives_Test_Support
internal import Orthant_Primitives
