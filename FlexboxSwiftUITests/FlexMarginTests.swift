//
//  FlexMarginTests.swift
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

class FlexMarginTests: XCTestCase {
    func testMargins() {
        let view = FlexView(
            style: Style(flexDirection: .column, size: Size(width: .percent(1), height: .percent(1))),
            children: [
                (
                    Style(
                        margin: Rect(start: .undefined, end: .points(10), top: .points(10), bottom: .points(10)),
                        flexGrow: 1
                    ),
                    AnyView(Color.red)
                ),
                (
                    Style(
                        flexGrow: 1
                    ),
                    AnyView(Color.blue)
                )
            ],
            maxSize: assertSize
        ).frame(size: assertSize)
        
        assertSnapshot(matching: view, as: .image)
    }
}
