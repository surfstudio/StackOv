// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Common", targets: ["Common"])
    ],
    dependencies: [
        .package(name: "Introspect", url: "https://github.com/Puasonych/SwiftUI-Introspect.git", .branch("develop")),
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "7.3.0"))
    ],
    targets: [
        .target(
            name: "Common",
            dependencies: [
                "Introspect",
                .product(name: "FirebaseCrashlytics", package: "Firebase")
            ]),
        .testTarget(name: "CommonTests", dependencies: ["Common"])
    ]
)
