// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Errors",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Errors", targets: ["Errors"])
    ],
    dependencies: [
        .package(path: "../Network")
    ],
    targets: [
        .target(name: "Errors", dependencies: ["Network"])
    ]
)
