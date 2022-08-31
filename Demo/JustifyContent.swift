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
    @State var insertNode = false
    
    var body: some View {
        VStack {
            HStack {
                Button("Modify size") {
                    withAnimation(.spring()) {
                        modifySize.toggle()
                    }
                }
                Button("Insert node") {
                    withAnimation(.spring()) {
                        insertNode.toggle()
                    }
                }
            }
                    
            FlexRoot {
                FlexNode(
                    style: FlexStyle(
                        size: Size(
                            width: .percent(modifySize ? 50 : 100),
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
                    
                    if insertNode {
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
            }
            .frame(height: modifySize ? 200 : 100, alignment: .topLeading)
            .background(Color.yellow)
        }
    }
}
