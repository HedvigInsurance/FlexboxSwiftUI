//
//  HostingView.swift
//  FlexboxPlayground
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import SwiftUI
import UIKit

class HostingView<Content: View>: UIView {
    var rootViewHostingController: AdjustableHostingController<AnyView>

    public var swiftUIRootView: Content {
        didSet {
            self.rootViewHostingController.rootView = AnyView(swiftUIRootView)
        }
    }

    public required init(
        rootView: Content
    ) {
        self.swiftUIRootView = rootView
        self.rootViewHostingController = .init(
            rootView: AnyView(rootView)
        )

        super.init(frame: .zero)

        rootViewHostingController.view.backgroundColor = .clear

        addSubview(rootViewHostingController.view)
        self.backgroundColor = UIColor.clear
    }

    override var frame: CGRect {
        didSet {
            rootViewHostingController.view.frame = frame
        }
    }

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }

    deinit {
        rootViewHostingController.removeFromParent()
    }

    required init?(
        coder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        rootViewHostingController.view.systemLayoutSizeFitting(targetSize)
    }

    public override var intrinsicContentSize: CGSize {
        return rootViewHostingController.view.intrinsicContentSize
    }

    override open func systemLayoutSizeFitting(
        _ targetSize: CGSize,
        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
        verticalFittingPriority: UILayoutPriority
    ) -> CGSize {
        rootViewHostingController.view.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: horizontalFittingPriority,
            verticalFittingPriority: verticalFittingPriority
        )
    }

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        rootViewHostingController.view.sizeThatFits(size)
    }

    override open func sizeToFit() {
        frame.size = rootViewHostingController.sizeThatFits(in: .zero)
    }
}

class AdjustableHostingController<Content: View>: UIHostingController<Content> {
    public override init(
        rootView: Content
    ) {
        super.init(rootView: rootView)
        view.backgroundColor = .clear
    }

    @MainActor @objc required dynamic init?(
        coder aDecoder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }

    var previousSize: CGSize = .zero
}
