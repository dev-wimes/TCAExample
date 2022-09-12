// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Effects",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Effects", type: .dynamic, targets: ["Effects"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            .upToNextMajor(from: "0.36.0")
        ),
        .package(
            url: "https://github.com/johnpatrickmorgan/TCACoordinators",
            .upToNextMajor(from: "0.2.0")
        ),
    ],
    targets: [
        .target(
            name: "Effects",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "TCACoordinators", package: "TCACoordinators")
            ]),
        .testTarget(
            name: "EffectsTests",
            dependencies: ["Effects"]),
    ]
)
