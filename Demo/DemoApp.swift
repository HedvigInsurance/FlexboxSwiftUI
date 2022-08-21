//
//  DemoApp.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-19.
//

import FlexboxSwiftUI
import SwiftUI

struct ShowHide: View {
    @State var show = false

    var body: some View {
        VStack {
            Text("Without flex")

            ViewThatChangesHeight()

            Text("With flex")
            
            FlexView(
                node: Node(
                    size: Size(width: .percent(100), height: .auto),
                    children: [
                        Node(
                            size: Size(width: .percent(100), height: .auto),
                            flexGrow: 1,
                            view: FlexChild(VStack {
                                
                                FlexView(
                                    node: Node(
                                        size: Size(width: .percent(100), height: .auto),
                                        children: [
                                            Node(
                                                size: Size(width: .percent(100), height: .auto),
                                                flexGrow: 1,
                                                view: FlexChild(ViewThatChangesHeight())
                                            )
                                        ],
                                        justifyContent: .flexStart
                                    )
                                )
                                
                            })
                        )
                    ],
                    justifyContent: .flexStart
                )
            )
        }
    }
}

@main
struct DemoApp: App {
    var body: some Scene {
        return WindowGroup {
            FlexScrollView {
                ShowHide()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
