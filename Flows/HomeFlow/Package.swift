// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HomeFlow",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "HomeFlow", targets: ["HomeFlow"]),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../Palette"),
        .package(path: "../Components")
    ],
    targets: [
        .target(name: "HomeFlow", dependencies: ["Common", "Palette", "Components"])
    ]
)
