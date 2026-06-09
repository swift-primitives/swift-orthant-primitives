// Orthant+Comparison.Protocol.swift
// Conformance of Orthant to Comparison.Protocol — unconditional.
//
// The `<` / `<=` / `>` / `>=` witnesses live in the root (Orthant.swift). On Swift 6.4+,
// `Comparison.Protocol` is a typealias to `Swift.Comparable` per SE-0499. The stdlib
// `extension Orthant: Comparable {}` below is guarded `#if swift(<6.4)`.

public import Comparison_Primitives
public import Orthant_Primitive

extension Orthant: Comparison.`Protocol` {}

#if swift(<6.4)
    extension Orthant: Comparable {}
#endif
