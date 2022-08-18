//
//  FlexSizeTests.swift
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

class FlexSizeTests: XCTestCase {
    func testHalfHeight() {
        let view = FlexView(
            style: Style(flexDirection: .column, size: Size(width: .percent(1), height: .percent(0.5))),
            children: [
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
    
    func testHalfWidth() {
        let view = FlexView(
            style: Style(flexDirection: .column, size: Size(width: .percent(0.5), height: .percent(1))),
            children: [
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
