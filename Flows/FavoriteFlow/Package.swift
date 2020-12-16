// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FavoriteFlow",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "FavoriteFlow", targets: ["FavoriteFlow"]),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../Palette"),
        .package(path: "../Components")
    ],
    targets: [
        .target(name: "FavoriteFlow", dependencies: ["Common", "Palette", "Components"])
    ]
)
