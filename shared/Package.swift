// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Shared",
    products: [
        .library(name: "Shared", targets: [ "Shared" ]),
    ],
    dependencies: [
         .package(url: "https://github.com/Flight-School/AnyCodable", from: "0.1.0"),
    ],
    targets: [
        .target(name: "Shared", dependencies: [ "AnyCodable" ]),
    ]
)
