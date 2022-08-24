//
//  FlexView.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-23.
//

import Foundation
import SwiftUI

public struct FlexView: View {
    var node: Node
    var maxSize: CGSize

    public init(
        node: Node,
        maxSize: CGSize = CGSize(width: Double.infinity, height: Double.infinity)
    ) {
        self.node = node
        self.maxSize = maxSize
    }

    public var body: some View {
        if #available(iOS 16, *) {
            FlexViewLayout(node: node, maxSize: maxSize)
        } else {
            //FlexViewLegacy(node: )
        }
    }
}
