//
//  FlexJustifyContentTests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import XCTest
@testable import FlexboxSwiftUI
import SwiftUI
import SnapshotTesting

class FlexJustifyContentTests: XCTestCase {    
    func testCenter() {
        let exp = assertFlexView(FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(
                        size: Size(width: .percent(20), height: .percent(100)),
                        view: FlexChild(Color.red)
                    )
                ],
                justifyContent: .center
            )
        ))
        
        wait(for: [exp], timeout: 1)
    }

    func testStart() {
        let exp = assertFlexView(FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(
                        size: Size(width: .percent(20), height: .percent(100)),
                        view: FlexChild(Color.red)
                    )
                ],
                justifyContent: .flexStart
            )
        ))
        
        wait(for: [exp], timeout: 1)
    }

    func testEnd() {
        let exp = assertFlexView(FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(
                        size: Size(width: .percent(20), height: .percent(100)),
                        view: FlexChild(Color.red)
                    )
                ],
                justifyContent: .flexEnd
            )
        ))
        
        wait(for: [exp], timeout: 1)
    }
}
