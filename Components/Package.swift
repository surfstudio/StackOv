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
        .package(path: "../Common"),
        .package(path: "../Markdown"),
        .package(path: "../AppScript"),
        .package(url: "https://github.com/raspu/Highlightr.git", .revision("93199b9e434f04bda956a613af8f571933f9f037"))
    ],
    targets: [
        .target(name: "Components", dependencies: ["Palette", "Markdown", "AppScript", "Icons", "Common", "Highlightr"])
    ]
)
