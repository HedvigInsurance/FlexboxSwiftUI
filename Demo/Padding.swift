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
        FlexStack {
            FlexItem(

                size: Size(width: .percent(100), height: .percent(100)),
                flexDirection: .row

            ) {
                FlexItem(
                    size: Size(width: .fixed(1), height: .auto),
                    flexGrow: 1,
                    padding: Edges(
                        leading: .fixed(50),
                        trailing: .fixed(50),
                        top: .auto,
                        bottom: .auto
                    )

                ) {
                    ZStack {
                        Text("Padding")
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                }
                FlexItem(
                    size: Size(width: .fixed(1), height: .auto),
                    flexGrow: 1,
                    padding: Edges(
                        leading: .fixed(50),
                        trailing: .auto,
                        top: .auto,
                        bottom: .auto
                    )

                ) {
                    ZStack {
                        Text("Padding")
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                }
            }
        }
    }
}
