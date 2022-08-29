//
//  NodeOffsetKey.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import SwiftUI

private struct NodeOffsetKey: EnvironmentKey {
    static let defaultValue: NodeOffset? = nil
}

extension EnvironmentValues {
  var nodeOffset: NodeOffset? {
    get { self[NodeOffsetKey.self] }
    set { self[NodeOffsetKey.self] = newValue }
  }
}
