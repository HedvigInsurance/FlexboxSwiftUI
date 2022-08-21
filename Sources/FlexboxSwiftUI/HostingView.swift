//
//  HostingView.swift
//  FlexboxPlayground
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import SwiftUI
import UIKit
import FlexboxSwiftUIObjC

class AdjustableHostingController: UIHostingController<AnyView> {
    private var node: NodeImpl
    private var store: HostingViewStore
    private var content: AnyView
    private var environment: EnvironmentValues? = nil
    
    func setRootView() {
        let base = AnyView(
            content.environment(\.markDirty) {
                self.node.markDirty()
                self.store.forceUpdate()
                self.environment?.markDirty()
            }
        )
        
        let withEnvironment: AnyView
        
        if let environment = environment {
            withEnvironment = AnyView(
                base.modifier(TransferEnvironment(environment: environment))
            )
        } else {
            withEnvironment = base
        }
        
        rootView = AnyView(
            withEnvironment
        )
    }
    
    func setEnvironment(_ environment: EnvironmentValues) {
        self.environment = environment
        setRootView()
    }
    
    public init(
        rootView: AnyView,
        store: HostingViewStore,
        node: NodeImpl
    ) {
        self.store = store
        self.content = rootView
        self.node = node
        super.init(rootView: rootView)
        view.backgroundColor = .clear
    }
    
    func measure(targetSize: CGSize) -> CGSize {
        return self.view.systemLayoutSizeFitting(targetSize)
    }

    @MainActor @objc required dynamic init?(
        coder aDecoder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }
}
