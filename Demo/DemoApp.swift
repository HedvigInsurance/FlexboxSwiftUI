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
            NavigationView {
                Form {
                    Section(header: Text("Layouts")) {
                        NavigationLink("JustifyContent") {
                            DemoScreen(content: JustifyContent())
                        }
                        
                        NavigationLink("FillMaxAvailableHeight") {
                            DemoScreen(content: FillMaxAvailableHeight())
                        }
                        
                        NavigationLink("Padding") {
                            DemoScreen(content: Padding())
                        }
                    }
                    
                    Section(header: Text("Content")) {
                        NavigationLink("DynamicHeightText") {
                            DemoScreen(content: DynamicHeightText())
                        }
                        
                        NavigationLink("AnimatedHeightChange") {
                            DemoScreen(content: AnimatedHeightChange())
                        }
                    }
                }.navigationTitle("FlexboxSwiftUI")
            }
        }
    }
}
