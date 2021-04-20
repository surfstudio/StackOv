// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let package = Package(
    name: "AppScript",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "AppScript", targets: ["AppScript"])
    ],
    dependencies: Package.dependencies,
    targets: [
        .target(name: "AppScript", dependencies: Target.dependencies),
        .testTarget(name: "AppScriptTests", dependencies: ["AppScript"])
    ]
)

fileprivate extension Target {
    
    static var dependencies: [Dependency] {
        Package.dependencies.map { Dependency(stringLiteral: $0.name!) }
    }
}

fileprivate extension Package {
    
    static var dependencies: [Dependency] {
        externalDependencies + serviceDependencies + storeDependencies
    }
    
    static var externalDependencies: [Dependency] {
        [.package(name: "Swinject", url: "https://github.com/Swinject/Swinject.git", from: "2.7.1")]
    }
    
    static var serviceDependencies: [Dependency] {
        [.package(name: "StackexchangeNetworkService", path: "../Services/StackexchangeNetworkService")]
    }
    
    static var storeDependencies: [Dependency] {
        [.package(name: "GlobalBannerStore", path: "../Stores/GlobalBannerStore"),
         .package(name: "ThreadStore", path: "../Stores/ThreadStore"),
         .package(name: "PageStore", path: "../Stores/PageStore"),
         .package(name: "FilterStore", path: "../Stores/FilterStore"),
         .package(name: "FavoriteStore", path: "../Stores/FavoriteStore"),
         .package(name: "SidebarStore", path: "../Stores/SidebarStore"),
         .package(name: "CommentsStore", path: "../Stores/CommentsStore")]
    }
}
