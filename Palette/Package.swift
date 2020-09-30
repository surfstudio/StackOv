// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Palette",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(name: "Palette", targets: ["Palette"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftGen/SwiftGen.git", from: "6.3.0")
    ],
    targets: [
        .target(name: "Palette", dependencies: [])
    ]
)
