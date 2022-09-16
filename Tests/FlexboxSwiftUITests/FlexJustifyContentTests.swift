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
            FlexStack(
                size: Size(width: .percent(100), height: .percent(100)),
                justifyContent: .center
            ) {
                Color.red.flexStyle(
                    size: Size(
                        width: .percent(20),
                        height: .percent(100)
                    )
                )
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testStart() {
        let exp = assertFlex(
            FlexStack(
                size: Size(width: .percent(100), height: .percent(100)),
                justifyContent: .flexStart
            ) {
                Color.red.flexStyle(
                    size: Size(width: .percent(20), height: .percent(100))
                )
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testEnd() {
        let exp = assertFlex(
            FlexStack(
                size: Size(width: .percent(100), height: .percent(100)),
                justifyContent: .flexEnd
            ) {
                Color.red.flexStyle(
                    size: Size(width: .percent(20), height: .percent(100))
                )
            }
        )

        wait(for: exp, timeout: 1)
    }
}
