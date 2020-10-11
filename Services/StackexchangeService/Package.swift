// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StackexchangeService",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(name: "StackexchangeService", targets: ["StackexchangeService"])
//        .product(name: "Logging", package: "swift-log")
    ],
    dependencies: [
        .package(path: "../Network"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "StackexchangeService",
            dependencies: [
                "Network",
                .product(name: "Logging", package: "swift-log")
            ]
        )
    ]
)

