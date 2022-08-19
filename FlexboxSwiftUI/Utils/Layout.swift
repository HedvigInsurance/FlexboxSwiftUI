//
//  Layout.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import UIKit
import SwiftUI

/// An evaluated Flexbox layout.
/// - Note: Layouts will not be created manually.
public struct Layout
{
    public let frame: CGRect
    public let padding: UIEdgeInsets
    public let children: [Layout]
    public let view: AnyView?

    internal init(
        frame: CGRect,
        padding: UIEdgeInsets,
        children: [Layout],
        view: AnyView?
    )
    {
        self.frame = frame
        self.padding = padding
        self.children = children
        self.view = view
    }
}

extension Layout: CustomStringConvertible
{
    public var description: String
    {
        return _descriptionForDepth(0)
    }

    private func _descriptionForDepth(_ depth: Int) -> String
    {
        let selfDescription = "{origin={\(frame.origin.x), \(frame.origin.y)}, size={\(frame.size.width), \(frame.size.height)}}"
        if children.isEmpty {
            return selfDescription
        }
        else {
            let indentation = (0...depth).reduce("\n") { accum, _ in accum + "\t" }
            let childrenDescription = (children.map { $0._descriptionForDepth(depth + 1) }).joined(separator: indentation)
            return "\(selfDescription)\(indentation)\(childrenDescription)"
        }
    }
}

extension Layout: Equatable
{
    public static func == (lhs: Layout, rhs: Layout) -> Bool
    {
        if lhs.frame != rhs.frame { return false }
        if lhs.children != rhs.children { return false }

        return true
    }
}
