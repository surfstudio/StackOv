// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotificationsDisplayService",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "NotificationsDisplayService", targets: ["NotificationsDisplayService"])
    ],
    dependencies: [
        .package(path: "../Components"),
        .package(path: "../Errors")
    ],
    targets: [
        .target(
            name: "NotificationsDisplayService",
            dependencies: ["Components", "Errors"])
    ]
)
