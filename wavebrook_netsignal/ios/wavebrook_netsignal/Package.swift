// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "wavebrook_netsignal",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(name: "wavebrook-netsignal", targets: ["wavebrook_netsignal"])
    ],
    dependencies: [
        .package(url: "https://github.com/wavebrook/ios-spm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "wavebrook_netsignal",
            dependencies: [
                .product(name: "WavebrookNetSignal", package: "ios-spm")
            ]
        )
    ]
)
