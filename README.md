# Orthant Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

An N-dimensional orthant for Swift — a per-axis `Direction` vector naming the `2ᴺ` quadrants, octants, and higher-dimensional sign regions of N-space.

---

## Quick Start

`Orthant<N>` assigns a `Direction` to every one of the `N` axes. It is the N-dimensional generalization of a quadrant (2D, 4 inhabitants) and an octant (3D, 8 inhabitants): where a single `Facet` fixes a sign on exactly one axis, an orthant fixes a sign on *every* axis, giving `2ᴺ` inhabitants. The per-axis choices are stored in an `InlineArray<N, Direction>` indexed by axis ordinal `0..<N`.

```swift
import Orthant_Primitives

// A quadrant of the 2D plane is a sign choice on each of the two axes.
let quadrant = Orthant<2> { axis in axis == 0 ? .positive : .negative }   // (+x, −y)
quadrant.directions[0]   // .positive
quadrant.opposite        // (−x, +y) — every axis flipped

// The 2ᴺ inhabitants enumerate in a stable order; each carries an ordinal in 0..<2ᴺ.
Orthant<3>.count                  // 8 — the eight octants of 3-space
for octant in Orthant<3>.allCases {
    print(octant.ordinal)         // 0, 1, 2, … 7
}
```

The `ordinal` packs the sign choices into a bit pattern — axis `i` contributes bit `i`, set when its direction is negative — and round-trips back through `Orthant<N>(_unchecked:ordinal:)`:

```swift
import Orthant_Primitives

let octant = Orthant<3>(repeating: .negative)
octant.ordinal                                        // 7 — 0b111, all axes negative
Orthant<3>(_unchecked: (), ordinal: octant.ordinal)   // == octant

// Orthants order lexicographically, axis 0 most significant.
let mm = Orthant<2>(repeating: .negative)                 // (−, −)
let pm = Orthant<2> { $0 == 0 ? .positive : .negative }   // (+, −)
mm < pm                                                   // true
```

Equality, hashing, and ordering are provided through the institute conformance twins `Equation.Protocol` / `Hash.Protocol` / `Comparison.Protocol`, comparing the directions lexicographically.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-orthant-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Orthant Primitives", package: "swift-orthant-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

The `Orthant` root namespace depends only on the `Direction` atom; the conformance twins each add one institute protocol. Import the `Orthant Primitives` umbrella for the full surface, or a single sub-target for a narrower dependency.

| Product | Target | Purpose |
|---------|--------|---------|
| `Orthant Primitive` | `Sources/Orthant Primitive/` | The `Orthant<N>` value type: per-axis `Direction` storage, `opposite`, the `==` / `<` / `hash(into:)` witnesses, and `Codable`. |
| `Orthant Equation Primitives` | `Sources/Orthant Equation Primitives/` | `Equation.Protocol` conformance (the institute `Equatable` twin). |
| `Orthant Hash Primitives` | `Sources/Orthant Hash Primitives/` | `Hash.Protocol` conformance (the institute `Hashable` twin). |
| `Orthant Comparison Primitives` | `Sources/Orthant Comparison Primitives/` | `Comparison.Protocol` conformance (the institute `Comparable` twin). |
| `Orthant Enumerable Primitives` | `Sources/Orthant Enumerable Primitives/` | `Finite.Enumerable` conformance: `count` (`2ᴺ`), `ordinal`, and `allCases`. |
| `Orthant Primitives` | `Sources/Orthant Primitives/` | Umbrella re-exporting all of the above. |
| `Orthant Primitives Test Support` | `Tests/Support/` | Re-exports the umbrella for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
