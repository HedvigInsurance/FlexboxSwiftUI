//
//  JustifyContent.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import Foundation
import SwiftUI
import FlexboxSwiftUI

struct JustifyContent: View {
    @State var modifySize = false
    
    var body: some View {
        Button("Modify container size") {
            withAnimation(.spring()) {
                modifySize.toggle()
            }
        }
                
        //HostingViewRepresentble()
    }
}
