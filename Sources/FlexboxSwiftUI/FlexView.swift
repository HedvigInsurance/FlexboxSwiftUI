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
        let paddedContent = content
            .padding(.leading, layout.padding.left)
            .padding(.trailing, layout.padding.right)
            .padding(.top, layout.padding.top)
            .padding(.bottom, layout.padding.bottom)
        
        if applyPosition {
            paddedContent
                .frame(width: layout.frame.width, height: layout.frame.height)
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

struct HostedChild: UIViewRepresentable {
    var store: HostingViewStore
    var layout: Layout
    var child: FlexChild
    
    func makeUIView(context: Context) -> some UIView {
        store.views[child]!.swiftUIRootView = AnyView(
            child.view.modifier(TransferEnvironment(environment: context.environment))
        )
        
        return store.views[child]!.rootViewHostingController.view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct LayoutRenderer: View {
    var store: HostingViewStore
    var layout: Layout
    var applyPosition: Bool
    
    var body: some View {
        return ZStack {
            if let view = layout.view {
                HostedChild(store: store, layout: layout, child: view).environment(\.withFlexAnimation) { animation, body in
                    withAnimation(animation) {
                        store.forceUpdate()
                        body()
                    }
                }
            } else {
                ForEach(Array(layout.children.enumerated()), id: \.offset) { offset, childLayout in
                    LayoutRenderer(store: store, layout: childLayout, applyPosition: true)
                }
            }
        }
        .modifier(LayoutViewModifier(layout: layout, applyPosition: applyPosition))
    }
}


public struct FlexView: View {
    @StateObject var store: HostingViewStore
    
    public init(node: Node) {
        self._store = StateObject(wrappedValue: HostingViewStore(node: node))
    }
    
    func readMaxSize(_ proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            store.setMaxSize(CGSize(
                width: proxy.size.width == 0 ? .nan : min(proxy.size.width, store.screenMaxWidth),
                height: .nan
            ))
        }
        
        return ZStack {
            Color.clear
        }
    }
    
    public var body: some View {
        let layout = store.node.layout(
            maxSize: store.maxSize,
            store: store
        )
        
        print(store.count)
        
        if #available(iOS 15.0, *) {
            print(Self._printChanges())
        }
        
        return ZStack {
            Color.clear
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(GeometryReader(content: readMaxSize))
            
            ZStack {
                LayoutRenderer(store: store, layout: layout, applyPosition: false)
            }
        }
        .frame(maxWidth: store.screenMaxWidth)
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            store.screenMaxWidth = UIScreen.main.bounds.width
        }
    }
}
