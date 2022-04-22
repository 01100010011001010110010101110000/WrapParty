// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "WrapParty",
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "WrapParty",
      targets: ["WrapParty"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-log.git", branch: "main"),
  ],
  targets: [
    .target(
      name: "WrapParty",
      dependencies: [.product(name: "Logging", package: "swift-log")]
    ),
    .testTarget(
      name: "WrapPartyTests",
      dependencies: ["WrapParty"]
    ),
  ]
)
