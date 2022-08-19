//
//  FlexboxSwiftUITests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import XCTest
@testable import FlexboxSwiftUI
import SwiftUI
import SnapshotTesting

class FlexGrowTests: XCTestCase {
    func testEqual() {
        let exp = assertFlexView(
            FlexView(
                node: Node(
                    size: Size(width: .percent(100), height: .percent(100)),
                    children: [
                        Node(size: Size(width: .fixed(10), height: .auto), flexGrow: 1, flexShrink: 1, view: AnyView(Color.red)),
                        Node(size: Size(width: .fixed(10), height: .auto), flexGrow: 1, flexShrink: 1, view: AnyView(Color.blue)),
                        Node(size: Size(width: .fixed(10), height: .auto), flexGrow: 1, flexShrink: 1, view: AnyView(Color.green)),
                    ],
                    justifyContent: .center
                )
            )
        )
        
        wait(for: [exp], timeout: 1)
    }
    
    func testNonEqual() {
        let exp = assertFlexView(
            FlexView(
                node: Node(
                    size: Size(width: .percent(100), height: .percent(100)),
                    children: [
                        Node(size: Size(width: .fixed(10), height: .auto), flexGrow: 2, flexShrink: 1, view: AnyView(Color.red)),
                        Node(size: Size(width: .fixed(10), height: .auto), flexGrow: 1, flexShrink: 1, view: AnyView(Color.blue)),
                        Node(size: Size(width: .fixed(10), height: .auto), flexGrow: 1, flexShrink: 1, view: AnyView(Color.green)),
                    ],
                    justifyContent: .center
                ),
                maxSize: assertSize
            )
        )
        
        wait(for: [exp], timeout: 1)
    }
    
    func testNonEqualTwo() {
        let view = FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(size: Size(width: .fixed(10), height: .auto), flexGrow: 2, view: AnyView(Color.red)),
                    Node(size: Size(width: .fixed(10), height: .auto), flexGrow: 1, view: AnyView(Color.blue)),
                    Node(size: Size(width: .fixed(10), height: .auto), flexGrow: 2, view: AnyView(Color.green)),
                ],
                justifyContent: .center
            ),
            maxSize: assertSize
        ).frame(assertSize)
        
        assertSnapshot(matching: view, as: .image)
    }
}

