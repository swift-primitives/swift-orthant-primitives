# swift-orthant-primitives

The orthant for the Swift Institute primitives layer.

`Orthant<N>` assigns a `Direction` to every one of the `N` axes — the N-dimensional
generalization of a quadrant (2D, 4 inhabitants) and octant (3D, 8 inhabitants). It is the
composition `Directionᴺ` (`2ᴺ` inhabitants), stored as an `InlineArray<N, Direction>`.

```swift
import Orthant_Primitives

let quadrant = Orthant<2> { axis in axis == 0 ? .positive : .negative }   // +x, −y
quadrant.directions[0]   // .positive
quadrant.opposite        // −x, +y

Orthant<3>.count                       // 8
for o in Orthant<3>.allCases { print(o.ordinal) }   // 0...7
```

The root `Orthant Primitive` depends only on the `Direction Primitive` atom root and is
axis-free by design (indexed by axis ordinal `0..<N`). The single-axis-sign sibling
`Facet<N> = Axis<N> × Direction` lives in `swift-facet-primitives`.

## License

Apache License 2.0. See [LICENSE](LICENSE.md).
