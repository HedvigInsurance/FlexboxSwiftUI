//
//  DemoApp.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-19.
//

import FlexboxSwiftUI
import SwiftUI

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
                        
                        NavigationLink("CenterContent") {
                            DemoScreen(content: CenterContent())
                        }
                        
                        NavigationLink("Padding") {
                            DemoScreen(content: Padding())
                        }
                    }
                    
                    Section(header: Text("Content")) {
                        NavigationLink("LotsOfNodes") {
                            DemoScreen(content: LotsOfNodes())
                        }
                        
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
