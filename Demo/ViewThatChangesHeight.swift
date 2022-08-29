//
//  ViewThatChangesHeight.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-19.
//

import FlexboxSwiftUI
import Foundation
import SwiftUI

struct ViewThatChangesHeight: View {
    @State var isOpen = false
    var offset: Int

    var body: some View {
        VStack {
            Button("\(offset)") {
                withAnimation(.spring()) {
                    isOpen.toggle()
                }
            }

            Color.red
                .frame(height: isOpen ? 100 : 0)
        }
        .padding(20)
        .background(Color.red)
    }
}
