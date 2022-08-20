//
//  DemoApp.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-19.
//

import SwiftUI
import FlexboxSwiftUI

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
                            view: FlexChild(ViewThatChangesHeight())
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
            ScrollView {
//                FlexView(
//                    node: Node(
//                        size: Size(width: .percent(100), height: .undefined),
//                        children: [
//                            Node(
//                                size: Size(width: .fixed(10), height: .fixed(300)),
//                                flexGrow: 1,
//                                flexShrink: 0,
//                                view: FlexChild(Color.red)
//                            ),
//                            Node(
//                                size: Size(width: .fixed(10), height: .fixed(300)),
//                                flexGrow: 1,
//                                flexShrink: 0,
//                                view: FlexChild(Color.blue)
//                            ),
//                            Node(
//                                size: Size(width: .fixed(10), height: .fixed(300)),
//                                flexGrow: 1,
//                                flexShrink: 0,
//                                view: FlexChild(Color.green)
//                            ),
//                        ],
//                        justifyContent: .center
//                    )
//                )
                
                ShowHide()
            }.frame(maxWidth: .infinity)
        }
    }
}
