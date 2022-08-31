//
//  NodeImplPreferenceKey.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-30.
//

import Foundation
import SwiftUI
import FlexboxSwiftUIObjC

struct NodeImplPreferenceKey: PreferenceKey {
    static var defaultValue: NodeImpl? = nil

    static func reduce(value: inout NodeImpl?, nextValue: () -> NodeImpl?) {
       value = nextValue()
    }
}
