//
//  FlexJustifyContentTests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import XCTest
@testable import FlexboxSwiftUI
import StretchKit
import SwiftUI
import SnapshotTesting

class FlexJustifyContentTests: XCTestCase {    
    func testCenter() {
        let view = FlexView(
            style: Style(justifyContent: .center, size: Size(width: .percent(1), height: .percent(1))),
            children: [
                (
                    Style(
                        size: Size(width: .percent(0.2), height: .percent(1))
                    ),
                    AnyView(Color.red)
                )
            ],
            maxSize: assertSize
        ).frame(size: assertSize)
        
        assertSnapshot(matching: view, as: .image)
    }
    
    func testStart() {
        let view = FlexView(
            style: Style(justifyContent: .flexStart, size: Size(width: .percent(1), height: .percent(1))),
            children: [
                (
                    Style(
                        size: Size(width: .percent(0.2), height: .percent(1))
                    ),
                    AnyView(Color.red)
                )
            ],
            maxSize: assertSize
        ).frame(size: assertSize)
        
        assertSnapshot(matching: view, as: .image)
    }
    
    func testEnd() {
        let view = FlexView(
            style: Style(justifyContent: .flexEnd, size: Size(width: .percent(1), height: .percent(1))),
            children: [
                (
                    Style(
                        size: Size(width: .percent(0.2), height: .percent(1))
                    ),
                    AnyView(Color.red)
                )
            ],
            maxSize: assertSize
        ).frame(size: assertSize)
        
        assertSnapshot(matching: view, as: .image)
    }
}
