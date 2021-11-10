// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "html-parser",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "1.7.4"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "html-parser",
            dependencies: ["SwiftSoup"]),
        .testTarget(
            name: "html-parserTests",
            dependencies: ["SwiftSoup"]),
    ]
)
