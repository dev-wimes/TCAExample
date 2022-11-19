// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "B1",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "B1", targets: ["B1"])
    ],
    dependencies: [
        .package(name: "WMPlatform", path: "../WMPlatform")
    ],
    targets: [
        .target(
            name: "B1",
            dependencies: [
                .product(name: "WMNetwork", package: "WMPlatform"),
                .product(name: "NumberRepository", package: "WMPlatform")
            ]
        ),
    ]
)
