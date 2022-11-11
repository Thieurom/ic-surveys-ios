// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Splash",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Splash",
            targets: ["Splash"]
        )
    ],
    dependencies: [
        .package(name: "Styleguide", path: "../Styleguide")
    ],
    targets: [
        .target(
            name: "Splash",
            dependencies: [
                .product(name: "Styleguide", package: "Styleguide")
            ]
        ),
        .testTarget(
            name: "SplashTests",
            dependencies: ["Splash"]
        )
    ]
)
