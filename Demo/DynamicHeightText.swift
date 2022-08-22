//
//  DynamicHeightText.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import Foundation
import FlexboxSwiftUI
import SwiftUI

struct DynamicHeightText: View {
    let loremIpsum = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum condimentum eu diam id facilisis. Integer tempus libero nec velit condimentum iaculis.
        """

    var body: some View {
        FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .auto),
                children: [
                    Node(
                        size: Size(width: .percent(100), height: .auto),
                        flexGrow: 1,
                        view: FlexChild(
                            Text(loremIpsum)
                                .padding(10)
                        )
                    ),
                    Node(
                        size: Size(width: .percent(100), height: .auto),
                        flexGrow: 1,
                        view: FlexChild(
                            Text(loremIpsum)
                                .padding(10)
                        )
                    )
                ],
                flexDirection: .column
            )
        )
    }
}
