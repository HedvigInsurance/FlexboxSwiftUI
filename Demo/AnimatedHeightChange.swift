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
        FlexRoot(flexibleAxies: [.vertical]) {
            FlexNode(
                style: FlexStyle(
                    size: Size(width: .percent(100), height: .auto),
                    flexDirection: .column
                )
            ) {
                FlexNode(
                    style: FlexStyle(
                        size: Size(width: .percent(100), height: .auto),
                        flexGrow: 1
                    )
                ) {
                    ViewThatChangesHeight(offset: 1)
                }
                FlexNode(
                    style: FlexStyle(
                        size: Size(width: .percent(100), height: .auto),
                        flexGrow: 1
                    )
                ) {
                    ViewThatChangesHeight(offset: 1)
                }
            }
        }
    }
}

