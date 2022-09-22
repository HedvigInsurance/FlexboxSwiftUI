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

public struct FlexStack<Content: View>: View, FlexStyle {
    public var flexibleAxes: [Axis]
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
    
    /// the content of the flex stack
    public var content: () -> Content

    /// - Note: See `gYGNodeDefaults.style`.
    public init(
        flexibleAxes: [Axis] = [],
        
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
        border: Edges = .undefined,
        
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.flexibleAxes = flexibleAxes
        
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
        
        self.content = content
    }
    
    public var body: some View {
        FlexLayout(flexibleAxes: self.flexibleAxes, style: self) {
            content()
        }
    }
}
