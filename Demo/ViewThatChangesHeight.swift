//
//  ViewThatChangesHeight.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-19.
//

import Foundation
import SwiftUI
import FlexboxSwiftUI

struct ViewThatChangesHeight: View {
    @Environment(\.withFlexAnimation) var withFlexAnimation
    @State var isOpen = false
    
    var body: some View {
        VStack {
            Button("Toggle") {
                withFlexAnimation(Animation.spring()) {
                    isOpen.toggle()
                }
            }
            
            Color.red
                .frame(height: isOpen ? 100 : 0)
        }
        .padding(20)
    }
}
