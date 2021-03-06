// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PageStore",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "PageStore", targets: ["PageStore"]),
    ],
    dependencies: [
        .package(path: "../Services/StackexchangeNetworkService"),
        .package(path: "../Palette"),
        .package(path: "../Stores/FilterStore")
    ],
    targets: [
        .target(name: "PageStore", dependencies: ["StackexchangeNetworkService", "Palette", "FilterStore"]),
        .testTarget(name: "PageStoreTests", dependencies: ["PageStore"])
    ]
)
