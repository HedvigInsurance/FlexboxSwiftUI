//
//  AnimatedHeightChange.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import FlexboxSwiftUI
import Foundation
import SwiftUI

struct AnimatedHeightChange: View {
    var body: some View {
        FlexStack(
            flexibleAxes: [.vertical],
            flexDirection: .column
        ) {
            ViewThatChangesHeight(offset: 1)
                .flexStyle(
                    size: Size(width: .percent(100), height: .auto),
                    flexGrow: 1
                )
            
            ViewThatChangesHeight(offset: 1)
                .flexStyle(
                    size: Size(width: .percent(100), height: .auto),
                    flexGrow: 1
                )
        }
    }
}
