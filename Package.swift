// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JoblogicMBProgressHUD",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "JoblogicMBProgressHUD",
            targets: ["JoblogicMBProgressHUD"]
        ),
    ],
    targets: [
        .target(
            name: "JoblogicMBProgressHUD",
            path: "Sources/Library",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
                .define("REACHABILITY_USE_SYSTEMCONFIGURATION", to: "1")
            ]
        ),
    ]
)
