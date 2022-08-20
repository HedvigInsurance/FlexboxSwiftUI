//
//  FlexMarginTests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest

@testable import FlexboxSwiftUI

class FlexMarginTests: XCTestCase {
    func testMargins() {
        let exp = assertFlexView(
            FlexView(
                node: Node(
                    size: Size(width: .percent(100), height: .percent(100)),
                    children: [
                        Node(
                            size: Size(width: .auto, height: .fixed(1)),
                            flexGrow: 1,
                            margin: Edges(
                                leading: .undefined,
                                trailing: .fixed(10),
                                top: .fixed(10),
                                bottom: .fixed(10)
                            ),
                            view: FlexChild(Color.red)
                        ),
                        Node(
                            size: Size(width: .auto, height: .fixed(1)),
                            flexGrow: 1,
                            view: FlexChild(Color.blue)
                        ),
                    ],
                    flexDirection: .column
                )
            )
        )

        wait(for: [exp], timeout: 1)
    }
}
