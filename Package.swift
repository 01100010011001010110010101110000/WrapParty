// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "WrapParty",
  platforms: [
    .macOS(.v12),
    .iOS(.v15),
    .tvOS(.v15),
    .watchOS(.v8)
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "WrapParty",
      targets: ["WrapParty"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-log.git", .upToNextMajor(from: "1.4.2")),
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
