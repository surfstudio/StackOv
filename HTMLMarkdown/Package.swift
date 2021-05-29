// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HTMLMarkdown",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "HTMLMarkdown", targets: ["HTMLMarkdown"])
    ],
    dependencies: [
        .package(name: "SwiftSoup", url: "https://github.com/scinfu/SwiftSoup.git", .upToNextMajor(from: "2.3.2"))
    ],
    targets: [
        .target(name: "HTMLMarkdown", dependencies: ["SwiftSoup"]),
        .testTarget(name: "HTMLMarkdownTests", dependencies: ["HTMLMarkdown"])
    ]
)
