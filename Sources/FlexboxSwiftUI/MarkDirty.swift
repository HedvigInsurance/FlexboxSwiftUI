//
//  MarkDirty.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-20.
//

import Foundation
import SwiftUI

public typealias MarkDirtyFunc = (
    _ animation: Animation?,
    _ body: @escaping (_ transaction: Transaction) -> Void
) -> Void

public struct MarkDirtyKey: EnvironmentKey {
    public static let defaultValue: MarkDirtyFunc? = nil
}

public extension EnvironmentValues {
    var markDirty: MarkDirtyFunc? {
    get { self[MarkDirtyKey.self] }
    set { self[MarkDirtyKey.self] = newValue }
  }
}
