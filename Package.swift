// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Sourceful",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Sourceful",
            targets: ["Sourceful"]),
    ],
    targets: [
        .target(
            name: "Sourceful",
            path: "Sources"),
    ]
)
