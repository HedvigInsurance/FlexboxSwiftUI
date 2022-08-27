//
//  ContentView.swift
//  FlexboxPlayground
//
//  Created by Sam Pettersson on 2022-08-18.
//

import SwiftUI

struct LayoutViewModifier: ViewModifier {
    var layout: Layout
    var applyPosition: Bool

    func body(content: Content) -> some View {
        let paddedContent =
            content
            .padding(.leading, layout.padding.left)
            .padding(.trailing, layout.padding.right)
            .padding(.top, layout.padding.top)
            .padding(.bottom, layout.padding.bottom)
        
        if applyPosition {
            paddedContent
                .frame(width: layout.frame.width, height: layout.frame.height, alignment: .topLeading)
                .clipped()
                .position(
                    x: layout.frame.origin.x + (layout.frame.width / 2),
                    y: layout.frame.origin.y + (layout.frame.height / 2)
                )
        } else {
            paddedContent
                .frame(width: layout.frame.width, height: layout.frame.height, alignment: .topLeading)
                .clipped()
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}

extension UIView {
    func constrainEdges(to other: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: other.leadingAnchor),
            trailingAnchor.constraint(equalTo: other.trailingAnchor),
            topAnchor.constraint(equalTo: other.topAnchor),
            bottomAnchor.constraint(equalTo: other.bottomAnchor)
        ])
    }
}

class HostedChildViewWrapper: UIView {
    var coordinator: HostedChild.Coordinator
    var previousSize: CGSize? = nil
    
    init(coordinator: HostedChild.Coordinator, hostingView: UIView) {
        self.coordinator = coordinator
        super.init(frame: .zero)
        
        self.addSubview(hostingView)
        
        hostingView.translatesAutoresizingMaskIntoConstraints = false        
    }
    
    override var intrinsicContentSize: CGSize {
        subviews.first?.intrinsicContentSize ?? .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var layoutWidth: CGFloat {
        if let layout = coordinator.hostingController.layout {
            return layout.frame.size.width - layout.padding.left - layout.padding.right
        }
        
        return .zero
    }
    
    var layoutHeight: CGFloat {
        if let layout = coordinator.hostingController.layout {
            return  layout.frame.size.height - layout.padding.top - layout.padding.bottom
        }
        
        return .zero
    }
    
    func calculateSizeThatFits() -> CGSize {
        if let hostingView = subviews.first {
            return hostingView.sizeThatFits(CGSize(width: layoutWidth, height: layoutHeight))
        }
        
        return .zero
    }
    
    func updateFrame() {
        if let hostingView = subviews.first {
            let layoutWidth = coordinator.hostingController.layout?.frame.width ?? 0
            let layoutHeight = coordinator.hostingController.layout?.frame.height ?? 0
            
            let sizeThatFits = hostingView.sizeThatFits(
                CGSize(width: layoutWidth, height: layoutHeight)
            )
            
            hostingView.center = .zero
            hostingView.frame = CGRect(
                x: 0,
                y: 0,
                width: sizeThatFits.width,
                height: sizeThatFits.height
            )
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
}

struct HostedChild: UIViewRepresentable {
    @EnvironmentObject var store: HostingViewStore
    var layout: Layout
    var offset: NodeOffset

    class Coordinator {
        var hostingController: AdjustableHostingController

        func addChildController(_ uiView: UIView) {
            guard
                let parentController = uiView.parentViewController
            else {
                return
            }
            
            let requiresControllerMove = hostingController.parent != parentController
            if requiresControllerMove {
                parentController.addChild(hostingController)
            }

            if requiresControllerMove {
                hostingController.didMove(toParent: parentController)
            }
        }

        init(
            hostingController: AdjustableHostingController
        ) {
            self.hostingController = hostingController
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(hostingController: store.views[offset]!)
    }

    func makeUIView(context: Context) -> HostedChildViewWrapper {
        let hostingController = store.views[offset]!
        hostingController.setEnvironment(context.environment)
        
        return HostedChildViewWrapper(
            coordinator: context.coordinator,
            hostingView: hostingController.view
        )
    }
    
    func _overrideSizeThatFits(
        _ size: inout CoreGraphics.CGSize,
        in proposedSize: SwiftUI._ProposedSize,
        uiView: HostedChildViewWrapper
    ) {
        let sizeThatFits = uiView.calculateSizeThatFits()

        size = CGSize(
            width: min(uiView.layoutWidth, sizeThatFits.width),
            height: min(uiView.layoutHeight, sizeThatFits.height)
        )
    }

    func updateUIView(_ uiView: HostedChildViewWrapper, context: Context) {
        uiView.invalidateIntrinsicContentSize()
        context.coordinator.hostingController.layout = layout
                
        if let hostingController = store.views[offset] {
            hostingController.view.invalidateIntrinsicContentSize()
            hostingController.view.setNeedsLayout()
            hostingController.view.layoutIfNeeded()
            
            DispatchQueue.main.async {
                guard let superview = hostingController.view.superview else {
                    return
                }
                context.coordinator.addChildController(superview)
            }
        }
    }
}

struct LayoutRenderer: View {
    @EnvironmentObject var store: HostingViewStore
    var layout: Layout
    var applyPosition: Bool
    var nodeOffset: NodeOffset?
    
    var body: some View {
        Group {
            if layout.view != nil, let nodeOffset = nodeOffset {
                HostedChild(
                    layout: layout,
                    offset: nodeOffset
                ).fixedSize()
            } else {
                ForEach(Array(layout.children.enumerated()), id: \.offset) { offset, childLayout in
                    if let nodeOffset = nodeOffset {
                        LayoutRenderer(
                            layout: childLayout,
                            applyPosition: true,
                            nodeOffset: nodeOffset.makeInner(offset: offset)
                        )
                    } else {
                        LayoutRenderer(
                            layout: childLayout,
                            applyPosition: true,
                            nodeOffset: NodeOffset(offset: offset)
                        )
                    }
                }
            }
        }
        .modifier(LayoutViewModifier(layout: layout, applyPosition: applyPosition))
    }
}

public struct FlexViewLegacy: View {
    @StateObject var store = HostingViewStore()

    var node: Node

    public init(
        node: Node
    ) {
        self.node = node
    }

    public var body: some View {
        if node != store.node {
            store.node = node
        }
        
        UIView.swizzleLayoutHandler()
        
        return ZStack(alignment: .topLeading) {
            SizeReaderView { size in
                store.setMaxSize(size)
            }
            
            if let layout = store.calculateLayout() {
                LayoutRenderer(layout: layout, applyPosition: false)
                .position(
                    x: layout.frame.origin.x + (layout.frame.width / 2),
                    y: layout.frame.origin.y + (layout.frame.height / 2)
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .environmentObject(store)
    }
}
