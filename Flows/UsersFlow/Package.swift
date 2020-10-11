// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UsersFlow",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "UsersFlow", targets: ["UsersFlow"]),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../Palette")
    ],
    targets: [
        .target(name: "UsersFlow", dependencies: ["Common", "Palette"])
    ]
)
