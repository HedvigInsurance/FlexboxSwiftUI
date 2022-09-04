//
//  JustifyContent.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import FlexboxSwiftUI
import Foundation
import SwiftUI

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

            FlexStack {
                FlexItem(
                    size: Size(
                        width: .percent(modifySize ? 50 : 100),
                        height: .percent(50)
                    )
                ) {
                    FlexItem(
                        size: Size(width: .auto, height: .auto),
                        flexGrow: 1
                    ) {
                        Text("hello")
                    }.background(Color.blue)

                    if insertNode {
                        FlexItem(
                            size: Size(width: .auto, height: .auto),
                            flexGrow: 1
                        ).background(Color.red)
                    }
                }
            }
            .frame(height: modifySize ? 200 : 100, alignment: .topLeading)
            .background(Color.yellow)
        }
    }
}
