//
//  AnimatedHeightChange.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import Foundation
import FlexboxSwiftUI
import SwiftUI

struct AnimatedHeightChange: View {
    var body: some View {
        Text("[KNOWN BUG] Animations currently causes content to stutter on pre iOS 16")
        
        FlexView(
            node: Node(
                size: Size(width: .percent(100), height: .auto),
                children: [
                    Node(
                        size: Size(width: .percent(100), height: .auto),
                        flexGrow: 1,
                        view: FlexChild(
                            ViewThatChangesHeight()
                        )
                    ),
                    Node(
                        size: Size(width: .percent(100), height: .auto),
                        flexGrow: 1,
                        view: FlexChild(
                            ViewThatChangesHeight()
                        )
                    ),
                    Node(
                        size: Size(width: .percent(100), height: .auto),
                        view: FlexChild(
                            FlexView(
                                node: Node(
                                    size: Size(width: .percent(100), height: .auto),
                                    children: [
                                        Node(
                                            size: Size(width: .percent(100), height: .auto),
                                            flexGrow: 1,
                                            view: FlexChild(
                                                ViewThatChangesHeight()
                                            )
                                        ),
                                        Node(
                                            size: Size(width: .percent(100), height: .auto),
                                            flexGrow: 1,
                                            view: FlexChild(
                                                ViewThatChangesHeight()
                                            )
                                        )
                                    ],
                                    flexDirection: .column
                                )
                            )
                        )
                    )
                ],
                flexDirection: .column
            )
        ).background(Color.yellow)
    }
}

