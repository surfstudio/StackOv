// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ThreadFlow",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "ThreadFlow", targets: ["ThreadFlow"]),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../Palette"),
        .package(path: "../Icons"),
        .package(path: "../Components"),
        .package(path: "../AppScript")
    ],
    targets: [
        .target(name: "ThreadFlow", dependencies: ["Common", "Palette", "Icons", "Components", "AppScript"]),
    ]
)
