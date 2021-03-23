// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FavoriteStore",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "FavoriteStore", targets: ["FavoriteStore"]),
    ],
    dependencies: [
        .package(path: "../Services/StackexchangeNetworkService"),
        .package(path: "../Palette")
    ],
    targets: [
        .target(name: "FavoriteStore", dependencies: ["StackexchangeNetworkService", "Palette"]),
        .testTarget(name: "FavoriteStoreTests", dependencies: ["FavoriteStore"])
    ]
)
