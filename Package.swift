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
        ),
        .library(
            name: "FlexboxSwiftUIObjC",
            targets: ["FlexboxSwiftUIObjC"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/nalexn/ViewInspector.git", from: "0.9.1"),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.9.0"
        ),
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
