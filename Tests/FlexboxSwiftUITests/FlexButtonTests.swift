//
//  FlexButtonTest.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest

@testable import FlexboxSwiftUI

class FlexButtonTests: XCTestCase {
    func testButtonContent() {
        let exp = assertFlex(
            FlexStack(
                size: Size(width: .percent(100), height: .percent(100))
            ) {
                Button(
                    "Some button text",
                    action: {

                    }
                ).flexStyle(
                    flexGrow: 1
                )
                
                Button(
                    "Some other text",
                    action: {

                    }
                ).flexStyle(
                    flexGrow: 1
                )
            }
        )

        wait(for: exp, timeout: 1)
    }
}
