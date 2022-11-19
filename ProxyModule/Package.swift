// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProxyModule",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "ProxyModule",
            targets: ["ProxyModule"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "0.46.0"
        ),
    ],
    targets: [
        .target(
            name: "ProxyModule",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]),
        .testTarget(
            name: "ProxyModuleTests",
            dependencies: ["ProxyModule"]),
    ]
)
