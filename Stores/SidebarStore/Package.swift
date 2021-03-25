// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SidebarStore",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "SidebarStore", targets: ["SidebarStore"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "SidebarStore", dependencies: []),
        .testTarget(name: "SidebarStoreTests", dependencies: ["SidebarStore"])
    ]
)
