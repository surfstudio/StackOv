// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StackexchangeNetworkService",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "StackexchangeNetworkService", targets: ["StackexchangeNetworkService"])
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../DataTransferObjects")
    ],
    targets: [
        .target(
            name: "StackexchangeNetworkService",
            dependencies: [
                "Common",
                "DataTransferObjects"
            ]),
        .testTarget(name: "StackexchangeNetworkServiceTests", dependencies: ["StackexchangeNetworkService"])
    ]
)

