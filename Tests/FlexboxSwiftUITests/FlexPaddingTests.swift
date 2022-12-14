//
//  FlexPaddingTests.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest

@testable import FlexboxSwiftUI

class FlexPaddingTests: XCTestCase {
    func testPadding() {
        let exp = assertFlex(
            FlexStack(
                size: Size(width: .percent(100), height: .percent(100)),
                flexDirection: .row
            ) {
                Text("Padding")
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .flexStyle(
                    size: Size(width: .fixed(1), height: .auto),
                    flexGrow: 1,
                    padding: Edges(
                        leading: .fixed(50),
                        trailing: .fixed(50),
                        top: .auto,
                        bottom: .auto
                    )
                )
                    
                Text("Padding")
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .flexStyle(
                    size: Size(width: .fixed(1), height: .auto),
                    flexGrow: 1,
                    padding: Edges(
                        leading: .fixed(50),
                        trailing: .auto,
                        top: .auto,
                        bottom: .auto
                    )
                )
                
            }
        )

        wait(for: exp, timeout: 1)
    }
}
