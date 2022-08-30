//
//  TransferEnvironment.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-19.
//

import Foundation
import SwiftUI

struct TransferEnvironmentView<Content: View>: View {
    var content: Content
    var environment: EnvironmentValues
    
    var body: some View {
        content.environment(\.self, environment)
    }
}
