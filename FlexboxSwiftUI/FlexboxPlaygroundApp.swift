//
//  FlexboxPlaygroundApp.swift
//  FlexboxPlayground
//
//  Created by Sam Pettersson on 2022-08-18.
//

import SwiftUI
import StretchKit


@main
struct FlexboxPlaygroundApp: App {
    var body: some Scene {
        WindowGroup {
            ScrollView {
                FlexView(
                    style: Style(
                        flexDirection: .row,
                        justifyContent: .center,
                        size: Size(width: .percent(1), height: .auto)
                    ),
                    children: [
                        (
                            Style(
                                flexGrow: 1
                            ),
                            AnyView(Color.red)
                        ),
                        (
                            Style(),
                            AnyView(ViewWithState())
                        ),
                        (
                            Style(
                                flexGrow: 1
                            ),
                            AnyView(Color.blue)
                        )
                    ]
                )
            }
        }
    }
}
