//
//  FlexCoordinator.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import FlexboxSwiftUIObjC
import SwiftUI
import Combine

extension NodeImpl {
    func observeIsDirty() -> AnyPublisher<Void, Never> {
        return self.publisher(for: \.isDirty)
            .compactMap { isDirty in
                isDirty ? () : nil
            }
            .eraseToAnyPublisher()
    }
    
    func observeAllChildren() -> AnyPublisher<Void, Never> {
        self.publisher(for: \.children)
            .flatMap { children in
                Publishers.MergeMany(
                    children.map { node in
                        Publishers.Merge(
                            node.observeAllChildren(),
                            node.observeIsDirty()
                        )
                    }
                )
            }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}

class FlexCoordinator: ObservableObject {
    var rootTransaction = Transaction()
    var rootNode: NodeImpl? = nil
    var flexibleAxies: [Axis]? = nil
    var layout: Layout?
    var readMaxSize: () -> CGSize = { .zero }
    
    lazy var nodeObserver: AnyPublisher<Void, Never> = {
        self.objectWillChange
            .compactMap { _ in
                self.rootNode
            }
            .flatMap { rootNode in
                Publishers.Merge(
                    rootNode.observeAllChildren(),
                    rootNode.observeIsDirty()
                )
            }
            .eraseToAnyPublisher()
    }()
    
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
        guard let rootNode = rootNode, let flexibleAxies = flexibleAxies else {
            return
        }
        
        let maxSize = readMaxSize()

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
