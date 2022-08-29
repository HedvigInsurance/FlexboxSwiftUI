//
//  ViewDebugData.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import SwiftUI

struct ViewDebugData {
    let data: [_ViewDebug.Property: Any]
    let childData: [ViewDebugData]
}

extension UIHostingController {
    func inspectViewDebugData() {
        let view = self.view as! _UIHostingView<Content>
        let _viewDebugData = view._viewDebugData()
        print(_viewDebugData) // You can print out _viewDebugData as-is
        
        // However, to access its properties in code, we need to first cast it to a custom struct.
        // This way we get access to the underlying properties which have of type _ViewDebug.Property.
        // This part can easily break in the future.
        let viewDebugData = unsafeBitCast(_viewDebugData, to: [ViewDebugData].self)
        print(viewDebugData.first?.data[.size])
    }
}
