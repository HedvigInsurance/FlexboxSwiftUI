//
//  JustifyContent.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import Foundation
import SwiftUI
import FlexboxSwiftUI

struct JustifyContent: View {
    var body: some View {
        FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .auto),
                children: [
                    Node(
                        size: Size(width: .percent(100), height: .fixed(10)),
                        view: FlexChild(Color.red)
                    ),
                    Node(
                        size: Size(width: .percent(100), height: .fixed(40)),
                        view: FlexChild(Color.blue)
                    ),
                ],
                flexDirection: .column,
                justifyContent: .center
            )
        )
    }
}
