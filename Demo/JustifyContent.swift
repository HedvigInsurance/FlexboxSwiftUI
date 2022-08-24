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
    @StateObject var store = HostingViewStore(node: Node(
        size: Size(width: .percent(50), height: .auto),
        children: [
            Node(
                size: Size(width: .auto, height: .auto),
                flexGrow: 1,
                view: FlexChild(TestColor(color: .yellow))
            ),
            Node(
                size: Size(width: .auto, height: .auto),
                flexGrow: 1,
                view: FlexChild(ZStack {
                    Button("fisk") {
                        
                    }
                }.background(Color.blue))
            )
        ]
    ))
    
    func updateNode() -> Node {
        var node = store.node
        
        node.children = node.children.map { node in
            var node = node
            
            node.size = Size(width: .auto, height: .percent(CGFloat(Int.random(in: 1..<100))))
            
            return node
        }
        
        return node
    }
    
    var body: some View {
        Button("Modify container size") {
            withAnimation(.spring()) {
                store.node = updateNode()
            }
        }
        
        FlexViewLegacy(
            store: store
        )
        .frame(height: 150, alignment: .topLeading)
        .background(Color.red)
    }
}
