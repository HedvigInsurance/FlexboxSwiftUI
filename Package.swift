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
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/sampettersson/Placement.git", from: "1.3.9")
    ],
    targets: [
        .target(
            name: "FlexboxSwiftUI",
            dependencies: [
                "FlexboxSwiftUIObjC",
                "Yoga",
                .product(name: "Placement", package: "Placement")
            ]
        ),
        .target(
            name: "FlexboxSwiftUIObjC",
            dependencies: ["Yoga"],
            publicHeadersPath: "include",
            cxxSettings: [
                .headerSearchPath(".")
            ]
        ),
        .target(
            name: "Yoga",
            dependencies: [],
            publicHeadersPath: "include",
            cxxSettings: [
                .headerSearchPath(".")
            ]
        ),
    ],
    cxxLanguageStandard: .cxx14
)
