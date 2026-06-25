// Orthant+Finite.Enumerable.swift
// Finite.Enumerable conformance for Orthant<N> (2^N inhabitants).

import Direction_Primitive
import Finite_Primitives
import Ordinal_Primitives
import Orthant_Primitive

// MARK: - Orthant: Finite.Enumerable

extension Orthant: Finite.Enumerable {
    /// The number of orthants of N-dimensional space: `2ᴺ`.
    @inlinable
    public static var count: Cardinal { Cardinal(integerLiteral: UInt(1) << UInt(N)) }

    /// Ordinal in `0..<2ᴺ`: axis `i` contributes bit `i`, set when its direction is negative.
    @inlinable
    public var ordinal: Ordinal {
        var bits: UInt = 0
        for index in 0..<N where directions[index] == .negative {
            bits |= (UInt(1) << UInt(index))
        }
        return Ordinal(bits)
    }

    /// Reconstructs an orthant from its ordinal without bounds checking.
    @inlinable
    public init(_unchecked: Void, ordinal: Ordinal) {
        let bits = ordinal.rawValue
        self.init(
            InlineArray<N, Direction> { index in
                (bits & (UInt(1) << UInt(index))) != 0 ? .negative : .positive
            }
        )
    }
}
