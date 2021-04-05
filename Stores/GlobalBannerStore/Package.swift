// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GlobalBannerStore",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "GlobalBannerStore", targets: ["GlobalBannerStore"])
    ],
    dependencies: [
        .package(path: "../Components")
    ],
    targets: [
        .target(
            name: "GlobalBannerStore",
            dependencies: ["Components"]),
        .testTarget(
            name: "GlobalBannerStoreTests",
            dependencies: ["GlobalBannerStore"]),
    ]
)
