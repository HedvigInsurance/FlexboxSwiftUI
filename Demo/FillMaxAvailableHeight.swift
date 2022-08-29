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
    
    var body: some View {
        
        FlexRoot {
            FlexNode(style: FlexStyle(flexDirection: .column)) {
                ForEach(Array(Array(repeating: "", count: 10).enumerated()), id: \.offset) { offset, _ in
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
