//
//  FlexboxSwiftUITests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import FlexboxSwiftUI

class FlexGrowTests: XCTestCase {
    func testEqual() {
        let exp = assertFlexView(
            FlexView(
                node: Node(
                    size: Size(width: .percent(100), height: .percent(100)),
                    children: [
                        Node(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            flexShrink: 1,
                            view: FlexChild(Color.red)
                        ),
                        Node(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            flexShrink: 1,
                            view: FlexChild(Color.blue)
                        ),
                        Node(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            flexShrink: 1,
                            view: FlexChild(Color.green)
                        ),
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
                        Node(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 2,
                            flexShrink: 1,
                            view: FlexChild(Color.red)
                        ),
                        Node(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            flexShrink: 1,
                            view: FlexChild(Color.blue)
                        ),
                        Node(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            flexShrink: 1,
                            view: FlexChild(Color.green)
                        ),
                    ],
                    justifyContent: .center
                )
            )
        )

        wait(for: [exp], timeout: 1)
    }

    func testNonEqualTwo() {
        let view = FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 2,
                        view: FlexChild(Color.red)
                    ),
                    Node(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 1,
                        view: FlexChild(Color.blue)
                    ),
                    Node(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 2,
                        view: FlexChild(Color.green)
                    ),
                ],
                justifyContent: .center
            )
        )
        .frame(assertSize)

        assertSnapshot(matching: view, as: .image)
    }
}
