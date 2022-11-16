// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataValidation",
    products: [
        .library(
            name: "Validating",
            targets: ["Validating"]
        ),
        .library(
            name: "Validator",
            targets: ["Validator"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Validating",
            dependencies: []
        ),
        .target(
            name: "Validator",
            dependencies: [
                .target(name: "Validating")
            ]
        ),
        .testTarget(
            name: "ValidatorTests",
            dependencies: [
                "Validator",
                .target(name: "Validating")
            ]
        )
    ]
)
