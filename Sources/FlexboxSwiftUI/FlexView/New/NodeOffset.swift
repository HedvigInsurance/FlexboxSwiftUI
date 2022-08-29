//
//  NodeOffset.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-27.
//

import Foundation
import FlexboxSwiftUIObjC

class NodeOffset: Hashable, ObservableObject {
    internal init(offset: Int?, nodeOffset: NodeOffset? = nil) {
        self.offset = offset
        self.nodeOffset = nodeOffset
    }
    
    static func == (lhs: NodeOffset, rhs: NodeOffset) -> Bool {
        lhs.offset == rhs.offset && lhs.nodeOffset == rhs.nodeOffset
    }
    
    var offset: Int?
    var nodeOffset: NodeOffset?
    
    func makeInner(offset: Int) -> NodeOffset {
        if self.offset == nil {
            return NodeOffset(
                offset: offset,
                nodeOffset: nil
            )
        } else {
            return NodeOffset(
                offset: offset,
                nodeOffset: NodeOffset(offset: offset)
            )
        }
    }
    
    func findLayout(on layout: Layout?) -> Layout? {
        guard let layout = layout, let offset = offset else {
            return layout
        }
        
        if !layout.children.indices.contains(offset) {
            return nil
        }
        
        if let nodeOffset = nodeOffset {
            return nodeOffset.findLayout(on: layout.children[offset])
        }
        
        return layout.children[offset]
    }
    
    func findNode(on node: NodeImpl) -> NodeImpl? {
        guard let offset = offset else {
            return nil
        }
        
        if !node.children.indices.contains(offset) {
            return nil
        }
        
        if let nodeOffset = nodeOffset {
            return nodeOffset.findNode(on: node.children[offset])
        }
        
        return node.children[offset]
    }
    
    func fillEmptyNodes(into rootNode: NodeImpl) {
        guard let offset = offset else {
            return
        }
        
        if let nodeOffset = nodeOffset {
            if rootNode.children.indices.contains(offset) {
                nodeOffset.fillEmptyNodes(into: rootNode.children[offset])
            } else {
                let amountToInsert = offset - rootNode.children.endIndex
                rootNode.children.reserveCapacity(offset)
                                
                if amountToInsert > 0 {
                    Array(repeating: "", count: amountToInsert).forEach { _ in
                        rootNode.children.append(NodeImpl())
                    }
                }
            }
        } else {
            let amountToInsert = offset - rootNode.children.endIndex
            rootNode.children.reserveCapacity(offset)
                        
            if amountToInsert > 0 {
                Array(repeating: "", count: amountToInsert).forEach { _ in
                    rootNode.children.append(NodeImpl())
                }
            }
        }
    }
    
    func insert(_ node: NodeImpl, into rootNode: NodeImpl) {
        guard let offset = offset else {
            return
        }
        
        if let nodeOffset = nodeOffset {
            return nodeOffset.insert(node, into: rootNode.children[offset])
        }
        
        if !rootNode.children.indices.contains(offset) {
            rootNode.children.reserveCapacity(offset)
            
            if rootNode.children.endIndex == offset {
                rootNode.children.append(node)
            }
        } else {
            rootNode.children.insert(node, at: offset)
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(offset)
        hasher.combine(nodeOffset)
    }
}
