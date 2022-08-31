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
            FlexStack {
                FlexItem(
                    style: FlexStyle(
                        size: Size(width: .percent(100), height: .percent(100)),
                        flexDirection: .column,
                        justifyContent: .center
                    )
                ) {
                    FlexItem(
                        style: FlexStyle(
                            size: Size(width: .percent(100), height: .fixed(10))
                        )
                    ) {
                        TestColor(color: .red)
                    }
                    FlexItem(
                        style: FlexStyle(
                            size: Size(width: .percent(100), height: .fixed(40))
                        )
                    ) {
                        TestColor(color: .blue)
                    }
                }
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testColumnJustify() {
        let exp = assertFlex(
            FlexStack {
                FlexItem(
                    style: FlexStyle(
                        size: Size(width: .percent(100), height: .percent(100)),
                        flexDirection: .column,
                        justifyContent: .flexStart
                    )
                ) {
                    FlexItem(
                        style: FlexStyle(
                            size: Size(width: .percent(100), height: .fixed(10))
                        )
                    ) {
                        TestColor(color: .red)
                    }
                    FlexItem(
                        style: FlexStyle(
                            size: Size(width: .percent(100), height: .fixed(40))
                        )
                    ) {
                        TestColor(color: .blue)
                    }
                }
            }
        )

        wait(for: exp, timeout: 1)
    }

    func testRow() {
        let exp = assertFlex(
            FlexStack {
                FlexItem(
                        size: Size(width: .percent(100), height: .percent(100))
                    
                ) {
                    FlexItem(
                            size: Size(width: .percent(50), height: .fixed(40))
                        
                    ) {
                        TestColor(color: .red)
                    }
                    FlexItem(
                            size: Size(width: .percent(50), height: .auto)
                        
                    ) {
                        TestColor(color: .blue)
                    }
                }
            }
        )

        wait(for: exp, timeout: 1)
    }
}
