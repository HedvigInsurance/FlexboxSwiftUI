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
    let loremIpsum = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum condimentum eu diam id facilisis. Integer tempus libero nec velit condimentum iaculis.
        """
    
    @State var count = 100
    
    var body: some View {
        Button("Change count") {
            withAnimation(.spring()) {
                count = Int.random(in: 1..<50)
            }
        }
        
        FlexRoot {
            FlexNode(style: FlexStyle(flexDirection: .columnReverse)) {
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
