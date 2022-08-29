//
//  FlexNode.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import SwiftUI
import FlexboxSwiftUIObjC

public struct FlexNode<Content: View>: View {
    @EnvironmentObject var coordinator: FlexCoordinator
    @StateObject var nodeChildHolder = NodeChildHolder()
    
    var content: () -> Content
    var style: FlexStyle
   
    public init(
        style: FlexStyle,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.style = style
        self.content = content
    }
    
    public var body: some View {
        style.updateNodeImpl(nodeChildHolder.node)
        
        return _VariadicView.Tree(VaradicFlexNodes(
            coordinator: coordinator,
            nodeChildHolder: nodeChildHolder
        )) {
            content()
        }
        .preference(key: NodeImplPreferenceKey.self, value: nodeChildHolder.node)
        .environmentObject(nodeChildHolder)
    }
}
