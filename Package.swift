// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "SauTunn",
  products: [
    .library(
        name: "SauTunn",
        targets: ["SauTunn"]
    ),
    .library(
        name: "SauTunnC",
        targets: ["SauTunnC"]
    )
  ],
  targets: [
    .target(
        name: "SauTunn",
        dependencies: ["SauTunnel", "SauTunnC"]
    ),
    .target(
        name: "SauTunnC",
        publicHeadersPath: "."
    ),
    .binaryTarget(
        name: "SauTunnel",
        url: "https://github.com/saudevteam/sau_tunnel/releases/download/1.0.0/SauTunnel.xcframework.zip",
        checksum: "e0f4910aaa192236594464f5b79dc3a8722d572bbc91e688a6998831fccf2a21"
    )
  ]
)
