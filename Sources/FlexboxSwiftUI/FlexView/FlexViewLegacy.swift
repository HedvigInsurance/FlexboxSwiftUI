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
    var layout: Layout
    
    init(layout: Layout, hostingView: UIView) {
        self.layout = layout
        super.init(frame: .zero)
        
        self.addSubview(hostingView)
        
        self.setContentHuggingPriority(.required, for: .vertical)
        self.setContentHuggingPriority(.required, for: .horizontal)
        
        hostingView.constrainEdges(to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let width = layout.frame.size.width - layout.padding.left - layout.padding.right
        let height = layout.frame.size.height - layout.padding.top - layout.padding.bottom
        
        let size = subviews.first?.sizeThatFits(CGSize(
            width: width,
            height: height
        )) ?? .zero
                        
        return size
    }
}

struct HostedChild: UIViewRepresentable {
    @EnvironmentObject var store: HostingViewStore
    var layout: Layout
    var child: FlexChild

    class Coordinator {
        var hostingController: AdjustableHostingController
        var hasAddedChildController = false
        var heightConstraint: NSLayoutConstraint? = nil
        var widthConstraint: NSLayoutConstraint? = nil

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
        Coordinator(hostingController: store.views[child]!)
    }

    func makeUIView(context: Context) -> HostedChildViewWrapper {
        let hostingController = store.views[child]!
        hostingController.setEnvironment(context.environment)
        
        return HostedChildViewWrapper(layout: layout, hostingView: hostingController.view)
    }

    func updateUIView(_ uiView: HostedChildViewWrapper, context: Context) {
        uiView.layout = layout
        uiView.invalidateIntrinsicContentSize()
        
        if let hostingController = store.views[child] {
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

    var body: some View {
        Group {
            if let view = layout.view {
                HostedChild(
                    layout: layout,
                    child: view
                )
            } else {
                ForEach(Array(layout.children.enumerated()), id: \.offset) { offset, childLayout in
                    LayoutRenderer(layout: childLayout, applyPosition: true)
                }
            }
        }
        .modifier(LayoutViewModifier(layout: layout, applyPosition: applyPosition))
    }
}

public struct FlexViewLegacy: View {
    @StateObject var store: HostingViewStore
    @Environment(\.markDirty) var parentMarkDirty

    var node: Node

    public init(
        node: Node
    ) {
        self.node = node
        let store = HostingViewStore(node: node)
        store._node = node.createUnderlyingNode()
        self._store = StateObject(wrappedValue: store)
    }

    func readMaxSize(_ proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            store.setMaxSize(
                proxy.size
            )
        }
        
        return Color.clear
    }

    public var body: some View {
        if node != store.node {
            store.node = node
        }
        
        return ZStack(alignment: .topLeading) {
            if let layout = store.calculateLayout() {                
                LayoutRenderer(layout: layout, applyPosition: false)
                    .environmentObject(store)
            }
            
            Color.clear.frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            ).background(GeometryReader(content: readMaxSize))
        }
        .frame(maxWidth: store.screenMaxWidth)
        .onReceive(
            NotificationCenter.default.publisher(
                for: UIDevice.orientationDidChangeNotification
            )
        ) { _ in
            store.screenMaxWidth = UIScreen.main.bounds.width
            store.setMaxSize(nil)
        }
    }
}
