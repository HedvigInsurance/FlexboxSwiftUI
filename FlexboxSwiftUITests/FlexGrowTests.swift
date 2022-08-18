//
//  FlexboxSwiftUITests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import XCTest
@testable import FlexboxSwiftUI
import StretchKit
import SwiftUI
import SnapshotTesting

class FlexGrowTests: XCTestCase {
    func testEqual() {
        let view = FlexView(
            style: Style(justifyContent: .center, size: Size(width: .percent(1), height: .percent(1))),
            children: [
                (
                    Style(
                        flexGrow: 1
                    ),
                    AnyView(Color.red)
                ),
                (
                    Style(
                        flexGrow: 1
                    ),
                    AnyView(Color.blue)
                ),
                (
                    Style(
                        flexGrow: 1
                    ),
                    AnyView(Color.green)
                ),
            ],
            maxSize: assertSize
        ).frame(size: assertSize)
        
        assertSnapshot(matching: view, as: .image)
    }
    
    func testNonEqual() {
        let view = FlexView(
            style: Style(justifyContent: .center, size: Size(width: .percent(1), height: .percent(1))),
            children: [
                (
                    Style(
                        flexGrow: 2
                    ),
                    AnyView(Color.red)
                ),
                (
                    Style(
                        flexGrow: 1
                    ),
                    AnyView(Color.blue)
                ),
                (
                    Style(
                        flexGrow: 1
                    ),
                    AnyView(Color.green)
                ),
            ],
            maxSize: assertSize
        ).frame(size: assertSize)
        
        assertSnapshot(matching: view, as: .image)
    }
    
    func testNonEqualTwo() {
        let view = FlexView(
            style: Style(justifyContent: .center, size: Size(width: .percent(1), height: .percent(1))),
            children: [
                (
                    Style(
                        flexGrow: 2
                    ),
                    AnyView(Color.red)
                ),
                (
                    Style(
                        flexGrow: 1
                    ),
                    AnyView(Color.blue)
                ),
                (
                    Style(
                        flexGrow: 2
                    ),
                    AnyView(Color.green)
                ),
            ],
            maxSize: assertSize
        ).frame(size: assertSize)
        
        assertSnapshot(matching: view, as: .image)
    }
}

