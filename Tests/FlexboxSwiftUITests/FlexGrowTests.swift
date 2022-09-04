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
        let exp = assertFlex(
            FlexStack {
                FlexItem(
                    size: Size(width: .percent(100), height: .percent(100)),
                    justifyContent: .center
                ) {
                    FlexItem(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 1,
                        flexShrink: 1
                    ).background(Color.red)
                    FlexItem(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 1,
                        flexShrink: 1
                    ).background(Color.blue)
                    FlexItem(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 1,
                        flexShrink: 1
                    ).background(Color.green)
                }
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testNonEqual() {
        let exp = assertFlex(
            FlexStack {
                FlexItem(
                    size: Size(width: .percent(100), height: .percent(100)),
                    justifyContent: .center
                ) {
                    FlexItem(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 2,
                        flexShrink: 1
                    ).background(Color.red)
                    FlexItem(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 1,
                        flexShrink: 1
                    ).background(Color.blue)
                    FlexItem(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 1,
                        flexShrink: 1
                    ).background(Color.green)
                }
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testNonEqualTwo() {
        let exp = assertFlex(
            FlexStack {
                FlexItem(
                    size: Size(width: .percent(100), height: .percent(100)),
                    justifyContent: .center
                ) {
                    FlexItem(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 2
                    ).background(Color.red)
                    FlexItem(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 1
                    ).background(Color.blue)
                    FlexItem(
                        size: Size(width: .fixed(10), height: .auto),
                        flexGrow: 2
                    ).background(Color.green)
                }
            }
        )

        wait(for: exp, timeout: 1)
    }
}
