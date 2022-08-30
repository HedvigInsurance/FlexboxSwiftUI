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
        VStack {
            Button("Modify container size") {
                withAnimation(.spring()) {
                    modifySize.toggle()
                }
            }
                    
            FlexRoot {
                FlexNode(
                    style: FlexStyle(
                        size: Size(
                            width: .percent(100),
                            height: .percent(50)
                        )
                    )
                ) {
                    FlexNode(
                        style: FlexStyle(
                            size: Size(width: .auto, height: .auto),
                            flexGrow: 1
                        )
                    ) {
                        TestColor(color: .blue)
                    }
                }
            }
            .frame(height: modifySize ? 200 : 100, alignment: .topLeading)
            .background(Color.yellow)
            
            Button("Modify container size") {
                withAnimation(.spring()) {
                    modifySize.toggle()
                }
            }
        }
    }
}
