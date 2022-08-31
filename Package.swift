// swift-tools-version:5.3
// swift-tools-version:5.3
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
        .package(url: "https://github.com/ZupIT/Yoga.git", from: "1.0.0"),
        .package(url: "https://github.com/nalexn/ViewInspector.git", from: "0.9.1"),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.9.0"
        ),
    ],
    targets: [
        .target(
            name: "FlexboxSwiftUI",
            dependencies: [
                .product(name: "YogaKit", package: "Yoga"),
                "FlexboxSwiftUIObjC",
            ]
        ),
        .target(
            name: "FlexboxSwiftUIObjC",
            dependencies: [
                .product(name: "YogaKit", package: "Yoga")
            ],
            cxxSettings: [
                .headerSearchPath("Sources/FlexboxSwiftUIObjC")
            ]
        ),
        .testTarget(
            name: "FlexboxSwiftUITests",
            dependencies: [
                "FlexboxSwiftUI",
                "FlexboxSwiftUIObjC",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
                .product(name: "ViewInspector", package: "ViewInspector"),
            ]
        ),
    ],
    cxxLanguageStandard: .cxx14
)
