// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WMPlatform",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "WMNetwork", targets: ["WMNetwork"]),
        .library(name: "NumberRepository", targets: ["NumberRepository"])
    ],
    dependencies: [
        .package(path: "../ProxyModule")
    ],
    targets: [
        .target(
            name: "WMNetwork",
            dependencies: [
                .product(name: "ProxyModule", package: "ProxyModule")
            ]
        ),
        .target(
            name: "NumberRepository",
            dependencies: [
                "WMNetwork"
            ]
        )
    ]
)
