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
        FlexStack(flexibleAxies: [.vertical]) {
            FlexItem(
                
                    size: Size(width: .percent(100), height: .auto),
                    flexDirection: .column
                
            ) {
                FlexItem(
                        size: Size(width: .percent(100), height: .auto),
                        flexGrow: 1
                    
                ) {
                    ViewThatChangesHeight(offset: 1)
                }
                FlexItem(
                        size: Size(width: .percent(100), height: .auto),
                        flexGrow: 1
                    
                ) {
                    ViewThatChangesHeight(offset: 1)
                }
            }
        }
    }
}

