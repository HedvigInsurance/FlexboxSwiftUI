// swift-tools-version:5.7
import Foundation
import PackageDescription

let package = Package(
    name: "FlexboxSwiftUI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "FlexboxSwiftUI",
            targets: ["FlexboxSwiftUI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/sampettersson/Placement.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "FlexboxSwiftUI",
            dependencies: [
                "FlexboxSwiftUIObjC",
                .product(name: "Placement", package: "Placement")
            ]
        ),
        .target(
            name: "FlexboxSwiftUIObjC",
            dependencies: [],
            path: "Sources/FlexboxSwiftUIObjC",
            cSettings: [
                .headerSearchPath("include"),
                .define("MODULEMAP_FILE", to: "include/module.modulemap"),
                .define("DEFINES_MODULE=YES")
            ]
        )
    ],
    cxxLanguageStandard: .cxx14
)
