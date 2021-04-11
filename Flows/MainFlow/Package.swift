// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MainFlow",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "MainFlow", targets: ["MainFlow"])
    ],
    dependencies: [
        .package(path: "../AppScript"),
        .package(path: "../Common"),
        .package(path: "../Components"),
        .package(path: "../Icons"),
        .package(path: "../Palette"),
        .package(path: "../AppScript"),
        .package(path: "HomeFlow"),
        .package(path: "FavoriteFlow"),
        .package(path: "MessagesFlow"),
        .package(path: "TagsFlow"),
        .package(path: "UsersFlow")
    ],
    targets: [
        .target(name: "MainFlow",
                dependencies: [
                    "AppScript",
                    "Common",
                    "Components",
                    "Icons",
                    "Palette",
                    "AppScript",
                    "HomeFlow",
                    "FavoriteFlow",
                    "MessagesFlow",
                    "TagsFlow",
                    "UsersFlow"
                ])
    ]
)
