//
//  FlexCoordinator.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import FlexboxSwiftUIObjC
import SwiftUI

class FlexCoordinator: ObservableObject {
    var rootTransaction = Transaction()
    var rootNode: NodeImpl? = nil
    var flexibleAxies: [Axis]? = nil
    var layout: Layout?
    var maxSize: CGSize?
    
    func layoutForNode(_ nodeImpl: NodeImpl) -> Layout? {
        guard layout != nil else {
            return nil
        }
        
        return layoutFromNode(nodeImpl)
    }
    
    private func layoutFromNode(_ nodeImpl: NodeImpl) -> Layout {
        func createLayoutsFromChildren(_ nodeImpl: NodeImpl) -> [Layout] {
            return nodeImpl.children.enumerated()
                .map { offset, childNode in
                    return Layout(
                        frame: childNode.frame,
                        padding: childNode.padding,
                        children: createLayoutsFromChildren(childNode)
                    )
                }
        }
        
        let children = createLayoutsFromChildren(nodeImpl)
        
        return Layout(frame: nodeImpl.frame, padding: nodeImpl.padding, children: children)
    }

    func updateLayout() {
        guard let maxSize = maxSize, let rootNode = rootNode, let flexibleAxies = flexibleAxies else {
            return
        }
      
        rootNode.layout(
            withMaxSize: CGSize(
                width: flexibleAxies.contains(.horizontal) ? .nan : maxSize.width,
                height: flexibleAxies.contains(.vertical) ? .nan : maxSize.height
            )
        )
                
        let newLayout = layoutFromNode(rootNode)
        
        if self.layout != newLayout {
            self.layout = newLayout
            self.objectWillChange.send()
        }
    }
}
