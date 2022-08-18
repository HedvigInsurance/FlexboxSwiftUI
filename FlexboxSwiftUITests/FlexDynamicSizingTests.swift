//
//  FlexDynamicSizingTests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import XCTest
@testable import FlexboxSwiftUI
import StretchKit
import SwiftUI
import SnapshotTesting
import ViewInspector

class FlexDynamicSizingTests: XCTestCase {
    let loremIpsum = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum condimentum eu diam id facilisis. Integer tempus libero nec velit condimentum iaculis. Pellentesque aliquam quam suscipit urna tincidunt egestas. Fusce vitae justo eget est cursus fermentum eget ac turpis. Etiam ut est sed ante consequat aliquam. Etiam ac porta eros. Etiam placerat, mauris nec sagittis tempor, mi enim ornare dolor, in lobortis urna tortor id leo.

    Nunc ligula nisi, gravida ac aliquam quis, blandit at lacus. Nunc posuere, mauris eu viverra eleifend, neque eros pellentesque nibh, non imperdiet ante diam nec ante. Proin a lectus mollis, pellentesque nisl in, feugiat tortor. Nulla luctus facilisis ligula a venenatis. Nullam quis consectetur turpis. Phasellus id elementum nisi. Morbi quis purus porttitor, bibendum justo sit amet, cursus arcu. Nullam porttitor odio in quam suscipit, eget cursus magna egestas. Suspendisse sed sem eget nunc mattis maximus. Morbi interdum, purus id laoreet pharetra, enim lectus ornare lorem, id dignissim orci ipsum eget tellus.
    """
    
    func testDynamicHeight() {
        let view = FlexView(
            style: Style(flexDirection: .column, size: Size(width: .percent(1), height: .auto)),
            children: [
                (
                    Style(
                        flexGrow: 1,
                        size: Size(width: .percent(1), height: .auto)
                    ),
                    AnyView(Text(loremIpsum))
                )
            ]
        )
                
        let vc = UIHostingController(rootView: view)
        
        let exp = expectation(description: "Wait for screen")
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.rootViewController?.view.translatesAutoresizingMaskIntoConstraints = false
        window.makeKeyAndVisible()
        window.layoutIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            assertSnapshot(matching: vc, as: .image)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2)
    }
}
