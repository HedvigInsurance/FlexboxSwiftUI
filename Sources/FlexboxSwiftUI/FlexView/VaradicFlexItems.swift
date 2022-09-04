//
//  VaradicFlexNodes.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import SwiftUI

struct VaradicFlexItems: _VariadicView_UnaryViewRoot {
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
                    
                    child.modifier(
                        LayoutViewModifier(
                            offset: offset
                        )
                    )
                }
                .onPreferenceChange(NodeImplPreferenceKey.self) { subNode in
                    if let subNode = subNode {
                        nodeChildHolder.insertChild(
                            offset,
                            node: subNode
                        )
                    }
                }
            }
        }.onChange(of: children.count) { childCount in
            if children.count > childCount,
               nodeChildHolder.children.count > childCount {
                let numberOfChildrenToRemove = nodeChildHolder.children.count - childCount

                for i in 0..<numberOfChildrenToRemove {
                    nodeChildHolder.removeChild(childCount - i)
                }
                
                nodeChildHolder.updateChildren()
            }
        }
    }
}
