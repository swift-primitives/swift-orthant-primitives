// Orthant+Finite.Enumerable Tests.swift

import Orthant_Primitives
import Orthant_Primitives_Test_Support
import Testing

// MARK: - Orthant+Finite.Enumerable - Enumerable

@Suite
struct `Orthant+Finite.Enumerable - Enumerable` {
    @Test
    func `count is 2^N`() {
        #expect(Orthant<1>.count == 2)
        #expect(Orthant<2>.count == 4)
        #expect(Orthant<3>.count == 8)
        #expect(Orthant<4>.count == 16)
    }

    @Test
    func `ordinal bit-encodes negative axes`() {
        #expect(Orthant<3>(repeating: .positive).ordinal == 0)
        #expect(Orthant<3>(repeating: .negative).ordinal == 7)  // 0b111
        #expect(Orthant<3> { $0 == 0 ? .negative : .positive }.ordinal == 1)  // bit 0
        #expect(Orthant<3> { $0 == 2 ? .negative : .positive }.ordinal == 4)  // bit 2
    }
}

// MARK: - Orthant+Finite.Enumerable - AllCases

@Suite
struct `Orthant+Finite.Enumerable - AllCases` {
    @Test
    func `allCases has 2^N elements`() {
        #expect(Array(Orthant<1>.allCases).count == 2)
        #expect(Array(Orthant<2>.allCases).count == 4)
        #expect(Array(Orthant<3>.allCases).count == 8)
    }

    @Test
    func `allCases round-trips through ordinal`() {
        for orthant in Orthant<3>.allCases {
            #expect(Orthant<3>(_unchecked: (), ordinal: orthant.ordinal) == orthant)
        }
    }
}
