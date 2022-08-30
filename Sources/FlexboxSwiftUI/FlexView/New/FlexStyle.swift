//
//  FlexStyle.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import YogaKit
import FlexboxSwiftUIObjC

public struct FlexStyle {
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
    
    func updateNodeImpl(_ node: NodeImpl) {
        size.applyToNode(node, kind: .normal)
        maxSize.applyToNode(node, kind: .max)
        minSize.applyToNode(node, kind: .min)
        
        YGNodeStyleSetFlexDirection(
            node.node,
            YGFlexDirection(rawValue: Int32(flexDirection.rawValue))!
        )
        YGNodeStyleSetFlexWrap(node.node, YGWrap(rawValue: Int32(flexWrap.rawValue))!)
        YGNodeStyleSetJustifyContent(node.node, YGJustify(rawValue: Int32(justifyContent.rawValue))!)
        YGNodeStyleSetAlignContent(node.node, YGAlign(rawValue: Int32(alignContent.rawValue))!)
        YGNodeStyleSetAlignItems(node.node, YGAlign(rawValue: Int32(alignItems.rawValue))!)
        YGNodeStyleSetAlignSelf(node.node, YGAlign(rawValue: Int32(alignSelf.rawValue))!)
        
        YGNodeStyleSetFlex(node.node, Float(flex))
        YGNodeStyleSetFlexGrow(node.node, Float(flexGrow))
        YGNodeStyleSetFlexShrink(node.node, Float(flexShrink))
        YGNodeStyleSetFlexBasis(node.node, Float(flexBasis))
        
        YGNodeStyleSetDirection(node.node, YGDirection(rawValue: Int32(direction.rawValue))!)
        YGNodeStyleSetOverflow(node.node, YGOverflow(rawValue: Int32(overflow.rawValue))!)
        YGNodeStyleSetPositionType(node.node, YGPositionType(rawValue: Int32(positionType.rawValue))!)
        
        position.applyToNode(node, kind: .position)
        margin.applyToNode(node, kind: .margin)
        padding.applyToNode(node, kind: .padding)
        border.applyToNode(node, kind: .border)
    }
    
    func createUnderlyingNode() -> NodeImpl {
        let node = NodeImpl()
        
        updateNodeImpl(node)
        
        node.children = []
        
        return node
    }
}

extension FlexStyle: Equatable {
    public static func == (l: FlexStyle, r: FlexStyle) -> Bool {
        if l.size != r.size { return false }
        if l.minSize != r.minSize { return false }
        if l.maxSize != r.maxSize { return false }
        
        if l.flexDirection != r.flexDirection { return false }
        if l.flexWrap != r.flexWrap { return false }
        if l.justifyContent != r.justifyContent { return false }
        if l.alignContent != r.alignContent { return false }
        if l.alignItems != r.alignItems { return false }
        if l.alignSelf != r.alignSelf { return false }
        
        if !_isCGFloatEqual(l.flex, r.flex) { return false }
        if !_isCGFloatEqual(l.flexGrow, r.flexGrow) { return false }
        if !_isCGFloatEqual(l.flexShrink, r.flexShrink) { return false }
        if !_isCGFloatEqual(l.flexBasis, r.flexBasis) { return false }
        
        if l.direction != r.direction { return false }
        if l.overflow != r.overflow { return false }
        if l.positionType != r.positionType { return false }
        
        if l.position != r.position { return false }
        if l.margin != r.margin { return false }
        if l.padding != r.padding { return false }
        if l.border != r.border { return false }
                
        return true
    }
}