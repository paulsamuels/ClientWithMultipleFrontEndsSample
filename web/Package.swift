// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "web",
    dependencies: [
        .package(path: "../Shared"),
        .package(url: "https://github.com/pointfreeco/swift-html-vapor", from: "0.1.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
    ],
    targets: [
        .target(name: "App", dependencies: [ "HtmlVaporSupport", "Shared", "Vapor" ]),
        .target(name: "Run", dependencies: [ "App" ]),
    ]
)
