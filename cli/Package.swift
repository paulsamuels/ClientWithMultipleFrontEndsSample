// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "cli",
    dependencies: [
         .package(path: "../Shared"),
    ],
    targets: [
        .target(name: "cli", dependencies: [ "Shared" ]),
    ]
)
