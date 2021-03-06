// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import class Foundation.ProcessInfo

let package = Package(
    name: "Common",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Common", targets: ["Common"])
    ],
    dependencies: Package.dependencies,
    targets: [
        .target(name: "Common", dependencies: Target.dependencies),
        .testTarget(name: "CommonTests", dependencies: ["Common"])
    ]
)

fileprivate extension Package {
    
    static var firebaseIsEnable: Bool {
        ProcessInfo.processInfo.environment["FIREBASE_DISABLED"] == nil
    }
}

fileprivate extension Target {
    
    static var dependencies: [Dependency] {
        var packages: [Dependency] = ["Introspect", "DataTransferObjects", "Errors", "Kingfisher"]
        if Package.firebaseIsEnable {
            packages.append(.product(name: "FirebaseCrashlytics", package: "Firebase"))
        }
        return packages
    }
}

fileprivate extension Package {
    
    static var dependencies: [Dependency] {
        internalDependencies + externalDependencies
    }
    
    static var internalDependencies: [Dependency] {
        return [
			.package(name: "DataTransferObjects", path: "../DataTransferObjects"),
            .package(path: "../Errors")
        ]
    }
    
    static var externalDependencies: [Dependency] {
        var packages: [Dependency] = [
            .package(name: "Introspect", url: "https://github.com/Puasonych/SwiftUI-Introspect.git", .branch("develop")),
            .package(name: "Kingfisher", url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "6.0.0"))
        ]
        if Package.firebaseIsEnable {
            packages.append(
                .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "7.3.0"))
            )
        }
        return packages
    }
}
