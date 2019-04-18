// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlameGraph",
    products: [
        .executable(name: "FlameGraph", targets: ["FlameGraph"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hartbit/Yaap.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "FlameGraph",
            dependencies: ["Yaap"]
        ),
        .testTarget(
            name: "FlameGraphTests",
            dependencies: ["FlameGraph"]
        ),
    ]
)
