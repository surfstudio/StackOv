// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ThreadStore",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "ThreadStore", targets: ["ThreadStore"]),
    ],
    dependencies: [
        .package(path: "../Services/StackexchangeNetworkService"),
        .package(path: "../Stores/PageStore")
    ],
    targets: [
        .target(name: "ThreadStore", dependencies: ["StackexchangeNetworkService", "PageStore"]),
        .testTarget(name: "ThreadStoreTests", dependencies: ["ThreadStore"]),
    ]
)
