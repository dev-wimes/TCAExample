// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "A",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "A", targets: ["A"]),
    ],
    dependencies: [
        .package(name: "WMPlatform", path: "../WMPlatform"),
    ],
    targets: [
        .target(
            name: "A",
            dependencies: [
                .product(name: "WMNetwork", package: "WMPlatform"),
                .product(name: "NumberRepository", package: "WMPlatform")
            ]
        ),
    ]
)
