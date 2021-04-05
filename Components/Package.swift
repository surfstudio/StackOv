// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Components",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Components", targets: ["Components"]),
    ],
    dependencies: [
        .package(path: "../Palette"),
        .package(path: "../Icons"),
        .package(path: "../Markdown"),
        .package(path: "../Common")
    ],
    targets: [
        .target(name: "Components", dependencies: ["Palette", "Markdown", "Icons", "Common"])
    ]
)
