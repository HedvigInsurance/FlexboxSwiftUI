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
            ForEach(children, id: \.id) { child in
                let offset = children.firstIndex { element in
                    element.id == child.id
                }!
                
                ZStack(alignment: .topLeading) {
                    NodeSizeUpdater(
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
                }.onDisappear {
                    nodeChildHolder.removeChild(offset)
                }
            }
        }
    }
}
