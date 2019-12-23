// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Router",
    platforms: [.iOS(.v8)],
    products: [.library(name: "Router", targets: ["Router"])],
    targets: [.target(name: "Router")]
)
