// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Network",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(name: "Network", targets: ["Network"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.2")),
        .package(path: "../Common")
    ],
    targets: [
        .target(name: "Network", dependencies: ["Alamofire", "Common"])
    ]
)
