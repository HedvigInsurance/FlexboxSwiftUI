//
//  FlexChild.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-19.
//

import Foundation
import SwiftUI

public struct FlexChild: Hashable {
    public static func == (lhs: FlexChild, rhs: FlexChild) -> Bool {
        lhs.id == rhs.id
    }

    var id = UUID().uuidString
    var view: AnyView

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public init<Content: View>(
        _ view: Content
    ) {
        self.view = AnyView(view)
    }
}
