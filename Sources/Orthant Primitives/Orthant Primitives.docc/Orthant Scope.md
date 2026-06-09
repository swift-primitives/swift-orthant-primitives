# Orthant Scope

The identity surface of `swift-orthant-primitives` and what it deliberately excludes.

## Identity

`swift-orthant-primitives` provides **the orthant** — `Orthant<N>`, a `Direction` assigned
to every one of the `N` axes (`2ᴺ` inhabitants); the N-dimensional generalization of the
quadrant and octant. It is the composition `Directionᴺ`, stored as an
`InlineArray<N, Direction>`.

## Core targets

- `Orthant Primitive` — the `Orthant<N>` value type, construction, `.opposite`, and
  conditional `Codable`. Depends only on the `Direction Primitive` atom root (the [MOD-017]
  cross-namespace-root case). Axis-free by design — indexed by axis ordinal `0..<N`.
- `Orthant Equation / Hash / Comparison Primitives` — the institute Equatable/Hashable/
  Comparable twins.
- `Orthant Enumerable Primitives` — the `Finite.Enumerable` conformance (`2ᴺ` inhabitants,
  bit-encoded ordinal). Depends on finite + ordinal.

## Out of scope

- The atoms themselves (`Direction`, `Axis<N>`): their own packages.
- The single-axis-sign sibling `Facet<N> = Axis<N> × Direction`: `swift-facet-primitives`.
- The general k-face `Orthotope.Face<N, K>` (of which `Facet` and `Orthant` are the two
  extremes): deferred.
- Per-`Axis<N>` typed subscripting (`orthant[.primary]`): a future axis ⊗ orthant bridge,
  to keep this package's dependency on `Direction` alone.
- Named region views (`Sector.Quadrant`, `Sector.Octant`) and their `.orthant` lossless
  projections: the named-view packages plus carrier-projection bridge packages.

## Evaluation rule

Sub-target additions are evaluated against this scope. If a proposed addition is OUT of
scope, it extracts to a sibling package, not into this one.
