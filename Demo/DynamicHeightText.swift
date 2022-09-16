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
        FlexStack(
            flexibleAxies: [.vertical],
            size: Size(width: .percent(100), height: .auto),
            flexDirection: .column
        ) {
            Text(loremIpsum)
                .padding(10)
                .flexStyle(
                    size: Size(width: .percent(100), height: .auto),
                    flexGrow: 1
                )
            
            Text(loremIpsum)
                .padding(10)
                .flexStyle(
                    size: Size(width: .percent(100), height: .auto),
                    flexGrow: 1
                )
        }
    }
}
