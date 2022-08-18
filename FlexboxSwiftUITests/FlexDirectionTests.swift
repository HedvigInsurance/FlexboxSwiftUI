//
//  FlexDirectionTests.swift
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

class FlexDirectionTests: XCTestCase {
    func testColumn() {
        let view = FlexView(
            style: Style(
                flexDirection: .column,
                justifyContent: .center,
                size: Size(width: .percent(1), height: .percent(1))
            ),
            children: [
                (
                    Style(
                        size: Size(width: .percent(1), height: .points(10))
                    ),
                    AnyView(Color.red)
                ),
                (
                    Style(
                        size: Size(width: .percent(1), height: .points(40))
                    ),
                    AnyView(Color.blue)
                )
            ],
            maxSize: assertSize
        ).frame(size: assertSize)
        
        assertSnapshot(matching: view, as: .image)
    }
    
    func testColumnJustify() {
        let view = FlexView(
            style: Style(
                flexDirection: .column,
                justifyContent: .flexStart,
                size: Size(
                    width: .percent(1),
                    height: .percent(1)
                )
            ),
            children: [
                (
                    Style(
                        size: Size(width: .percent(1), height: .points(10))
                    ),
                    AnyView(Color.red)
                ),
                (
                    Style(
                        size: Size(width: .percent(1), height: .points(40))
                    ),
                    AnyView(Color.blue)
                )
            ],
            maxSize: assertSize
        ).frame(size: assertSize)
        
        assertSnapshot(matching: view, as: .image)
    }
    
    func testRow() {
        let view = FlexView(
            style: Style(flexDirection: .row, size: Size(width: .percent(1), height: .percent(1))),
            children: [
                (
                    Style(
                        size: Size(width: .percent(0.5), height: .auto)
                    ),
                    AnyView(Color.red.frame(height: 10))
                ),
                (
                    Style(
                        size: Size(width: .percent(0.5), height: .auto)
                    ),
                    AnyView(Color.blue.frame(height: 40))
                )
            ],
            maxSize: assertSize
        ).frame(size: assertSize)
        
        assertSnapshot(matching: view, as: .image)
    }
}
