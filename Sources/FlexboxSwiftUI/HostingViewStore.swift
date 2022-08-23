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
    var node: Node {
        didSet {
            _node = node.createUnderlyingNode()
        }
    }
    var _node: NodeImpl? = nil {
        didSet {
            applyMeasureFuncs()
        }
    }
    var views: [FlexChild: AdjustableHostingController] = [:]
    var layout: Layout? = nil

    var maxSize: CGSize? = nil
    var screenMaxWidth: CGFloat = UIScreen.main.bounds.width
    
    init(node: Node) {
        self.node = node
    }

    func setMaxSize(_ size: CGSize?) {
        if size != self.maxSize {
            self.maxSize = size
            
            _node?.children.forEach({ node in
                node.markDirty()
            })
            
            forceUpdate()
        }
    }
    
    func calculateLayout() -> Layout? {
        if let maxSize = maxSize {
            return node.layout(
                node: _node!,
                maxSize: CGSize(
                    width: maxSize.width == 0 ? .nan : min(maxSize.width, screenMaxWidth),
                    height: node.size.height == .auto || node.size.height == .undefined ? .nan : maxSize.height
                )
            )
        } else {
            return nil
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
                        
                        print(result)

                        return result
                    }
                }
        }
    }

    func add(_ child: FlexChild, node: NodeImpl) -> AdjustableHostingController {
        let hostingView = AdjustableHostingController(
            rootView: AnyView(child.view),
            store: self,
            node: node
        )
        hostingView._disableSafeArea = true
        views[child] = hostingView

        return hostingView
    }
}
