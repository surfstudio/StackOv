// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PostStore",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "PostStore", targets: ["PostStore"])
    ],
    dependencies: [
        .package(path: "../Services/StackexchangeNetworkService"),
        .package(path: "../Stores/PageStore")
    ],
    targets: [
        .target(name: "PostStore", dependencies: ["StackexchangeNetworkService", "PageStore"]),
        .testTarget(name: "PostStoreTests", dependencies: ["PostStore"])
    ]
)
