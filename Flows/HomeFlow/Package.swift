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
        .package(path: "../Icons"),
        .package(path: "../Components"),
        .package(path: "../AppScript")
    ],
    targets: [
        .target(name: "HomeFlow", dependencies: ["Common", "Palette", "Icons", "Components", "AppScript"])
    ]
)
