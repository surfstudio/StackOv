// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TagsFlow",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "TagsFlow", targets: ["TagsFlow"]),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../Palette")
    ],
    targets: [
        .target(name: "TagsFlow", dependencies: ["Common", "Palette"])
    ]
)
