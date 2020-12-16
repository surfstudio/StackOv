// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HomeStore",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(name: "HomeStore", targets: ["HomeStore"]),
    ],
    dependencies: [
        .package(path: "../Services/StackexchangeService")
    ],
    targets: [
        .target(name: "HomeStore", dependencies: ["StackexchangeService"])
    ]
)
