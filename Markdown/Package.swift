// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Markdown",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Markdown", targets: ["Markdown"])
    ],
    dependencies: [
        .package(name: "Down", url: "https://github.com/johnxnguyen/Down.git", .upToNextMajor(from: "0.9.4")),
        .package(name: "HTMLEntities", url: "https://github.com/Kitura/swift-html-entities.git", .upToNextMajor(from: "3.0.14"))
    ],
    targets: [
        .target(name: "Markdown", dependencies: ["Down", "HTMLEntities"]),
        .testTarget(name: "MarkdownTests", dependencies: ["Markdown"])
    ]
)
