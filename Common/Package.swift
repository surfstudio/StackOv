// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(name: "Common", targets: ["Common"]),
    ],
    dependencies: [
        .package(name: "Introspect", url: "https://github.com/Puasonych/SwiftUI-Introspect.git", .branch("develop"))
    ],
    targets: [
        .target(name: "Common", dependencies: ["Introspect"])
    ]
)
