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
    var node: Node? = nil {
        didSet {
            _node = node?.createUnderlyingNode()
            forceUpdate()
        }
    }
    var _node: NodeImpl? = nil {
        didSet {
            applyMeasureFuncs()
        }
    }
    var views: [NodeOffset: AdjustableHostingController] = [:]
    var layout: Layout? = nil
    
    var maxSize: CGSize? = nil
    
    init() {
        
    }
    
    func markNodeDirty(offset: NodeOffset) {
        if let _node = _node {
            offset.findNode(on: _node).markDirty()
        }
    }

    func setMaxSize(_ size: CGSize?) {
        if size != self.maxSize {
            self.maxSize = size
            
            forceUpdate()
        }
    }
    
    func calculateLayout() -> Layout? {
        if let maxSize = maxSize {
            return node?.layout(
                node: _node!,
                maxSize: CGSize(
                    width: maxSize.width == 0 ? .nan : maxSize.width,
                    height: node?.size.height == .auto || node?.size.height == .undefined ? .nan : maxSize.height
                )
            )
        } else {
            return node?.layout(node: _node!)
        }
    }

    public func forceUpdate() {
        let previousLayout = self.layout
        
        self.layout = calculateLayout()
        
        if previousLayout != self.layout {
            self.objectWillChange.send()
        }
    }
    
    func applyMeasureFuncs() {
        _node?.children
            .enumerated()
            .forEach { offset, nodeChild in
                if let view = node?.children[offset].view {
                    let hostingView = self.add(
                        offset: NodeOffset(offset: offset),
                        node: nodeChild,
                        view: view
                    )

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
                                                                        
                        let sizeThatFits = hostingView.measure(
                            targetSize: CGSize(width: constrainedWidth, height: constrainedHeight)
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

    func add(
        offset: NodeOffset,
        node: NodeImpl,
        view: AnyView
    ) -> AdjustableHostingController {
        if let hostingController = views[offset] {
            return hostingController
        }
        
        let hostingController = AdjustableHostingController(
            rootView: view,
            store: self,
            node: node
        )
        views[offset] = hostingController

        return hostingController
    }
}
