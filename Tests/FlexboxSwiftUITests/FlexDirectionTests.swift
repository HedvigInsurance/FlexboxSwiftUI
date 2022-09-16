//
//  FlexDirectionTests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest

@testable import FlexboxSwiftUI

class FlexDirectionTests: XCTestCase {
    func testColumn() {
        let exp = assertFlex(
            FlexStack(
                size: Size(width: .percent(100), height: .percent(100)),
                flexDirection: .column,
                justifyContent: .center
            ) {
                Color.red.flexStyle(
                    size: Size(width: .percent(100), height: .fixed(10))
                )
                Color.blue.flexStyle(
                    size: Size(width: .percent(100), height: .fixed(40))
                )
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testColumnJustify() {
        let exp = assertFlex(
            FlexStack(
                size: Size(width: .percent(100), height: .percent(100)),
                flexDirection: .column,
                justifyContent: .flexStart
            ) {
                Color.red.flexStyle(
                    size: Size(width: .percent(100), height: .fixed(10))
                )
                Color.blue.flexStyle(
                    size: Size(width: .percent(100), height: .fixed(40))
                )
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testRow() {
        let exp = assertFlex(
            FlexStack(
                size: Size(width: .percent(100), height: .percent(100))
            ) {
                Color.red.flexStyle(
                    size: Size(width: .percent(50), height: .fixed(40))
                )
                
                Color.blue.flexStyle(
                    size: Size(width: .percent(50), height: .auto)
                )
            }
        )

        wait(for: exp, timeout: 1)
    }
}
