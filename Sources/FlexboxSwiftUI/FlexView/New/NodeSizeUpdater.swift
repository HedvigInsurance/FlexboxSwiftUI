//
//  NodeSizeUpdater.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-29.
//

import Foundation
import SwiftUI
import FlexboxSwiftUIObjC

struct NodeSizeUpdater<Content: View>: View {
    @EnvironmentObject var coordinator: FlexCoordinator
    @EnvironmentObject var nodeChildHolder: NodeChildHolder
    
    var offset: Int
    var content: Content
    
    func dirtieNode(_ proxy: GeometryProxy) -> some View {
        let _ = proxy.size
                                
        if let transaction = nodeChildHolder.transactions[offset] {
            withTransaction(transaction) {
                nodeChildHolder.node.markDirty()
                coordinator.updateLayout()
            }
            
            nodeChildHolder.transactions.removeValue(forKey: offset)
        } else {
            nodeChildHolder.node.markDirty()
            coordinator.updateLayout()
        }
        
        return Color.clear
    }
    
    var body: some View {
        if nodeChildHolder.isLeafNode == true {
            SizeReadable(
                content: content.background(GeometryReader { proxy in
                    dirtieNode(proxy)
                }).transaction { transaction in
                    if transaction.animation != nil {
                        nodeChildHolder.transactions[offset] = transaction
                    }
                }
            ) { measure in
                let node = nodeChildHolder.node
                                                
                node.measure = { suggestedSize, widthMode, heightMode in
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
                                                                    
                    let sizeThatFits = measure(
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
            .opacity(0)
            .position()
            .allowsHitTesting(false)
        }
    }
}
