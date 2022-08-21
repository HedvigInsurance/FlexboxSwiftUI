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
                .frame(width: layout.frame.width, height: layout.frame.height * 2)
                .clipped()
                .position(
                    x: layout.frame.origin.x + (layout.frame.width / 2),
                    y: layout.frame.origin.y + (layout.frame.height / 2)
                )
        } else {
            paddedContent
                .frame(width: layout.frame.width, height: layout.frame.height)
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

    func makeUIView(context: Context) -> some UIView {
        let hostingController = store.views[child]!
        hostingController.setEnvironment(context.environment)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = true

        return hostingController.view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        let hostingController = store.views[child]!
        
        let view = hostingController.view!
        
        DispatchQueue.main.async {
            guard let superview = view.superview else {
                return
            }
            context.coordinator.addChildController(superview)
        }
    }
}

struct LayoutRenderer: View {
    @EnvironmentObject var store: HostingViewStore
    var layout: Layout
    var applyPosition: Bool

    var body: some View {
        return ZStack {
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

public struct FlexView: View {
    @StateObject var store: HostingViewStore

    var node: Node

    public init(
        node: Node
    ) {
        self.node = node
        let store = HostingViewStore()
        store.node = node.createUnderlyingNode(store: store)
        self._store = StateObject(wrappedValue: store)
    }

    func readMaxSize(_ proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            store.setMaxSize(
                CGSize(
                    width: proxy.size.width == 0 ? .nan : min(proxy.size.width, store.screenMaxWidth),
                    height: .nan
                )
            )
        }

        return ZStack {
            Color.clear
        }
    }

    public var body: some View {
        let layout = node.layout(
            node: store.node!,
            maxSize: store.maxSize,
            store: store
        )
        
        return ZStack {
            Color.clear
                .frame(maxWidth: .infinity, maxHeight: 10)
                .background(GeometryReader(content: readMaxSize))

            LayoutRenderer(layout: layout, applyPosition: false)
                .environmentObject(store)
        }
        .frame(maxWidth: store.screenMaxWidth)
        .onReceive(
            NotificationCenter.default.publisher(
                for: UIDevice.orientationDidChangeNotification
            )
        ) { _ in
            store.screenMaxWidth = UIScreen.main.bounds.width
        }
    }
}
