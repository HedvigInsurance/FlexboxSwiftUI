//
//  FlexStylePlacementLayoutKey.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-09-16.
//

import Foundation
import SwiftUI
import Placement

struct FlexStylePlacementLayoutValueKey: PlacementLayoutValueKey {
    static var defaultValue: FlexStyle = PlacementFlexStyle()
}

extension View {
    public func flexStyle(
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
    ) -> some View {
        placementLayoutValue(
            key: FlexStylePlacementLayoutValueKey.self,
            value: PlacementFlexStyle(
                size: size,
                minSize: minSize,
                maxSize: maxSize,
                flexDirection: flexDirection,
                flexWrap: flexWrap,
                justifyContent: justifyContent,
                alignItems: alignItems,
                alignContent: alignContent,
                alignSelf: alignSelf,
                flex: flex,
                flexGrow: flexGrow,
                flexShrink: flexShrink,
                flexBasis: flexBasis,
                direction: direction,
                overflow: overflow,
                positionType: positionType,
                position: position,
                margin: margin,
                padding: padding,
                border: border
            )
        )
    }
}
