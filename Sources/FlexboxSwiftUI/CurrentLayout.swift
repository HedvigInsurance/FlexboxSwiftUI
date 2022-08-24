//
//  CurrentLayout.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-24.
//

import Foundation
import SwiftUI

public struct CurrentLayout: EnvironmentKey {
    public static let defaultValue: FlexLayout? = nil
}

public extension EnvironmentValues {
    var currentLayout: FlexLayout? {
    get { self[CurrentLayout.self] }
    set { self[CurrentLayout.self] = newValue }
  }
}
