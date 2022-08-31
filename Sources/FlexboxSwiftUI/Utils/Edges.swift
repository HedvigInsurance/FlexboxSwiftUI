//
//  Edges.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-18.
//

import FlexboxSwiftUIObjC
import Foundation
import UIKit

public enum EdgeKind {
    case margin
    case position
    case padding
    case border
}

/// Container for 4-direction `SizeType` values.
public struct Edges: Equatable {
    public let leading: SizeType
    public let trailing: SizeType
    public let top: SizeType
    public let bottom: SizeType

    public init(
        leading: SizeType = .undefined,
        trailing: SizeType = .undefined,
        top: SizeType = .undefined,
        bottom: SizeType = .undefined
    ) {
        self.leading = leading
        self.trailing = trailing
        self.top = top
        self.bottom = bottom
    }

    public static var undefined: Edges {
        .init()
    }

    func applyToNode(_ node: NodeImpl, kind: EdgeKind) {
        switch kind {
        case .margin:
            switch leading {
            case .fixed(let fixed):
                YGNodeStyleSetMargin(node.node, YGEdge.left, Float(fixed))
            case .percent(let percent):
                YGNodeStyleSetMarginPercent(node.node, YGEdge.left, Float(percent))
            case .auto:
                YGNodeStyleSetMarginAuto(node.node, YGEdge.left)
            case .undefined:
                break
            }

            switch trailing {
            case .fixed(let fixed):
                YGNodeStyleSetMargin(node.node, YGEdge.right, Float(fixed))
            case .percent(let percent):
                YGNodeStyleSetMarginPercent(node.node, YGEdge.right, Float(percent))
            case .auto:
                YGNodeStyleSetMarginAuto(node.node, YGEdge.right)
            case .undefined:
                break
            }

            switch top {
            case .fixed(let fixed):
                YGNodeStyleSetMargin(node.node, YGEdge.top, Float(fixed))
            case .percent(let percent):
                YGNodeStyleSetMarginPercent(node.node, YGEdge.top, Float(percent))
            case .auto:
                YGNodeStyleSetMarginAuto(node.node, YGEdge.top)
            case .undefined:
                break
            }

            switch bottom {
            case .fixed(let fixed):
                YGNodeStyleSetMargin(node.node, YGEdge.bottom, Float(fixed))
            case .percent(let percent):
                YGNodeStyleSetMarginPercent(node.node, YGEdge.bottom, Float(percent))
            case .auto:
                YGNodeStyleSetMarginAuto(node.node, YGEdge.bottom)
            case .undefined:
                break
            }
        case .position:
            switch leading {
            case .fixed(let fixed):
                YGNodeStyleSetPosition(node.node, YGEdge.left, Float(fixed))
            case .percent(let percent):
                YGNodeStyleSetPositionPercent(node.node, YGEdge.left, Float(percent))
            case .auto:
                break
            case .undefined:
                break
            }

            switch trailing {
            case .fixed(let fixed):
                YGNodeStyleSetPosition(node.node, YGEdge.right, Float(fixed))
            case .percent(let percent):
                YGNodeStyleSetPositionPercent(node.node, YGEdge.right, Float(percent))
            case .auto:
                break
            case .undefined:
                break
            }

            switch top {
            case .fixed(let fixed):
                YGNodeStyleSetPosition(node.node, YGEdge.top, Float(fixed))
            case .percent(let percent):
                YGNodeStyleSetPositionPercent(node.node, YGEdge.top, Float(percent))
            case .auto:
                break
            case .undefined:
                break
            }

            switch bottom {
            case .fixed(let fixed):
                YGNodeStyleSetPosition(node.node, YGEdge.bottom, Float(fixed))
            case .percent(let percent):
                YGNodeStyleSetPositionPercent(node.node, YGEdge.bottom, Float(percent))
            case .auto:
                break
            case .undefined:
                break
            }
        case .padding:
            switch leading {
            case .fixed(let fixed):
                YGNodeStyleSetPadding(node.node, YGEdge.left, Float(fixed))
            case .percent(let percent):
                YGNodeStyleSetPaddingPercent(node.node, YGEdge.left, Float(percent))
            case .auto:
                break
            case .undefined:
                break
            }

            switch trailing {
            case .fixed(let fixed):
                YGNodeStyleSetPadding(node.node, YGEdge.right, Float(fixed))
            case .percent(let percent):
                YGNodeStyleSetPaddingPercent(node.node, YGEdge.right, Float(percent))
            case .auto:
                break
            case .undefined:
                break
            }

            switch top {
            case .fixed(let fixed):
                YGNodeStyleSetPadding(node.node, YGEdge.top, Float(fixed))
            case .percent(let percent):
                YGNodeStyleSetPaddingPercent(node.node, YGEdge.top, Float(percent))
            case .auto:
                break
            case .undefined:
                break
            }

            switch bottom {
            case .fixed(let fixed):
                YGNodeStyleSetPadding(node.node, YGEdge.bottom, Float(fixed))
            case .percent(let percent):
                YGNodeStyleSetPaddingPercent(node.node, YGEdge.bottom, Float(percent))
            case .auto:
                break
            case .undefined:
                break
            }
        case .border:
            switch leading {
            case .fixed(let fixed):
                YGNodeStyleSetBorder(node.node, YGEdge.left, Float(fixed))
            case .percent:
                break
            case .auto:
                break
            case .undefined:
                break
            }

            switch trailing {
            case .fixed(let fixed):
                YGNodeStyleSetBorder(node.node, YGEdge.right, Float(fixed))
            case .percent:
                break
            case .auto:
                break
            case .undefined:
                break
            }

            switch top {
            case .fixed(let fixed):
                YGNodeStyleSetBorder(node.node, YGEdge.top, Float(fixed))
            case .percent:
                break
            case .auto:
                break
            case .undefined:
                break
            }

            switch bottom {
            case .fixed(let fixed):
                YGNodeStyleSetBorder(node.node, YGEdge.bottom, Float(fixed))
            case .percent:
                break
            case .auto:
                break
            case .undefined:
                break
            }
        }

    }
}
