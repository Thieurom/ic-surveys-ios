// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Login",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Login",
            targets: ["Login"]
        )
    ],
    dependencies: [
        .package(name: "Styleguide", path: "../Styleguide"),
        .package(name: "SurveyClient", path: "../SurveyClient"),
        .package(name: "DataValidation", path: "../DataValidation")
    ],
    targets: [
        .target(
            name: "Login",
            dependencies: [
                .product(name: "Styleguide", package: "Styleguide"),
                .product(name: "SurveyClientType", package: "SurveyClient"),
                .product(name: "Validating", package: "DataValidation")
            ]
        ),
        .testTarget(
            name: "LoginTests",
            dependencies: ["Login"]
        )
    ]
)
