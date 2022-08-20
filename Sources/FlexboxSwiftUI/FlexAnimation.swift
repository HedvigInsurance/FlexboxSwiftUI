//
//  FlexAnimation.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-19.
//

import Foundation
import SwiftUI

public typealias WithFlexAnimation = (_ animation: Animation, _ body: @escaping () -> Void) -> Void

public struct WithFlexAnimationKey: EnvironmentKey {
    public static let defaultValue: WithFlexAnimation = { animation, body in withAnimation(animation, body) }
}

extension EnvironmentValues {
  public var withFlexAnimation: WithFlexAnimation {
    get { self[WithFlexAnimationKey.self] }
    set { self[WithFlexAnimationKey.self] = newValue }
  }
}
