//
//  LayoutViewModifier.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import SwiftUI

extension VerticalAlignment {
    struct FlexRootTop: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let flexRootTop = VerticalAlignment(FlexRootTop.self)
}

extension CGFloat {
    func replaceNan(with value: CGFloat) -> CGFloat {
        isNaN ? value : self
    }
}

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
                width: layout.frame.width.replaceNan(with: 0),
                height: layout.frame.height.replaceNan(with: 0),
                alignment: .topLeading
            )
            .offset(
                x: layout.frame.origin.x,
                y: layout.frame.origin.y
            )
        } else {
            content
        }
    }
}
