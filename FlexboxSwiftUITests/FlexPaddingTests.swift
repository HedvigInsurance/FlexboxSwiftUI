//
//  FlexPaddingTests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import XCTest
@testable import FlexboxSwiftUI
import StretchKit
import SwiftUI
import SnapshotTesting

class FlexPaddingTests: XCTestCase {
    func testPadding() {
        let view = FlexView(
            style: Style(flexDirection: .row, size: Size(width: .percent(1), height: .percent(1))),
            children: [
                (
                    Style(
                        padding: .init(start: .points(50), end: .points(50), top: .auto, bottom: .auto),
                        flexGrow: 1
                    ),
                    AnyView(
                        ZStack {
                            Text("Padding")
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                    )
                ),
                (
                    Style(
                        flexGrow: 1
                    ),
                    AnyView(
                        ZStack {
                            Text("Padding")
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                    )
                )
            ],
            maxSize: assertSize
        ).frame(size: assertSize)
        
        assertSnapshot(matching: view, as: .image)
    }
}
