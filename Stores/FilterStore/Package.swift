// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FilterStore",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "FilterStore", targets: ["FilterStore"]),
    ],
    targets: [
        .target(name: "FilterStore", dependencies: []),
        .testTarget(name: "FilterStoreTests", dependencies: ["FilterStore"])
    ]
)
