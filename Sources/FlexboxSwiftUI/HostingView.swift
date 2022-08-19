//
//  HostingView.swift
//  FlexboxPlayground
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import Foundation
import SwiftUI
import UIKit

class HostingView<Content: View>: UIView {
    let rootViewHostingController: AdjustableHostingController<AnyView>

    public var swiftUIRootView: Content {
        didSet {
            self.rootViewHostingController.rootView = AnyView(swiftUIRootView.edgesIgnoringSafeArea(.all))
        }
    }

    public required init(
        rootView: Content
    ) {
        self.swiftUIRootView = rootView
        self.rootViewHostingController = .init(rootView: AnyView(rootView.edgesIgnoringSafeArea(.all)))

        super.init(frame: .zero)

        rootViewHostingController.view.backgroundColor = .clear

        addSubview(rootViewHostingController.view)

        let superView = rootViewHostingController.view.superview!

        rootViewHostingController.view.translatesAutoresizingMaskIntoConstraints = false

        rootViewHostingController.view.topAnchor.constraint(equalTo: superView.topAnchor, constant: 0).isActive = true
        rootViewHostingController.view.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive =
            true
        rootViewHostingController.view.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 0).isActive =
            true
        rootViewHostingController.view.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0)
            .isActive = true
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
        rootViewHostingController.view.sizeThatFits(targetSize)
    }

    public override var intrinsicContentSize: CGSize {
        if let superview = superview {
            if let scrollView = superview as? UIScrollView {
                return rootViewHostingController.view.sizeThatFits(scrollView.contentSize)
            }

            return rootViewHostingController.view.sizeThatFits(.zero)
        } else {
            return rootViewHostingController.view.sizeThatFits(.zero)
        }
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
        if let superview = superview {
            frame.size = rootViewHostingController.sizeThatFits(in: superview.frame.size)
        } else {
            frame.size = rootViewHostingController.sizeThatFits(in: .zero)
        }
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

    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.view.invalidateIntrinsicContentSize()
    }
}
