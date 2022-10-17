// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SurveyClient",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "SurveyClientType",
            targets: ["SurveyClientType"]
        ),
        .library(
            name: "SurveyClient",
            targets: ["SurveyClient"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/nimblehq/JSONMapper.git", from: "1.1.1")
    ],
    targets: [
        .target(
            name: "SurveyClientType",
            dependencies: []
        ),
        .target(
            name: "SurveyClient",
            dependencies: [
                .target(name: "SurveyClientType"),
                .product(name: "JSONAPIMapper", package: "JSONMapper")
            ]
        ),
        .target(
            name: "Mocker"
        ),
        .testTarget(
            name: "SurveyClientTests",
            dependencies: [
                "SurveyClient",
                .target(name: "SurveyClientType"),
                .target(name: "Mocker")
            ]
        )
    ]
)
