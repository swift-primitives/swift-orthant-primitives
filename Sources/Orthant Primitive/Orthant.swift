// Orthant.swift
// An orthant of N-dimensional space: a sign choice on every axis.

import Direction_Primitive

/// An orthant of N-dimensional space: a `Direction` assigned to each of the `N` axes.
///
/// `Orthant<N>` is the N-dimensional generalization of a quadrant (2D, 4 inhabitants) and
/// octant (3D, 8 inhabitants). It has `2ᴺ` inhabitants and is the codimension-N extreme of
/// the general k-face: where a `Facet<N>` fixes a sign on exactly *one* axis, an
/// `Orthant<N>` fixes a sign on *every* axis.
///
/// The per-axis directions are stored in an `InlineArray<N, Direction>` indexed by axis
/// ordinal `0..<N`. Equality, hashing, and ordering are provided through the institute
/// twins `Equation.Protocol` / `Hash.Protocol` / `Comparison.Protocol` (in the
/// `Orthant Equation/Hash/Comparison Primitives` sub-targets), comparing the directions
/// lexicographically (axis 0 most significant).
///
/// ## Example
///
/// ```swift
/// let quadrant = Orthant<2> { axis in axis == 0 ? .positive : .negative }   // +x, −y
/// let d = quadrant.directions[0]                                            // .positive
/// let antipode = quadrant.opposite                                         // −x, +y
/// ```
public struct Orthant<let N: Int>: Sendable {
    /// The per-axis direction choices, indexed by axis ordinal `0..<N`.
    public let directions: InlineArray<N, Direction>

    /// Creates an orthant from per-axis direction choices.
    @inlinable
    public init(_ directions: InlineArray<N, Direction>) {
        self.directions = directions
    }
}

// MARK: - Construction

extension Orthant {
    /// An orthant with the same direction on every axis.
    @inlinable
    public init(repeating direction: Direction) {
        self.init(InlineArray<N, Direction>(repeating: direction))
    }

    /// An orthant built from a per-axis direction choice, indexed by axis ordinal `0..<N`.
    @inlinable
    public init(_ direction: (Int) -> Direction) {
        self.init(InlineArray<N, Direction> { index in direction(index) })
    }
}

// MARK: - Opposite

extension Orthant {
    /// The antipodal orthant: every axis direction flipped.
    @inlinable
    public var opposite: Orthant {
        Orthant(InlineArray<N, Direction> { index in directions[index].opposite })
    }
}

// MARK: - Equality, Hashing, Ordering

// The full ==/</<=/>/>= operator set + hash(into:) is declared here in the type's own
// module so it witnesses both any stdlib conformance and the institute
// `Equation.Protocol` / `Hash.Protocol` / `Comparison.Protocol` twins. Orthants compare
// their `Direction`s lexicographically — axis 0 is most significant.

extension Orthant {
    @inlinable
    public static func == (lhs: Orthant, rhs: Orthant) -> Bool {
        for index in 0..<N where lhs.directions[index] != rhs.directions[index] { return false }
        return true
    }

    @inlinable
    public static func < (lhs: Orthant, rhs: Orthant) -> Bool {
        for index in 0..<N where lhs.directions[index] != rhs.directions[index] {
            return lhs.directions[index] < rhs.directions[index]
        }
        return false
    }

    @inlinable
    public static func <= (lhs: Orthant, rhs: Orthant) -> Bool { !(rhs < lhs) }

    @inlinable
    public static func > (lhs: Orthant, rhs: Orthant) -> Bool { rhs < lhs }

    @inlinable
    public static func >= (lhs: Orthant, rhs: Orthant) -> Bool { !(lhs < rhs) }

    @inlinable
    public func hash(into hasher: inout Hasher) {
        for index in 0..<N { hasher.combine(directions[index].sign) }
    }
}

// MARK: - Codable

#if !hasFeature(Embedded)
    extension Orthant: Codable {
        @inlinable
        public init(from decoder: any Decoder) throws {
            var container = try decoder.unkeyedContainer()
            self.init(try InlineArray<N, Direction> { _ in try container.decode(Direction.self) })
        }

        @inlinable
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.unkeyedContainer()
            for index in 0..<N { try container.encode(directions[index]) }
        }
    }
#endif
