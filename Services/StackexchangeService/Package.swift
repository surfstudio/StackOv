// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StackexchangeService",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "StackexchangeService", targets: ["StackexchangeService"])
    ],
    dependencies: [
        .package(path: "../Network")
    ],
    targets: [
        .target(
            name: "StackexchangeService",
            dependencies: [
                "Network"
            ]
        )
    ]
)

