// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Survey",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Survey",
            targets: ["Survey"]
        )
    ],
    dependencies: [
        .package(name: "Styleguide", path: "../Styleguide"),
        .package(name: "SharedModels", path: "../SharedModels")
    ],
    targets: [
        .target(
            name: "Survey",
            dependencies: [
                .product(name: "Styleguide", package: "Styleguide"),
                .product(name: "SharedModels", package: "SharedModels")
            ]
        ),
        .testTarget(
            name: "SurveyTests",
            dependencies: ["Survey"]
        )
    ]
)
