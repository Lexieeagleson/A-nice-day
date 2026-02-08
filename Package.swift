// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ANiceDay",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "ANiceDay",
            targets: ["ANiceDay"]),
    ],
    dependencies: [
        // Add any external dependencies here if needed
    ],
    targets: [
        .target(
            name: "ANiceDay",
            dependencies: [],
            path: "Sources/ANiceDay"),
        .testTarget(
            name: "ANiceDayTests",
            dependencies: ["ANiceDay"],
            path: "Tests/ANiceDayTests"),
    ]
)

// Note: This is an iOS app using SwiftUI.
// To build and run:
// 1. Open this package in Xcode 15+
// 2. Select an iOS simulator or device
// 3. Build and run (Cmd+R)
//
// This package cannot be built with 'swift build' command line tool
// because it requires iOS frameworks (SwiftUI, CoreData, CoreLocation, WeatherKit)
