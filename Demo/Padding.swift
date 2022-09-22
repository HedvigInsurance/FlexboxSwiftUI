//
//  Padding.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import FlexboxSwiftUI
import Foundation
import SwiftUI

struct Padding: View {
    var body: some View {
        FlexStack(
            flexibleAxes: [.vertical],
            size: Size(width: .percent(100), height: .auto),
            flexDirection: .row
        ) {
            Text("Padding")
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .flexStyle(
                size: Size(width: .auto, height: .auto),
                flexGrow: 1,
                flexShrink: 1,
                padding: Edges(
                    leading: .fixed(50),
                    trailing: .fixed(50),
                    top: .auto,
                    bottom: .auto
                )
            )
            
            Text("Padding")
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .flexStyle(
                size: Size(width: .auto, height: .auto),
                flexGrow: 1,
                flexShrink: 1,
                padding: Edges(
                    leading: .fixed(50),
                    trailing: .auto,
                    top: .auto,
                    bottom: .auto
                )
            )
        }
    }
}
