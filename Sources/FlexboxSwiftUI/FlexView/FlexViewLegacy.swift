//
//  ContentView.swift
//  FlexboxPlayground
//
//  Created by Sam Pettersson on 2022-08-18.
//

import SwiftUI

struct LayoutViewModifier: ViewModifier {
    @EnvironmentObject var store: HostingViewStore
    var offset: Int

    func body(content: Content) -> some View {
        if let layout = store.layout?.children[offset] {
            content
            .padding(.leading, layout.padding.left)
            .padding(.trailing, layout.padding.right)
            .padding(.top, layout.padding.top)
            .padding(.bottom, layout.padding.bottom)
            .frame(
                width: layout.frame.width,
                height: layout.frame.height,
                alignment: .topLeading
            )
            .position(
                x: layout.frame.origin.x + (layout.frame.width / 2),
                y: layout.frame.origin.y + (layout.frame.height / 2)
            )
        } else {
            content
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
    var layout: FlexLayout?
    
    init(hostingView: UIView) {
        self.layout = nil
        super.init(frame: .zero)
        
        self.addSubview(hostingView)
        
        self.backgroundColor = .clear
        
        self.setContentHuggingPriority(.required, for: .vertical)
        self.setContentHuggingPriority(.required, for: .horizontal)
        
        self.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

struct HostedChild: UIViewRepresentable, Equatable {
    static func == (lhs: HostedChild, rhs: HostedChild) -> Bool {
        lhs.offset == rhs.offset
    }
    
    @EnvironmentObject var store: HostingViewStore
    var offset: Int

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
        let child = store.node.children[offset].view!
        let hostingController = store.views[child]!
        return Coordinator(hostingController: hostingController)
    }

    func makeUIView(context: Context) -> HostedChildViewWrapper {
        let view = HostedChildViewWrapper(
            hostingView: context.coordinator.hostingController.view
        )
        context.coordinator.hostingController.setEnvironment(context.environment)
        
        context.coordinator.hostingController.view.constrainEdges(to: view)
        
        return view
    }

    func updateUIView(_ uiView: HostedChildViewWrapper, context: Context) {
        DispatchQueue.main.async {
            guard let superView = uiView.superview else {
                return
            }
            context.coordinator.addChildController(superView)
        }
    }
}

struct ChildRenderer: View, Equatable {
    var offset: Int

    var body: some View {
        if #available(iOS 15.0, *) {
            let _ = Self._printChanges()
        }
        
        HostedChild(offset: offset).modifier(
            LayoutViewModifier(offset: offset)
        )
    }
}

class ExpandingUIView: UIView {
    var flexibilityAxies: [Axis]
    
    init(flexibilityAxies: [Axis]) {
        self.flexibilityAxies = flexibilityAxies
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(
            width: flexibilityAxies.contains(.horizontal) ? UIView.layoutFittingExpandedSize.width : 0,
            height: flexibilityAxies.contains(.vertical) ? UIView.layoutFittingExpandedSize.height : 0
        )
    }
}

struct ExpandingView: UIViewRepresentable {
    var flexibilityAxies: [Axis]
    
    func makeUIView(context: Context) -> ExpandingUIView {
        let view = ExpandingUIView(flexibilityAxies: flexibilityAxies)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        view.setContentHuggingPriority(.required, for: .vertical)
        view.setContentHuggingPriority(.required, for: .horizontal)
        return view
    }
    
    func updateUIView(_ uiView: ExpandingUIView, context: Context) {
        uiView.flexibilityAxies = flexibilityAxies
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        uiView.setContentHuggingPriority(.required, for: .vertical)
        uiView.setContentHuggingPriority(.required, for: .horizontal)
        uiView.invalidateIntrinsicContentSize()
    }
}

struct HeightFrameModifier: ViewModifier {
    @EnvironmentObject var store: HostingViewStore
    var height: SizeType
    
    func body(content: Content) -> some View {
        switch height {
        case .undefined, .auto:
            content.frame(
                maxHeight: .infinity,
                alignment: .topLeading
            )
        case let .fixed(fixedHeight):
            content.frame(
                height: fixedHeight,
                alignment: .topLeading
            )
        case let .percent(percent):
            if let maxSize = store.maxSize {
                content.frame(
                    height: maxSize.height * (percent / 100),
                    alignment: .topLeading
                )
            } else {
                content
            }
        }
    }
}

struct WidthFrameModifier: ViewModifier {
    @EnvironmentObject var store: HostingViewStore
    var width: SizeType
    
    func body(content: Content) -> some View {
        switch width {
        case .undefined, .auto:
            content.frame(
                maxWidth: .infinity,
                alignment: .topLeading
            )
        case let .fixed(fixedHeight):
            content.frame(
                width: fixedHeight,
                alignment: .topLeading
            )
        case let .percent(percent):
            if let maxSize = store.maxSize {
                content.frame(
                    width: maxSize.width * (percent / 100),
                    alignment: .topLeading
                )
            } else {
                content
            }
        }
    }
}

struct MaxSizeFrameModifier: ViewModifier {
    var node: Node
    
    func body(content: Content) -> some View {
        content
            .modifier(HeightFrameModifier(height: node.maxSize.height))
            .modifier(WidthFrameModifier(width: node.maxSize.width))
    }
}

public struct RenderChildren: View, Equatable {
    var count: Int
    
    var children: [Int] {
        Array(repeating: "", count: count).enumerated().map { offset, _ in
            offset
        }
    }
    
    public var body: some View {
        if #available(iOS 15.0, *) {
            let _ = Self._printChanges()
        }
        ForEach(children, id: \.self) { offset in
            ChildRenderer(offset: offset)
        }
    }
}

public struct FlexViewLegacy: View {
    public init(store: HostingViewStore) {
        self.store = store
    }
    
    @ObservedObject var store: HostingViewStore
    @Environment(\.markDirty) var parentMarkDirty
    @Environment(\.currentLayout) var currentLayout
    
    func updateMaxSize(_ proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            if proxy.size != store.maxSize {
                store.maxSize = proxy.size
            }
        }
        
        return Color.clear
    }

    public var body: some View {
        if #available(iOS 15.0, *) {
            let _ = Self._printChanges()
        }
        
        return ZStack(alignment: .topLeading) {
            if currentLayout == nil {
                ExpandingView(
                    flexibilityAxies: [
                        .horizontal,
                        !store.node.isFlexibleHeight ? .vertical : nil
                    ].compactMap { $0 }
                ).background(GeometryReader { proxy in
                    updateMaxSize(proxy)
                })
            }
            
            RenderChildren(count: store.node.children.count)
        }
        .environmentObject(store)
        .clipped()
    }
}
