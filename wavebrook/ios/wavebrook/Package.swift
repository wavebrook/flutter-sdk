// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "wavebrook",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "wavebrook", targets: ["wavebrook"])
    ],
    dependencies: [
        .package(url: "https://github.com/wavebrook/ios-spm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "wavebrook",
            dependencies: [
                .product(name: "WavebrookCore", package: "ios-spm")
            ]
        )
    ]
)
