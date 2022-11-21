// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Home",
            targets: ["Home"]
        )
    ],
    dependencies: [
        .package(name: "Styleguide", path: "../Styleguide"),
        .package(url: "https://github.com/mercari/ShimmerView", from: "0.5.1")
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                .product(name: "Styleguide", package: "Styleguide"),
                .product(name: "ShimmerView", package: "ShimmerView")
            ]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]
        )
    ]
)
