// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "ArchitectureCore",
  platforms: [.iOS(.v26)],
  products: [
    .library(
      name: "ArchitectureCore",
      targets: ["ArchitectureCore"]
    ),
    .library(
      name: "Example",
      targets: ["Example"]
    )
  ],
  targets: [
    .target(
      name: "ArchitectureCore"
    ),
    .target(name: "Example", dependencies: ["ArchitectureCore"])
  ]
)
