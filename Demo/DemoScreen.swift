//
//  DemoScreen.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import Foundation
import FlexboxSwiftUI
import SwiftUI

struct DemoScreen<Content: View>: View {
    var content: Content
    
    var body: some View {
        ScrollView {
            content
        }
        .navigationBarTitle(String(describing: Content.self))
        .navigationBarTitleDisplayMode(.inline)
    }
}
