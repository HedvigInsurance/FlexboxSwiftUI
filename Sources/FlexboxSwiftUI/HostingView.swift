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
    var layout: Layout? = nil {
        didSet {
            if self.view.intrinsicContentSize.height != self.layout?.frame.height {
                self.store.forceUpdate()
            }
        }
    }
    private var node: NodeImpl
    private var store: HostingViewStore
    private var content: AnyView
    private var environment: EnvironmentValues? = nil
    private var transaction: Transaction? = nil

    func disableSafeArea() {
        guard let viewClass = object_getClass(view) else { return }
        
        let viewSubclassName = String(cString: class_getName(viewClass)).appending("_IgnoreSafeArea")
        if let viewSubclass = NSClassFromString(viewSubclassName) {
            object_setClass(view, viewSubclass)
        }
        else {
            guard let viewClassNameUtf8 = (viewSubclassName as NSString).utf8String else { return }
            guard let viewSubclass = objc_allocateClassPair(viewClass, viewClassNameUtf8, 0) else { return }
            
            if let method = class_getInstanceMethod(UIView.self, #selector(getter: UIView.safeAreaInsets)) {
                let safeAreaInsets: @convention(block) (AnyObject) -> UIEdgeInsets = { _ in
                    return .zero
                }
                class_addMethod(viewSubclass, #selector(getter: UIView.safeAreaInsets), imp_implementationWithBlock(safeAreaInsets), method_getTypeEncoding(method))
            }
            
            objc_registerClassPair(viewSubclass)
            object_setClass(view, viewSubclass)
        }
    }
    
    func setRootView() {
        let base = AnyView(
            content
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
        disableSafeArea()
        view.backgroundColor = .clear
    }
    
    func measure(targetSize: CGSize) -> CGSize {
        let size = self.view.sizeThatFits(
            targetSize
        )
        
        let sizeZero = self.view.sizeThatFits(
            .zero
        )
    
        print("targetSize", targetSize, size, sizeZero)
        
        return size
    }

    @MainActor @objc required dynamic init?(
        coder aDecoder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }
            
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.superview?.invalidateIntrinsicContentSize()
    }
}
