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
            FlexStack(
                size: Size(width: .percent(100), height: .percent(100)),
                justifyContent: .center
            ) {
                Color.red.flexStyle(
                    size: Size(width: .fixed(10), height: .auto),
                    flexGrow: 1,
                    flexShrink: 1
                )
                Color.blue.flexStyle(
                    size: Size(width: .fixed(10), height: .auto),
                    flexGrow: 1,
                    flexShrink: 1
                )
                Color.green.flexStyle(
                    size: Size(width: .fixed(10), height: .auto),
                    flexGrow: 1,
                    flexShrink: 1
                )
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testNonEqual() {
        let exp = assertFlex(
            FlexStack(
                size: Size(width: .percent(100), height: .percent(100)),
                justifyContent: .center
            ) {
                Color.red.flexStyle(
                    size: Size(width: .fixed(10), height: .auto),
                    flexGrow: 2,
                    flexShrink: 1
                )
                Color.blue.flexStyle(
                    size: Size(width: .fixed(10), height: .auto),
                    flexGrow: 1,
                    flexShrink: 1
                )
                Color.green.flexStyle(
                    size: Size(width: .fixed(10), height: .auto),
                    flexGrow: 1,
                    flexShrink: 1
                )
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testNonEqualTwo() {
        let exp = assertFlex(
            FlexStack(
                size: Size(width: .percent(100), height: .percent(100)),
                justifyContent: .center
            ) {
                Color.red.flexStyle(
                    size: Size(width: .fixed(10), height: .auto),
                    flexGrow: 2
                )
                Color.blue.flexStyle(
                    size: Size(width: .fixed(10), height: .auto),
                    flexGrow: 1
                )
                Color.green.flexStyle(
                    size: Size(width: .fixed(10), height: .auto),
                    flexGrow: 2
                )
            }
        )

        wait(for: exp, timeout: 1)
    }
}
