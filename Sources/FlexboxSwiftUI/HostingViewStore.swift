//
//  ViewSizeCalculator.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-19.
//

import Foundation
import SwiftUI

class HostingViewStore: ObservableObject {
    var views: [FlexChild: HostingView<AnyView>] = [:]
    var count = 0
    
    var node: Node
    var maxSize: CGSize? = nil
    var screenMaxWidth: CGFloat = UIScreen.main.bounds.width
    
    var layout: Layout? = nil
    
    func setMaxSize(_ size: CGSize?) {
        if self.maxSize?.width != size?.width,
           self.maxSize?.height != size?.height {
            self.maxSize = size
            self.calculateLayout()
        }
    }
    
    func calculateLayout() {
        let calculatedLayout = node.layout(
            maxSize: maxSize,
            store: self
        )
        
        if calculatedLayout != layout {
            self.layout = calculatedLayout
            self.objectWillChange.send()
        }
    }
    
    func forceUpdate() {
        self.count = self.count + 1
        self.objectWillChange.send()
    }
    
    func getOrCreate(_ child: FlexChild) -> HostingView<AnyView> {
        if let hostingView = views[child] {
            return hostingView
        }
        
        let hostingView = HostingView(rootView: child.view)
        views[child] = hostingView
        
        return hostingView
    }
    
    init(node: Node) {
        self.node = node
    }
}
