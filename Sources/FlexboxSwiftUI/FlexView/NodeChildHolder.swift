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
    var isLeafNode: Bool = true
    var measuredNodeSize: CGSize? = nil
    var node = NodeImpl()
    var children: [Int: NodeImpl] = [:]
    
    func insertChild(_ offset: Int, node: NodeImpl) {
        children[offset] = node
        updateChildren()
    }
    
    func removeChild(_ offset: Int) {
        if children[offset] != nil {
            children.removeValue(forKey: offset)
            updateChildren()
        }
    }
    
    func updateChildren() {
        if children.count > 0 {
            node.removeMeasureFunc()
        }
        
        node.children = children.sorted { a, b in
            a.key < b.key
        }.map { _, value in
            value
        }
                
        isLeafNode = node.children.count == 0
        self.objectWillChange.send()
    }
}
