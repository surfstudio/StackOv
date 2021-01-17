// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StackOv",
    targets: [
        .binaryTarget(
            name: "XCBeautify",
            url: "https://github.com/thii/xcbeautify/releases/download/0.9.1/xcbeautify-0.9.1-universal-apple-macosx.zip",
            checksum: "c134c1f57fa7ca0efb35a159183176941f77e8e07c474c82be2da692ac9482fd"
        )]
)
