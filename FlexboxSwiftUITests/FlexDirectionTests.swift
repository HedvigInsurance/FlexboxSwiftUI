//
//  FlexDirectionTests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import XCTest
@testable import FlexboxSwiftUI
import SwiftUI
import SnapshotTesting

class FlexDirectionTests: XCTestCase {
    func testColumn() {
        let exp = assertFlexView(FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(
                        size: Size(width: .percent(100), height: .fixed(10)),
                        view: AnyView(Color.red)
                    ),
                    Node(
                        size: Size(width: .percent(100), height: .fixed(40)),
                        view: AnyView(Color.blue)
                    )
                ],
                flexDirection: .column,
                justifyContent: .center
            )
        ))
        
        wait(for: [exp], timeout: 1)
    }
    
    func testColumnJustify() {
        let exp = assertFlexView(FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(
                        size: Size(width: .percent(100), height: .fixed(10)),
                        view: AnyView(Color.red)
                    ),
                    Node(
                        size: Size(width: .percent(100), height: .fixed(40)),
                        view: AnyView(Color.blue)
                    )
                ],
                flexDirection: .column,
                justifyContent: .flexStart
            )
        ))
        
        wait(for: [exp], timeout: 1)
    }
    
    func testRow() {
        let exp = assertFlexView(FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(
                        size: Size(width: .percent(50), height: .fixed(40)),
                        view: AnyView(Color.red)
                    ),
                    Node(
                        size: Size(width: .percent(50), height: .auto),
                        view: AnyView(Color.blue)
                    )
                ],
                flexDirection: .row
            )
        ))
        
        wait(for: [exp], timeout: 1)
    }
}
