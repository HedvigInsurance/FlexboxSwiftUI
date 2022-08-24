//
//  ViewSizeCalculator.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-19.
//

import Foundation
import SwiftUI
import FlexboxSwiftUIObjC

public class HostingViewStore: ObservableObject {
    public var node: Node {
        didSet {
            updateNode()
        }
    }
    var _node: NodeImpl
    var views: [FlexChild: AdjustableHostingController] = [:]
    var layout: FlexLayout? = nil

    var maxSize: CGSize? = nil {
        didSet {
            node.markAllDirty(self._node)
            updateLayout()
        }
    }
    
    func updateNode() {
        node.applyTo(node: _node)
        applyMeasureFuncs()
        node.markAllDirty(_node)
        updateLayout()
    }
    
    public init(node: Node) {
        self.node = node
        self.maxSize = nil
        
        let _node = NodeImpl()
        self._node = _node
        
        updateNode()
    }
    
    func updateLayout() {
        if let maxSize = maxSize {
            let previousLayout = self.layout
            
            self.layout = node.layout(
                node: _node,
                maxSize: maxSize
            )
            
            if previousLayout != self.layout {
                self.objectWillChange.send()
            }
        }
    }

    func applyMeasureFuncs() {
        _node.children
            .enumerated()
            .forEach { offset, nodeChild in
                if let flexChild = node.children[offset].view {
                    let hostingView = self.add(flexChild, node: nodeChild)

                    nodeChild.measure = { suggestedSize, widthMode, heightMode in
                        let constrainedWidth =
                            widthMode == .undefined
                            ? UIView.layoutFittingExpandedSize.width
                            : suggestedSize.width
                        let constrainedHeight =
                            heightMode == .undefined
                            ? UIView.layoutFittingExpandedSize.height
                            : suggestedSize.height

                        func sanitize(
                            constrainedSize: CGFloat,
                            measuredSize: CGFloat,
                            mode: YGMeasureMode
                        )
                            -> CGFloat
                        {
                            if mode == .exactly {
                                return constrainedSize
                            } else if mode == .atMost {
                                return min(constrainedSize, measuredSize)
                            } else {
                                return measuredSize
                            }
                        }
                        
                        hostingView.view.invalidateIntrinsicContentSize()
                        let sizeThatFits = hostingView.view.systemLayoutSizeFitting(
                            CGSize(width: constrainedWidth, height: constrainedHeight)
                        )

                        let result = CGSize(
                            width: sanitize(
                                constrainedSize: constrainedWidth,
                                measuredSize: sizeThatFits.width,
                                mode: widthMode
                            ),
                            height: sanitize(
                                constrainedSize: constrainedHeight,
                                measuredSize: sizeThatFits.height,
                                mode: heightMode
                            )
                        )
                        
                        return result
                    }
                }
        }
    }

    func add(_ child: FlexChild, node: NodeImpl) -> AdjustableHostingController {
        if let previousController = views[child] {
            return previousController
        }
        
        let hostingView = AdjustableHostingController(
            rootView: AnyView(child.view),
            store: self,
            node: node
        )
        views[child] = hostingView

        return hostingView
    }
}
