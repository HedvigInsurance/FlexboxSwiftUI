//
//  FlexButtonTest.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import XCTest
@testable import FlexboxSwiftUI
import SwiftUI
import SnapshotTesting

class FlexButtonTests: XCTestCase {
    func testButtonContent() {
        let exp = assertFlexView(FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(
                        flexGrow: 1,
                        view: AnyView(Button("Some button text", action: {
                            
                        }))
                    ),
                    Node(
                        flexGrow: 1,
                        view: AnyView(Button("Some other text", action: {
                            
                        }))
                    ),
                ]
            )
        ))
        
        wait(for: [exp], timeout: 1)
    }
}
