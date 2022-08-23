//
//  Padding.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import Foundation
import FlexboxSwiftUI
import SwiftUI

struct Padding: View {
    var body: some View {        
        RenderBothImplementations(
            node: Node(
                size: Size(width: .percent(100), height: .auto),
                children: [
                    Node(
                        size: Size(width: .fixed(1), height: .auto),
                        flexGrow: 1,
                        padding: Edges(
                            leading: .fixed(50),
                            trailing: .fixed(50),
                            top: .auto,
                            bottom: .auto
                        ),
                        view: FlexChild(
                            Text("Padding")
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                        )
                    ),
                    Node(
                        size: Size(width: .fixed(1), height: .auto),
                        flexGrow: 1,
                        view: FlexChild(
                            Text("Padding")
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                        )
                    ),
                ],
                flexDirection: .row
            )
        )
    }
}
