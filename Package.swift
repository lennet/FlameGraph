// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlameGraph",
    products: [
        .executable(name: "FlameGraph", targets: ["FlameGraph"]),
    ],
    targets: [
        .target(
            name: "FlameGraph",
            dependencies: []
        ),
        .testTarget(
            name: "FlameGraphTests",
            dependencies: ["FlameGraph"]
        ),
    ]
)
