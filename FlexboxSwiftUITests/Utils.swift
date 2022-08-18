//
//  Utils.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import SwiftUI
import ViewInspector
import StretchKit
@testable import FlexboxSwiftUI

struct InspectionEnabledView<Content: View>: View, Inspectable {
    var view: Content
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        view
            .onReceive(inspection.notice) { self.inspection.visit(self, $0) } 
    }
}

extension View {
    func frame(size: Size<Float?>) -> some View {
        self.frame(width: CGFloat(size.width ?? 0), height: CGFloat(size.height ?? 0))
    }
}

var assertSize: Size<Float?> {
    CGSize(width: 300, height: 300).sizeOptional
}
