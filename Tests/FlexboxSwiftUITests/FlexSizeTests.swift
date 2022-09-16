//
//  FlexSizeTests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest

@testable import FlexboxSwiftUI

class FlexSizeTests: XCTestCase {
    func testHalfHeight() {
        let exp = assertFlex(
            FlexStack(
                size: Size(
                    width: .percent(100),
                    height: .percent(50)
                )
            ) {
                Color.blue.flexStyle(
                    size: Size(width: .auto, height: .auto),
                    flexGrow: 1
                )
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testHalfWidth() {
        let exp = assertFlex(
            FlexStack(
                size: Size(width: .percent(50), height: .percent(100))
            ) {
                Color.blue.flexStyle(
                    size: Size(width: .auto, height: .auto),
                    flexGrow: 1
                )
            }
        )

        wait(for: exp, timeout: 1)
    }
}
