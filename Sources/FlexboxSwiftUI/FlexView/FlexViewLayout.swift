//
//  FlexViewLayout.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-23.
//

import Foundation
import SwiftUI
import FlexboxSwiftUIObjC

@available(iOS 16, *)
class FlexLayoutStackCache: ObservableObject {
    var node: Node
    var _node: NodeImpl
    var subviews: LayoutSubviews? = nil
    var layout: Layout? = nil
    
    func calculate(maxSize: CGSize) {
        _node.children.enumerated().forEach { offset, childNode in
            if node.children[offset].view != nil {
                childNode.measure = { suggestedSize, widthMode, heightMode in
                    let constrainedWidth =
                        widthMode == .undefined
                        ? nil
                        : suggestedSize.width
                    let constrainedHeight =
                        heightMode == .undefined
                        ? nil
                        : suggestedSize.height

                    func sanitize(
                        constrainedSize: CGFloat?,
                        measuredSize: CGFloat,
                        mode: YGMeasureMode
                    )
                        -> CGFloat
                    {
                        if mode == .exactly {
                            return constrainedSize ?? 0
                        } else if mode == .atMost {
                            return min(constrainedSize ?? 0, measuredSize)
                        } else {
                            return measuredSize
                        }
                    }
                    
                    let sizeThatFits = self.subviews?[offset].sizeThatFits(
                        ProposedViewSize(width: constrainedWidth, height: constrainedHeight)
                    ) ?? .zero

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
        
        self.layout = node.layout(node: _node, maxSize: maxSize)
    }
    
    init(node: Node) {
        self.node = node
        self._node = node.createUnderlyingNode()
    }
}

@available(iOS 16, *)
struct FlexLayoutStack: SwiftUI.Layout {
    var node: Node
    var cache: FlexLayoutStackCache
    
    func makeCache(subviews: Subviews) -> FlexLayoutStackCache {
        cache.subviews = subviews
        return cache
    }
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout FlexLayoutStackCache
    ) -> CGSize {
        var maxHeight: CGFloat {
            if node.size.height == .auto || node.size.height == .undefined {
                return .nan
            }
            
            return proposal.height ?? .nan
        }
        
        cache.calculate(
            maxSize: CGSize(
                width: proposal.width ?? .zero,
                height: maxHeight
            )
        )
                
        return cache.layout?.frame.size ?? .zero
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout FlexLayoutStackCache
    ) {
        subviews.enumerated().forEach { offset, subview in
            let layoutFrame = cache.layout?.children[offset].frame ?? .zero
            
            print("[BOUNDS]", bounds.origin)
            print("[LAYOUT FRAME]", layoutFrame.origin)
            
            subview.place(
                at: CGPoint(
                    x: layoutFrame.origin.x + bounds.origin.x,
                    y: layoutFrame.origin.y + bounds.origin.y
                ),
                anchor: .topLeading,
                proposal: ProposedViewSize(layoutFrame.size)
            )            
        }
    }
}

@available(iOS 16, *)
public struct FlexViewLayout: View {
    @Environment(\.markDirty) var parentMarkDirty
    @StateObject var cache: FlexLayoutStackCache
    var node: Node

    public init(
        node: Node
    ) {
        self.node = node
        self._cache = StateObject(wrappedValue: FlexLayoutStackCache(node: node))
    }

    public var body: some View {
        FlexLayoutStack(node: node, cache: cache) {
            ForEach(Array(node.children.enumerated()), id: \.offset) { offset, child in
                if let view = child.view {
                    view.view.environment(\.markDirty) { animation, body in
                        if let parentMarkDirty = parentMarkDirty {
                            parentMarkDirty(animation) { transaction in
                                body(transaction)
                                let childNode = cache._node.children[offset]
                                childNode.markDirty()
                            }
                        } else {
                            let transaction = Transaction(animation: animation)
                            
                            withTransaction(transaction) {
                                body(transaction)
                                let childNode = cache._node.children[offset]
                                childNode.markDirty()
                                self.cache.objectWillChange.send()
                            }
                        }
                    }
                } else {
                    FlexViewLayout(node: child).environment(\.markDirty) { animation, body in
                        if let parentMarkDirty = parentMarkDirty {
                            parentMarkDirty(animation) { transaction in
                                body(transaction)
                                let childNode = cache._node.children[offset]
                                childNode.markDirty()
                            }
                        } else {
                            let transaction = Transaction(animation: animation)
                            
                            withTransaction(transaction) {
                                body(transaction)
                                let childNode = cache._node.children[offset]
                                childNode.markDirty()
                                self.cache.objectWillChange.send()
                            }
                        }
                    }
                }
            }
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}
