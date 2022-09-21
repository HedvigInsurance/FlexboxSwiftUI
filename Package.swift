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
            cxxSettings: [
                .headerSearchPath("Sources/FlexboxSwiftUIObjC")
            ]
        )
    ],
    cxxLanguageStandard: .cxx14
)
