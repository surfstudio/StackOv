// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AuthManager",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(name: "AuthManager", targets: ["AuthManager"])
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../Network")
    ],
    targets: [
        .target(name: "AuthManager", dependencies: ["Common", "Network"]),
        .testTarget(name: "AuthManagerTests", dependencies: ["AuthManager"])
    ]
)
