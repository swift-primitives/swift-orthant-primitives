// swift-tools-version: 6.3.1
import PackageDescription

let package = Package(
    name: "swift-orthant-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        // MARK: - Namespace
        .library(
            name: "Orthant Primitive",
            targets: ["Orthant Primitive"]
        ),

        // MARK: - Sub-namespace targets
        .library(
            name: "Orthant Equation Primitives",
            targets: ["Orthant Equation Primitives"]
        ),
        .library(
            name: "Orthant Hash Primitives",
            targets: ["Orthant Hash Primitives"]
        ),
        .library(
            name: "Orthant Comparison Primitives",
            targets: ["Orthant Comparison Primitives"]
        ),
        .library(
            name: "Orthant Enumerable Primitives",
            targets: ["Orthant Enumerable Primitives"]
        ),

        // MARK: - Umbrella
        .library(
            name: "Orthant Primitives",
            targets: ["Orthant Primitives"]
        ),

        // MARK: - Test Support
        .library(
            name: "Orthant Primitives Test Support",
            targets: ["Orthant Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-direction-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-equation-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-hash-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-comparison-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-finite-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-ordinal-primitives.git", branch: "main"),
    ],
    targets: [
        // MARK: - Namespace
        // Orthant's storage is InlineArray<N, Direction>, so the root depends on the
        // Direction atom root only (the [MOD-017] cross-namespace-root exception); it is
        // axis-free by design (indexed by axis ordinal 0..<N).
        .target(
            name: "Orthant Primitive",
            dependencies: [
                .product(name: "Direction Primitive", package: "swift-direction-primitives"),
            ]
        ),

        // MARK: - Sub-namespace targets (per [MOD-031])
        // Institute Equatable/Hashable/Comparable twins:
        .target(
            name: "Orthant Equation Primitives",
            dependencies: [
                "Orthant Primitive",
                .product(name: "Equation Primitives", package: "swift-equation-primitives"),
            ]
        ),
        .target(
            name: "Orthant Hash Primitives",
            dependencies: [
                "Orthant Primitive",
                .product(name: "Hash Primitives", package: "swift-hash-primitives"),
            ]
        ),
        .target(
            name: "Orthant Comparison Primitives",
            dependencies: [
                "Orthant Primitive",
                .product(name: "Comparison Primitives", package: "swift-comparison-primitives"),
            ]
        ),
        // Finite.Enumerable conformance (2^N inhabitants enumeration):
        .target(
            name: "Orthant Enumerable Primitives",
            dependencies: [
                "Orthant Primitive",
                .product(name: "Direction Primitive", package: "swift-direction-primitives"),
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
                .product(name: "Ordinal Primitives", package: "swift-ordinal-primitives"),
            ]
        ),

        // MARK: - Umbrella
        .target(
            name: "Orthant Primitives",
            dependencies: [
                "Orthant Primitive",
                "Orthant Equation Primitives",
                "Orthant Hash Primitives",
                "Orthant Comparison Primitives",
                "Orthant Enumerable Primitives",
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Orthant Primitives Test Support",
            dependencies: [
                "Orthant Primitives",
                .product(name: "Ordinal Primitives Test Support", package: "swift-ordinal-primitives"),
            ],
            path: "Tests/Support"
        ),

        // MARK: - Tests
        .testTarget(
            name: "Orthant Primitives Tests",
            dependencies: [
                "Orthant Primitives",
                "Orthant Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
