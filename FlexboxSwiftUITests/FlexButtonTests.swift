//
//  FlexButtonTest.swift
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

class FlexButtonTests: XCTestCase {
    func testButtonContent() {
        let view = FlexView(
            style: Style(flexDirection: .row, size: Size(width: .percent(1), height: .percent(1))),
            children: [
                (
                    Style(
                        flexGrow: 1
                    ),
                    AnyView(Button("Some button text", role: .destructive, action: {
                        
                    }))
                ),
                (
                    Style(
                        flexGrow: 1
                    ),
                    AnyView(Button("Some other text", role: .cancel, action: {
                        
                    }))
                )
            ],
            maxSize: assertSize
        ).frame(size: assertSize)
        
        assertSnapshot(matching: view, as: .image)
    }
}
