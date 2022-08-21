//
//  ViewSizeCalculator.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-19.
//

import Foundation
import SwiftUI
import FlexboxSwiftUIObjC

public class HostingViewStore: ObservableObject {
    var node: NodeImpl? = nil
    var views: [FlexChild: AdjustableHostingController] = [:]

    var maxSize: CGSize? = nil
    var screenMaxWidth: CGFloat = UIScreen.main.bounds.width

    func setMaxSize(_ size: CGSize?) {
        if self.maxSize?.width != size?.width,
            self.maxSize?.height != size?.height
        {
            self.maxSize = size
            self.forceUpdate()
        }
    }

    public func forceUpdate() {
        self.objectWillChange.send()
    }

    func add(_ child: FlexChild, node: NodeImpl) -> AdjustableHostingController {
        let hostingView = AdjustableHostingController(
            rootView: child.view,
            store: self,
            node: node
        )
        views[child] = hostingView

        return hostingView
    }
}
