//
//  FlexSizeTests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import XCTest
@testable import FlexboxSwiftUI
import SwiftUI
import SnapshotTesting

class FlexSizeTests: XCTestCase {
    func testHalfHeight() {
        let exp = assertFlexView(FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .percent(50)),
                children: [
                    Node(
                        size: Size(width: .auto, height: .auto),
                        flexGrow: 1,
                        view: AnyView(Color.blue)
                    ),
                ]
            )
        ))
        
        wait(for: [exp], timeout: 1)
    }

    func testHalfWidth() {
        let exp = assertFlexView(FlexView(
            node: Node(
                size: Size(width: .percent(50), height: .percent(100)),
                children: [
                    Node(
                        size: Size(width: .auto, height: .auto),
                        flexGrow: 1,
                        view: AnyView(Color.blue)
                    ),
                ]
            )
        ))
        
        wait(for: [exp], timeout: 1)
    }
}
