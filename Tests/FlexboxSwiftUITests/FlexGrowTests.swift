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
            FlexRoot {
                FlexNode(
                    style: FlexStyle(
                        size: Size(width: .percent(100), height: .percent(100)),
                        justifyContent: .center
                    )
                ) {
                    FlexNode(
                        style: FlexStyle(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            flexShrink: 1
                        )
                    ) {
                        TestColor(color: .red)
                    }
                    FlexNode(
                        style: FlexStyle(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            flexShrink: 1
                        )
                    ) {
                        TestColor(color: .blue)
                    }
                    FlexNode(
                        style: FlexStyle(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            flexShrink: 1
                        )
                    ) {
                        TestColor(color: .green)
                    }
                }
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testNonEqual() {
        let exp = assertFlex(
            FlexRoot {
                FlexNode(
                    style: FlexStyle(
                        size: Size(width: .percent(100), height: .percent(100)),
                        justifyContent: .center
                    )
                ) {
                    FlexNode(
                        style: FlexStyle(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 2,
                            flexShrink: 1
                        )
                    ) {
                        TestColor(color: .red)
                    }
                    FlexNode(
                        style: FlexStyle(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            flexShrink: 1
                        )
                    ) {
                        TestColor(color: .blue)
                    }
                    FlexNode(
                        style: FlexStyle(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            flexShrink: 1
                        )
                    ) {
                        TestColor(color: .green)
                    }
                }
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testNonEqualTwo() {
        let exp = assertFlex(
            FlexRoot {
                FlexNode(
                    style: FlexStyle(
                        size: Size(width: .percent(100), height: .percent(100)),
                        justifyContent: .center
                    )
                ) {
                    FlexNode(
                        style: FlexStyle(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 2
                        )
                    ) {
                        TestColor(color: .red)
                    }
                    FlexNode(
                        style: FlexStyle(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1
                        )
                    ) {
                        TestColor(color: .blue)
                    }
                    FlexNode(
                        style: FlexStyle(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 2
                        )
                    ) {
                        TestColor(color: .green)
                    }
                }
            }
        )

        wait(for: exp, timeout: 1)
    }
}
