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
        var hostingController: UIHostingController<AnyView>
        var hasAddedChildController = false

        func addChildController(_ uiView: UIView) {
            guard let parentController = uiView.parentViewController else {
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
            hostingController: UIHostingController<AnyView>
        ) {
            self.hostingController = hostingController
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(hostingController: store.views[child]!.rootViewHostingController)
    }

    func makeUIView(context: Context) -> some UIView {
        store.views[child]!.swiftUIRootView = AnyView(
            child.view.modifier(
                TransferEnvironment(environment: context.environment)
            )
        )

        let view = store.views[child]!.rootViewHostingController.view!

        DispatchQueue.main.async {
            context.coordinator.addChildController(view.superview!)
        }

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
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
                .environment(\.withFlexAnimation) { animation, body in
                    withAnimation(animation) {
                        store.forceUpdate()
                        body()
                    }
                }
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
        self._store = StateObject(wrappedValue: HostingViewStore())
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
            maxSize: store.maxSize,
            store: store
        )

        return ZStack {
            Color.clear
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
