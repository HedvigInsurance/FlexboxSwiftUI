//
//  NodeOffset.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-27.
//

import Foundation

class NodeOffset: Hashable {
    internal init(offset: Int, nodeOffset: NodeOffset? = nil) {
        self.offset = offset
        self.nodeOffset = nodeOffset
    }
    
    static func == (lhs: NodeOffset, rhs: NodeOffset) -> Bool {
        lhs.offset == rhs.offset && lhs.nodeOffset == rhs.nodeOffset
    }
    
    var offset: Int
    var nodeOffset: NodeOffset?
    
    func makeInner(offset: Int) -> NodeOffset {
        NodeOffset(
            offset: offset,
            nodeOffset: NodeOffset(offset: offset)
        )
    }
    
    func findNode(on node: Node) -> Node {
        if let nodeOffset = nodeOffset {
            return nodeOffset.findNode(on: node.children[offset])
        }
        
        return node.children[offset]
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(offset)
        hasher.combine(nodeOffset)
    }
}
