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
        url: "https://github.com/saudevteam/sau_tunnel/releases/download/2.0.0/SauTunnel.xcframework.zip",
        checksum: "94821ef9e79c880a74302d872772adfbbb58cc62104254c862c994374297b71f"
    )
  ]
)
