//
//  Layout.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import SwiftUI
import UIKit

/// An evaluated Flexbox layout.
/// - Note: Layouts will not be created manually.
public struct Layout {
    public let frame: CGRect
    public let padding: UIEdgeInsets
    public let children: [Layout]
    public let view: AnyView?

    internal init(
        frame: CGRect,
        padding: UIEdgeInsets,
        children: [Layout],
        view: AnyView? = nil
    ) {
        self.frame = frame
        self.padding = padding
        self.children = children
        self.view = view
    }
}

extension Layout: CustomStringConvertible {
    public var description: String {
        return _descriptionForDepth(0)
    }

    private func _descriptionForDepth(_ depth: Int) -> String {
        let selfDescription =
            "{origin={\(frame.origin.x), \(frame.origin.y)}, size={\(frame.size.width), \(frame.size.height)}}"
        if children.isEmpty {
            return selfDescription
        } else {
            let indentation = (0...depth).reduce("\n") { accum, _ in accum + "\t" }
            let childrenDescription = (children.map { $0._descriptionForDepth(depth + 1) })
                .joined(
                    separator: indentation
                )
            return "\(selfDescription)\(indentation)\(childrenDescription)"
        }
    }
}

func diff(_ lhs: CGFloat, _ rhs: CGFloat) -> CGFloat {
    return abs(lhs - rhs)
}

func compareEquals(_ lhs: CGFloat, _ rhs: CGFloat, tolerance: CGFloat) -> Bool {
    let difference = diff(lhs, rhs)
    return difference <= tolerance
}

extension CGRect {
    /// Checks if a rect is equal with a given tolerance
    func equalTo(other rect: CGRect, tolerance: CGFloat = 1) -> Bool {
        return ![
            compareEquals(origin.y, rect.origin.y, tolerance: tolerance),
            compareEquals(origin.x, rect.origin.x, tolerance: tolerance),
            compareEquals(width, rect.width, tolerance: tolerance),
            compareEquals(height, rect.height, tolerance: tolerance),
        ].contains(false)
    }
}

extension Layout: Equatable {
    public static func == (lhs: Layout, rhs: Layout) -> Bool {
        if !lhs.frame.equalTo(other: rhs.frame) { return false }
        if lhs.children != rhs.children { return false }

        return true
    }
}
