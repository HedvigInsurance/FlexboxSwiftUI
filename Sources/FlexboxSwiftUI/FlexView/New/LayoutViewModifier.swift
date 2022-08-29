//
//  LayoutViewModifier.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import SwiftUI

struct LayoutViewModifier: ViewModifier {
    @EnvironmentObject var coordinator: FlexCoordinator
    @EnvironmentObject var nodeChildHolder: NodeChildHolder
    var offset: Int

    func body(content: Content) -> some View {
        if let node = nodeChildHolder.children[offset],
           let layout = coordinator.layoutForNode(node) {
            content
            .padding(.leading, layout.padding.left)
            .padding(.trailing, layout.padding.right)
            .padding(.top, layout.padding.top)
            .padding(.bottom, layout.padding.bottom)
            .frame(
                width: layout.frame.width,
                height: layout.frame.height,
                alignment: .topLeading
            )
            .alignmentGuide(.top) { d in
                return layout.frame.origin.y
            }
            .alignmentGuide(.leading) { d in
                return layout.frame.origin.x
            }
        } else {
            content
        }
    }
}
