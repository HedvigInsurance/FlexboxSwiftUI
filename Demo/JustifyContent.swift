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
        
        FlexViewLegacy(
            node: Node(
                size: Size(width: .percent(50), height: .fixed(modifySize ? 300 : 100)),
                children: [
                    Node(
                        size: Size(width: .auto, height: .auto),
                        flexGrow: 1,
                        view: FlexChild(ViewThatChangesHeight())
                    ),
                    Node(
                        size: Size(width: .auto, height: .auto),
                        flexGrow: 1,
                        view: FlexChild(ViewThatChangesHeight())
                    )
                ],
                flexDirection: .column
            )
        ).background(Color.yellow)
        
        if #available(iOS 16, *) {
            FlexViewLayout(node: Node(
                size: Size(width: .percent(50), height: .fixed(modifySize ? 300 : 100)),
                children: [
                    Node(
                        size: Size(width: .auto, height: .auto),
                        flexGrow: 1,
                        view: FlexChild(ViewThatChangesHeight())
                    ),
                    Node(
                        size: Size(width: .auto, height: .auto),
                        flexGrow: 1,
                        view: FlexChild(ViewThatChangesHeight())
                    )
                ],
                flexDirection: .column
            )).background(Color.yellow)
        }
    }
}
