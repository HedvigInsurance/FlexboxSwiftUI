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
        FlexRoot(flexibleAxies: [.vertical]) {
            FlexNode(
                style: FlexStyle(
                    size: Size(width: .percent(100), height: .auto),
                    flexDirection: .column
                )
            ) {
                FlexNode(
                    style: FlexStyle(
                        size: Size(width: .percent(100), height: .auto),
                        flexGrow: 1
                    )
                ) {
                    Text(loremIpsum)
                        .padding(10)
                }
                FlexNode(
                    style: FlexStyle(
                        size: Size(width: .percent(100), height: .auto),
                        flexGrow: 1
                    )
                ) {
                    Text(loremIpsum)
                        .padding(10)
                }
            }
        }
    }
}
