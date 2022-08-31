//
//  FlexStyle.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import YogaKit
import FlexboxSwiftUIObjC

protocol FlexStyle {
    var size: Size { get set }
    var minSize: Size { get set }
    var maxSize: Size { get set }
        
    /// Specifies how flex-items are placed in the flex-container (defining the main-axis).
    /// - Note: Applies to flex-container.
    var flexDirection: Style.FlexDirection { get set }
    
    /// Specifies whether flex items are forced into a single line
    /// or can be wrapped onto multiple lines.
    /// - Note: Applies to flex-container.
    var flexWrap: Style.FlexWrap { get set }
    
    /// Distributes space between and around flex-items along the main-axis.
    /// - Note: Applies to flex-container.
    var justifyContent: Style.JustifyContent { get set }
    
    /// Distributes space between and around flex-items along the cross-axis.
    /// This works like `justifyContent` but in the perpendicular direction.
    /// - Note: Applies to flex-container.
    var alignItems: Style.AlignItems { get set }
    
    /// Aligns a flex-container's lines when there is extra space on the cross-axis.
    /// - Warning: This property has no effect on single line.
    /// - Note: Applies to multi-line flex-container (no `FlexWrap.nowrap`).
    var alignContent: Style.AlignContent { get set }
    
    /// Aligns self (flex-item) by overriding it's parent's (flex-container) `alignItems`.
    /// - Note: Applies to flex-item.
    var alignSelf: Style.AlignSelf { get set }
    
    /// Shorthand property specifying the ability of a flex-item
    /// to alter its dimensions to fill available space.
    /// - Note: Applies to flex-item.
    var flex: CGFloat { get set }
    
    /// Grow factor of a flex-item.
    /// - Note: Applies to flex-item.
    var flexGrow: CGFloat { get set }
    
    /// Shrink factor of a flex-item.
    /// - Note: Applies to flex-item.
    var flexShrink: CGFloat { get set }
    
    /// Initial main size of a flex item.
    /// - Note: Applies to flex-item.
    var flexBasis: CGFloat { get set }
    
    var direction: Style.Direction { get set }
    var overflow: Style.Overflow { get set }
    var positionType: Style.PositionType { get set }
    
    /// CSS's (top, right, bottom, left) that works with `positionType = .absolute`.
    var position: Edges { get set }
    
    var margin: Edges { get set }
    var padding: Edges { get set }
    
    /// facebook/yoga implementation that mostly works as same as `padding`.
    var border: Edges { get set }
}

extension FlexStyle {
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
