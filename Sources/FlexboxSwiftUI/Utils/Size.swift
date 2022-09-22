//
//  Size.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-19.
//

import Foundation

/// Size types
public enum SizeType: Equatable {
    case fixed(_ value: CGFloat)
    case percent(_ percent: CGFloat)
    case auto
    case undefined
}

public enum SizeKind {
    case normal
    case max
    case min
}

public struct Size: Equatable {
    public init(
        width: SizeType,
        height: SizeType
    ) {
        self.width = width
        self.height = height
    }

    var width: SizeType
    var height: SizeType

    func applyToNode(_ node: NodeImpl, kind: SizeKind) {
        switch kind {
        case .normal:
            switch width {
            case .fixed(let width):
                YGNodeStyleSetWidth(node.node, Float(width))
            case .percent(let percent):
                YGNodeStyleSetWidthPercent(node.node, Float(percent))
            case .auto:
                YGNodeStyleSetWidthAuto(node.node)
            case .undefined:
                break
            }

            switch height {
            case .fixed(let height):
                YGNodeStyleSetHeight(node.node, Float(height))
            case .percent(let percent):
                YGNodeStyleSetHeightPercent(node.node, Float(percent))
            case .auto:
                YGNodeStyleSetHeightAuto(node.node)
            case .undefined:
                break
            }
        case .max:
            switch width {
            case .fixed(let width):
                YGNodeStyleSetMaxWidth(node.node, Float(width))
            case .percent(let percent):
                YGNodeStyleSetMaxWidthPercent(node.node, Float(percent))
            case .auto:
                break
            case .undefined:
                break
            }

            switch height {
            case .fixed(let height):
                YGNodeStyleSetMaxHeight(node.node, Float(height))
            case .percent(let percent):
                YGNodeStyleSetMaxHeightPercent(node.node, Float(percent))
            case .auto:
                break
            case .undefined:
                break
            }
        case .min:
            switch width {
            case .fixed(let width):
                YGNodeStyleSetMinWidth(node.node, Float(width))
            case .percent(let percent):
                YGNodeStyleSetMinWidthPercent(node.node, Float(percent))
            case .auto:
                break
            case .undefined:
                break
            }

            switch height {
            case .fixed(let height):
                YGNodeStyleSetMinHeight(node.node, Float(height))
            case .percent(let percent):
                YGNodeStyleSetMinHeightPercent(node.node, Float(percent))
            case .auto:
                break
            case .undefined:
                break
            }
        }
    }
}
