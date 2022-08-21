//
//  MarkDirty.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-20.
//

import Foundation
import SwiftUI

public struct MarkDirtyKey: EnvironmentKey {
    public static let defaultValue: () -> Void = {}
}

public extension EnvironmentValues {
    var markDirty: () -> Void {
    get { self[MarkDirtyKey.self] }
    set { self[MarkDirtyKey.self] = newValue }
  }
}
