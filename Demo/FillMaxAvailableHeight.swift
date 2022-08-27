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
        FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .percent(50)),
                children: [
                    Node(
                        size: Size(width: .auto, height: .auto),
                        flexGrow: 1,
                        view: AnyView(Color.blue)
                    )
                ]
            )
        )
        .frame(height: 200)
        .background(Color.yellow)
    }
}
