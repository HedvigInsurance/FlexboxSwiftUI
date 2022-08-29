//
//  VaradicFlexNodes.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import SwiftUI
import FlexboxSwiftUIObjC

struct NodeImplPreferenceKey: PreferenceKey {
    static var defaultValue: NodeImpl? = nil

    static func reduce(value: inout NodeImpl?, nextValue: () -> NodeImpl?) {
       value = nextValue()
    }
}

struct VaradicFlexNodes: _VariadicView_UnaryViewRoot {
    var coordinator: FlexCoordinator
    var nodeChildHolder: NodeChildHolder
    
    @ViewBuilder
    func body(children: _VariadicView.Children) -> some View {
        ZStack(alignment: .topLeading) {
            ForEach(Array(children.enumerated()), id: \.offset) { offset, child in
                ZStack(alignment: .topLeading) {
                    NodeSizeUpdater(
                        offset: offset,
                        content: child
                    )
                    
                    child
                }
                .modifier(
                    LayoutViewModifier(
                        offset: offset
                    )
                )
                .onPreferenceChange(NodeImplPreferenceKey.self) { subNode in
                    if let subNode = subNode {
                        nodeChildHolder.insertChild(
                            offset,
                            node: subNode
                        )
                    }
                }.onAppear {
                    nodeChildHolder.updateChildren()
                }
            }
        }
    }
}
