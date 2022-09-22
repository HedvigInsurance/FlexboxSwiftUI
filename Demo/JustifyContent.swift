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
        VStack(spacing: 0) {
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
            }.frame(maxWidth: .infinity)

            FlexStack(
                flexibleAxes: [.vertical],
                size: Size(
                    width: .percent(100),
                    height: .auto
                ),
                flexDirection: modifySize ? .column : .row,
                alignItems: .flexEnd
            ) {
                Text("hello")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
                .flexStyle(
                    size: Size(width: .auto, height: .auto),
                    flexGrow: 1,
                    flexShrink: 1
                )

                if insertNode {
                    Text("test")
                    .padding(30)
                    .background(Color.red)
                    .flexStyle(
                        size: Size(width: .auto, height: .auto),
                        flexGrow: 1
                    )
                    
                    Text("test")
                    .background(Color.red)
                    .flexStyle(
                        size: Size(width: .auto, height: .auto),
                        flexGrow: 1
                    )
                }
            }
            .background(Color.yellow)
        }
    }
}
