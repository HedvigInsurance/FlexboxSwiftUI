//
//  DynamicHeightText.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import FlexboxSwiftUI
import Foundation
import SwiftUI

struct DynamicHeightText: View {
    let loremIpsum = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum condimentum eu diam id facilisis. Integer tempus libero nec velit condimentum iaculis.
        """

    var body: some View {
        FlexStack(flexibleAxies: [.vertical]) {
            FlexItem(
                size: Size(width: .percent(100), height: .auto),
                flexDirection: .column

            ) {
                FlexItem(
                    size: Size(width: .percent(100), height: .auto),
                    flexGrow: 1

                ) {
                    Text(loremIpsum)
                        .padding(10)
                }
                FlexItem(
                    size: Size(width: .percent(100), height: .auto),
                    flexGrow: 1

                ) {
                    Text(loremIpsum)
                        .padding(10)
                }
            }
        }
    }
}
