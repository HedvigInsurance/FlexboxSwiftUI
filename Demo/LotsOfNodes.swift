//
//  LotsOfNodes.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import Foundation
import FlexboxSwiftUI
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
        
        FlexRoot(flexibleAxies: [.vertical]) {
            FlexNode(style: FlexStyle(
                size: Size(width: .auto, height: .undefined),
                flexDirection: .column
            )) {
                ForEach(Array(Array(repeating: "", count: count).enumerated()), id: \.offset) { offset, _ in
                    FlexNode(style: FlexStyle(size: .init(width: .percent(50), height: .auto))) {
                        ViewThatChangesHeight(offset: offset)
                    }
                    FlexNode(style: FlexStyle(size: .init(width: .percent(50), height: .auto))) {
                        Text(loremIpsum)
                    }
                }
            }
        }
    }
}