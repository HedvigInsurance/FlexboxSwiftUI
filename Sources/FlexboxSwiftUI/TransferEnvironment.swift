//
//  TransferEnvironment.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-19.
//

import Foundation
import SwiftUI

public struct TransferEnvironment: ViewModifier {
    var environment: EnvironmentValues

    public init(
        environment: EnvironmentValues
    ) {
        self.environment = environment
    }

    public func body(content: Content) -> some View {
        return Group {
            content
        }
        .environment(\.self, environment)
    }
}
