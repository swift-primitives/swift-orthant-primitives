// Orthant+Hash.Protocol.swift
// Conformance of Orthant to Hash.Protocol — unconditional.
//
// The `hash(into:)` and `==` witnesses live in the root (Orthant.swift). `Orthant` is a
// struct (not auto-Hashable), so the stdlib `Hashable` conformance is declared here, guarded
// `#if swift(<6.4)`.

public import Hash_Primitives
public import Orthant_Primitive

extension Orthant: Hash.`Protocol` {}

#if swift(<6.4)
    extension Orthant: Hashable {}
#endif
