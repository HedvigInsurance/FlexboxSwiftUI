//
//  FlexJustifyContentTests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import FlexboxSwiftUI

class FlexJustifyContentTests: XCTestCase {
    func testCenter() {
        let exp = assertFlex(
            FlexStack {
                FlexItem(
                    size: Size(width: .percent(100), height: .percent(100)),
                    justifyContent: .center
                ) {
                    FlexItem(
                        size: Size(
                            width: .percent(20),
                            height: .percent(100)
                        )
                    ).background(Color.red)
                }
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testStart() {
        let exp = assertFlex(
            FlexStack {
                FlexItem(
                    size: Size(width: .percent(100), height: .percent(100)),
                    justifyContent: .flexStart
                ) {
                    FlexItem(
                        size: Size(width: .percent(20), height: .percent(100))
                    ).background(Color.red)
                }
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testEnd() {
        let exp = assertFlex(
            FlexStack {
                FlexItem(
                    size: Size(width: .percent(100), height: .percent(100)),
                    justifyContent: .flexEnd

                ) {
                    FlexItem(
                        size: Size(width: .percent(20), height: .percent(100))
                    ).background(Color.red)
                }
            }
        )

        wait(for: exp, timeout: 1)
    }
}
