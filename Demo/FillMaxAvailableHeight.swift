//
//  FillMaxAvailableHeight.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import Foundation
import FlexboxSwiftUI
import SwiftUI

struct FillMaxAvailableHeight: View {
    var body: some View {
        ForEach(Array(Array(repeating: "", count: 100).enumerated()), id: \.offset) { _, _ in
            FlexRoot {
                FlexNode(style: FlexStyle(flexDirection: .row)) {
                    FlexNode(style: FlexStyle(size: .init(width: .percent(50), height: .auto))) {
                        ViewThatChangesHeight()
                    }
                    FlexNode(style: FlexStyle(size: .init(width: .percent(50), height: .auto))) {
                        ViewThatChangesHeight()
                    }
                }
            }
        }
    }
}
