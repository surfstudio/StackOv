// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SidebarStore",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "SidebarStore", targets: ["SidebarStore"]),
    ],
    dependencies: [
        .package(path: "../Common")
    ],
    targets: [
        .target(name: "SidebarStore", dependencies: ["Common"]),
        .testTarget(name: "SidebarStoreTests", dependencies: ["SidebarStore"])
    ]
)
