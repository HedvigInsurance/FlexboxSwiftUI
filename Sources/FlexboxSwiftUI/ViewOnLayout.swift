//
//  ViewOnLayout.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-27.
//

import Foundation
import UIKit

fileprivate func swizzleMethod(_ `class`: AnyClass, _ original: Selector, _ swizzled: Selector) {
    if let original = class_getInstanceMethod(`class`, original), let swizzled = class_getInstanceMethod(`class`, swizzled) {
        method_exchangeImplementations(original, swizzled)
    }
    else { print("failed to swizzle: \(`class`.self), '\(original)', '\(swizzled)'") }
}

typealias OnLayoutHandler = (() -> Void)?

private var onLayoutHandlerKey = false
private var hasSwizzled = false

extension UIView {
    var onLayoutHandler: OnLayoutHandler {
        get {
            objc_getAssociatedObject(self, &onLayoutHandlerKey) as? OnLayoutHandler ?? nil
        }
        set {
            objc_setAssociatedObject(self, &onLayoutHandlerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    static func swizzleLayoutHandler() {
        if !hasSwizzled {
            swizzleMethod(UIView.self, #selector(UIView.layoutSubviews), #selector(UIView.layoutSubviews_x))
            hasSwizzled = true
        }
    }
    
    @objc private func layoutSubviews_x() {
        onLayoutHandler?()
        self.layoutSubviews_x()
    }
}
