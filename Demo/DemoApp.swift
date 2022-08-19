//
//  DemoApp.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-19.
//

import SwiftUI
import FlexboxSwiftUI

@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            FlexView(
                node: Node(
                    size: Size(width: .percent(100), height: .percent(100)),
                    children: [
                        Node(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            flexShrink: 1,
                            view: AnyView(Color.red)
                        ),
                        Node(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            flexShrink: 1,
                            view: AnyView(Color.blue)
                        ),
                        Node(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            flexShrink: 1,
                            view: AnyView(Color.green)
                        ),
                    ],
                    justifyContent: .center
                )
            )
        }
    }
}
