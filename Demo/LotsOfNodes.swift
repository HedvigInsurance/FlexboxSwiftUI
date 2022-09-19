//
//  LotsOfNodes.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import FlexboxSwiftUI
import Foundation
import SwiftUI

struct LotsOfNodes: View {
    let loremIpsum = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum condimentum eu diam id facilisis. Integer tempus libero nec velit condimentum iaculis.
        """

    @State var count = 10

    var body: some View {
        Button("Change count") {
            count = Int.random(in: 1..<50)
        }

        FlexStack(
            flexibleAxies: [.vertical],
            size: Size(width: .auto, height: .undefined),
            flexDirection: .column
        ) {
            ForEach(Array(Array(repeating: "", count: count).enumerated()), id: \.offset) { offset, _ in
                ViewThatChangesHeight(offset: offset)
                    .flexStyle(size: .init(width: .percent(50), height: .auto))
                Text(loremIpsum)
                    .fixedSize(horizontal: false, vertical: true)
                    .flexStyle(size: .init(width: .percent(50), height: .auto))
            }
        }
    }
}
