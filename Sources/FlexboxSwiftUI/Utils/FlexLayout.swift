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
public struct FlexLayout {
    public let frame: CGRect
    public let padding: UIEdgeInsets
    public let children: [FlexLayout]
    public let view: FlexChild?

    internal init(
        frame: CGRect,
        padding: UIEdgeInsets,
        children: [FlexLayout],
        view: FlexChild?
    ) {
        self.frame = frame
        self.padding = padding
        self.children = children
        self.view = view
    }
}

extension FlexLayout: CustomStringConvertible {
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

extension FlexLayout: Equatable {
    public static func == (lhs: FlexLayout, rhs: FlexLayout) -> Bool {
        if lhs.frame != rhs.frame { return false }
        if lhs.children != rhs.children { return false }

        return true
    }
}
