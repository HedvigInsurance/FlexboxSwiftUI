//
//  RenderBothImplementations.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-23.
//

import Foundation
import SwiftUI
import FlexboxSwiftUI

struct RenderBothImplementations: View {
    var node: Node
    
    var body: some View {
        Text("Legacy")
      
        Text("Layout")
        
        if #available(iOS 16, *) {
            FlexViewLayout(
                node: node
            )
        }
    }
}
