//
//  FlexViewCoordinator.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-24.
//

import Foundation
import SwiftUI
import FlexboxSwiftUIObjC

public class FlexViewLayoutCoordinator: ObservableObject {
    var layout: FlexLayout? = nil
    var maxSize: CGSize? = nil
    
    init() {
        self.layout = nil
        self.maxSize = nil
    }
}

public class FlexViewCoordinator: ObservableObject {
    public var node: Node
    var layoutCoordinator: FlexViewLayoutCoordinator
    
    var numberOfChildren: Int {
        node.children.count
    }
    
    public init(node: Node) {
        self.node = node
        self.layoutCoordinator = FlexViewLayoutCoordinator()
    }
}
