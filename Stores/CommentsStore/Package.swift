// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommentsStore",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "CommentsStore", targets: ["CommentsStore"]),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../HTMLMarkdown")
    ],
    targets: [
        .target(name: "CommentsStore", dependencies: ["Common", "HTMLMarkdown"]),
        .testTarget(name: "CommentsStoreTests", dependencies: ["CommentsStore"]),
    ]
)
