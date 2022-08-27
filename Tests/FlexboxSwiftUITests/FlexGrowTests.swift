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
        let exp = assertFlexNode(
            Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 1,
                        flexShrink: 1,
                        view: AnyView(TestColor(color: .red))
                    ),
                    Node(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 1,
                        flexShrink: 1,
                        view: AnyView(TestColor(color: .blue))
                    ),
                    Node(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 1,
                        flexShrink: 1,
                        view: AnyView(TestColor(color: .green))
                    ),
                ],
                justifyContent: .center
            )
        )

        wait(for: exp, timeout: 1)
    }

    func testNonEqual() {
        let exp = assertFlexNode(
            Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 2,
                        flexShrink: 1,
                        view: AnyView(TestColor(color: .red))
                    ),
                    Node(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 1,
                        flexShrink: 1,
                        view: AnyView(TestColor(color: .blue))
                    ),
                    Node(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 1,
                        flexShrink: 1,
                        view: AnyView(TestColor(color: .green))
                    ),
                ],
                justifyContent: .center
            )
        )

        wait(for: exp, timeout: 1)
    }

    func testNonEqualTwo() {
        let exp = assertFlexNode(
            Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 2,
                        view: AnyView(TestColor(color: .red))
                    ),
                    Node(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 1,
                        view: AnyView(TestColor(color: .blue))
                    ),
                    Node(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 2,
                        view: AnyView(TestColor(color: .green))
                    ),
                ],
                justifyContent: .center
            )
        )

        wait(for: exp, timeout: 1)
    }
}
