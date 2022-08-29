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

    public init(
        node: Node
    ) {
        self.node = node
    }

    public var body: some View {
        if #available(iOS 16, *) {
            FlexViewLayout(node: node)
        } else {
            //FlexViewLegacy(node: node)
        }
    }
}
