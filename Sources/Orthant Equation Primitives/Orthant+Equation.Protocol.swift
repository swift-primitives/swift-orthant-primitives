// Orthant+Equation.Protocol.swift
// Conformance of Orthant to Equation.Protocol — unconditional.
//
// The `==` witness (element-wise) lives in the root (Orthant.swift). On Swift 6.4+,
// `Equation.Protocol` is a typealias to `Swift.Equatable` per SE-0499; the stdlib
// `extension Orthant: Hashable {}` in `Orthant Hash Primitives` (which implies `Equatable`)
// is guarded `#if swift(<6.4)` to avoid duplicate-conformance.

public import Equation_Primitives
public import Orthant_Primitive

extension Orthant: Equation.`Protocol` {}
