//
//  FlexStack.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-09-16.
//

import Foundation
import SwiftUI
import FlexboxSwiftUIObjC
import Placement

public struct FlexStack: PlacementLayout, FlexStyle {
    public var flexibleAxies: [Axis]
    public var size: Size
    public var minSize: Size
    public var maxSize: Size

    /// Specifies how flex-items are placed in the flex-container (defining the main-axis).
    /// - Note: Applies to flex-container.
    public var flexDirection: Style.FlexDirection

    /// Specifies whether flex items are forced into a single line
    /// or can be wrapped onto multiple lines.
    /// - Note: Applies to flex-container.
    public var flexWrap: Style.FlexWrap

    /// Distributes space between and around flex-items along the main-axis.
    /// - Note: Applies to flex-container.
    public var justifyContent: Style.JustifyContent

    /// Distributes space between and around flex-items along the cross-axis.
    /// This works like `justifyContent` but in the perpendicular direction.
    /// - Note: Applies to flex-container.
    public var alignItems: Style.AlignItems

    /// Aligns a flex-container's lines when there is extra space on the cross-axis.
    /// - Warning: This property has no effect on single line.
    /// - Note: Applies to multi-line flex-container (no `FlexWrap.nowrap`).
    public var alignContent: Style.AlignContent

    /// Aligns self (flex-item) by overriding it's parent's (flex-container) `alignItems`.
    /// - Note: Applies to flex-item.
    public var alignSelf: Style.AlignSelf

    /// Shorthand property specifying the ability of a flex-item
    /// to alter its dimensions to fill available space.
    /// - Note: Applies to flex-item.
    public var flex: CGFloat

    /// Grow factor of a flex-item.
    /// - Note: Applies to flex-item.
    public var flexGrow: CGFloat

    /// Shrink factor of a flex-item.
    /// - Note: Applies to flex-item.
    public var flexShrink: CGFloat

    /// Initial main size of a flex item.
    /// - Note: Applies to flex-item.
    public var flexBasis: CGFloat

    public var direction: Style.Direction
    public var overflow: Style.Overflow
    public var positionType: Style.PositionType

    /// CSS's (top, right, bottom, left) that works with `positionType = .absolute`.
    public var position: Edges

    public var margin: Edges
    public var padding: Edges

    /// facebook/yoga implementation that mostly works as same as `padding`.
    public var border: Edges

    /// - Note: See `gYGNodeDefaults.style`.
    public init(
        flexibleAxies: [Axis] = [],
        
        size: Size = Size(width: .auto, height: .auto),
        minSize: Size = Size(width: .auto, height: .auto),
        maxSize: Size = Size(width: .auto, height: .auto),

        flexDirection: Style.FlexDirection = .row,
        flexWrap: Style.FlexWrap = .nowrap,
        justifyContent: Style.JustifyContent = .flexStart,
        alignItems: Style.AlignItems = .stretch,
        alignContent: Style.AlignContent = .stretch,
        alignSelf: Style.AlignSelf = .auto,

        flex: CGFloat = .nan,  // CSS default = 0
        flexGrow: CGFloat = .nan,  // CSS default = 0
        flexShrink: CGFloat = .nan,  // CSS default = 1
        flexBasis: CGFloat = .nan,  // CSS default = .auto

        direction: Style.Direction = .inherit,
        overflow: Style.Overflow = .visible,
        positionType: Style.PositionType = .relative,

        position: Edges = .undefined,
        margin: Edges = .undefined,
        padding: Edges = .undefined,
        border: Edges = .undefined
    ) {
        self.flexibleAxies = flexibleAxies
        
        self.size = size
        self.minSize = minSize
        self.maxSize = maxSize

        self.flexDirection = flexDirection
        self.flexWrap = flexWrap
        self.justifyContent = justifyContent
        self.alignItems = alignItems
        self.alignContent = alignContent
        self.alignSelf = alignSelf

        self.flex = flex
        self.flexGrow = flexGrow
        self.flexShrink = flexShrink
        self.flexBasis = flexBasis

        self.direction = direction
        self.overflow = overflow
        self.positionType = positionType

        self.position = position
        self.margin = margin
        self.padding = padding
        self.border = border
    }
    
    public struct Cache {
        let rootNode = NodeImpl()
    }
    
    func updateNodes(_ cache: Cache, subviews: Subviews) {
        updateNodeImpl(cache.rootNode)
                
        cache.rootNode.children = subviews.map { subview in
            let node = NodeImpl()
            
            let style = subview[FlexStylePlacementLayoutValueKey.self]
            style.updateNodeImpl(node)
            
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
                ) -> CGFloat {
                    if mode == .exactly {
                        return constrainedSize
                    } else if mode == .atMost {
                        return min(constrainedSize, measuredSize)
                    } else {
                        return measuredSize
                    }
                }
                
                let sizeThatFits = subview.sizeThatFits(
                    PlacementProposedViewSize(CGSize(width: constrainedWidth, height: constrainedHeight))
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
            
            return node
        }
    }
    
    public func updateCache(_ cache: inout Cache, subviews: Subviews) {
        updateNodes(cache, subviews: subviews)
    }
    
    public func makeCache(subviews: Subviews) -> Cache {
        let cache = Cache()
        
        updateNodes(cache, subviews: subviews)
        
        return cache
    }
    
    public func sizeThatFits(
        proposal: PlacementProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) -> CGSize {
        updateNodeImpl(cache.rootNode)
        
        cache.rootNode.children.forEach { node in
            node.isDirty = true
        }
                
        let flexibleProposal = ProposedViewSize(
            width: flexibleAxies.contains(.horizontal) ? .nan : proposal.width,
            height: flexibleAxies.contains(.vertical) ? .nan : proposal.height
        )

        cache.rootNode.layout(
            withMaxSize: flexibleProposal.replacingUnspecifiedDimensions(by: .zero)
        )
        
        return cache.rootNode.frame.size
    }
    
    public func placeSubviews(
        in bounds: CGRect,
        proposal: PlacementProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) {
        updateNodeImpl(cache.rootNode)

        subviews.enumerated().forEach { offset, subview in
            let node = cache.rootNode.children[offset]
            
            let padding = node.padding
            
            let point = CGPoint(
                x: bounds.origin.x + node.frame.origin.x + padding.left,
                y: bounds.origin.y + node.frame.origin.y + padding.top
            )
            
            let size = node.frame.size
            
            let sizeWithoutPadding = CGSize(
                width: size.width - padding.left - padding.right,
                height: size.height - padding.top - padding.bottom
            )
                                                
            subview.place(
                at: point,
                anchor: .topLeading,
                proposal: PlacementProposedViewSize(sizeWithoutPadding)
            )
        }
    }
}
