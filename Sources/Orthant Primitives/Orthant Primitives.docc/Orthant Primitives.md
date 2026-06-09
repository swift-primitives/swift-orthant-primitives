# ``Orthant_Primitives``

@Metadata {
    @DisplayName("Orthant Primitives")
    @TitleHeading("Swift Institute — Primitives Layer")
}

The orthant — `Orthant<N>`, a `Direction` on every axis (2ᴺ inhabitants).

## Overview

`Orthant Primitives` ships ``Orthant_Primitive/Orthant``, the all-axes sign composite `Directionᴺ`. An orthant assigns a `Direction` to each of the `N` axes — the N-dimensional generalization of a quadrant (2D) and octant (3D). It has `2ᴺ` inhabitants and is the codimension-N extreme of the general k-face: a ``Facet`` fixes a sign on *one* axis, an `Orthant` on *every* axis.

The per-axis directions live in an `InlineArray<N, Direction>` indexed by axis ordinal `0..<N`. `Orthant<N>` conforms to `Finite.Enumerable` (in the `Orthant Enumerable Primitives` sub-target), bit-encoding each orthant into an ordinal in `0..<2ᴺ`. The root `Orthant Primitive` depends only on the `Direction Primitive` atom root.

## Topics

### Essentials

- <doc:Orthant-Scope>

### Core Type

- ``Orthant_Primitive/Orthant``
