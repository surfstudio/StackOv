// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataTransferObjects",
    products: [
        .library(name: "DataTransferObjects", targets: ["DataTransferObjects"])
    ],
    dependencies: [],
    targets: [
        .target(name: "DataTransferObjects", dependencies: []),
        .testTarget(name: "DataTransferObjectsTests", dependencies: ["DataTransferObjects"])
    ]
)
