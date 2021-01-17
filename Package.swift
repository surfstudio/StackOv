// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StackOv",
    dependencies: [
        .package(url: "https://github.com/thii/xcbeautify.git", .upToNextMajor(from: "0.9.1"))
    ],
    targets: [
        .target(name: "StackOv", dependencies: [])
    ]
)
