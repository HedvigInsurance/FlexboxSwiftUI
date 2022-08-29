//
//  NodeChildHolder.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-29.
//

import Foundation
import FlexboxSwiftUIObjC
import SwiftUI

class NodeChildHolder: ObservableObject {
    var isLeafNode: Bool? = nil
    var node = NodeImpl()
    var children: [Int: NodeImpl] = [:]
    var transactions: [Int: Transaction] = [:]
    
    func insertChild(_ offset: Int, node: NodeImpl) {
        children[offset] = node
    }
    
    func updateChildren() {
        node.children = children.sorted { a, b in
            a.key > b.key
        }.map { _, value in
            value
        }
                
        isLeafNode = node.children.count == 0
        
        self.objectWillChange.send()
    }
}
