// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SoulAI",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "SoulAI",
            targets: ["SoulAI"]
        )
    ],
    targets: [
        .target(
            name: "SoulAI",
            path: ".",
            exclude: [
                "README.md",
                "DOCS"
            ]
        )
    ]
)
