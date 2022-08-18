//
//  ContentView.swift
//  FlexboxPlayground
//
//  Created by Sam Pettersson on 2022-08-18.
//

import SwiftUI
import StretchKit

extension Size where T == Float {
    var cgSize: CGSize {
        CGSize(width: CGFloat(width), height: CGFloat(height))
    }
}

extension Size where T == Float? {
    var cgSize: CGSize {
        CGSize(width: CGFloat(width ?? 0), height: CGFloat(height ?? 0))
    }
}

extension CGSize {
    var size: Size<Float> {
        Size(width: Float(width), height: Float(height))
    }
    
    var sizeOptional: Size<Float?> {
        Size(width: width == 0 ? nil : Float(width), height: height == 0 ? nil : Float(height))
    }
}

extension StretchKit.Dimension {
    var pointsValue: CGFloat? {
        switch self {
        case let .points(float):
            return CGFloat(float)
        default:
            return nil
        }
    }
}


struct FlexContainer: View {
    internal init(
        sizeThatFits: Size<Float?>,
        style: Style,
        children: [(style: Style, view: AnyView)]
    ) {
        self.sizeThatFits = sizeThatFits
        self.style = style
        self.children = children
        self.node = Self.makeNode(style: style, calculatedChildSizes: [:], children: children)
    }
    
    static func makeNode(
        style: Style,
        calculatedChildSizes: [Int: CGSize],
        children: [(style: Style, view: AnyView)]
    ) -> Node {
        Node(style: style, children: children.enumerated().map { offset, child in
            Node(
                style: child.style
            ) { suggestedSize in
                if let childSize = calculatedChildSizes[offset] {
                    return childSize.size
                }
                
                let hostingView = HostingView(
                    rootView: child.view
                )
            
                var width: CGFloat {
                    if let width = suggestedSize.width {
                        return CGFloat(width)
                    } else {
                        return UIView.layoutFittingCompressedSize.width
                    }
                }
                
                var height: CGFloat {
                    if let height = suggestedSize.height {
                        return CGFloat(height)
                    } else {
                        return UIView.layoutFittingExpandedSize.height
                    }
                }
                                    
                let sizeThatFits = hostingView.systemLayoutSizeFitting(
                    CGSize(
                        width: width,
                        height: height
                    ),
                    withHorizontalFittingPriority: suggestedSize.width != nil ? .defaultHigh : .defaultLow,
                    verticalFittingPriority: .defaultLow
                )
                                                                                            
                return sizeThatFits.size
            }
        })
    }
    
    var sizeThatFits: Size<Float?>
    var style: Style
    var children: [(style: Style, view: AnyView)]
    
    @ViewBuilder static func applyPadding(child: (style: Style, view: AnyView)) -> some View {
        child.view
            .padding(.leading, child.style.padding.start.pointsValue ?? 0)
            .padding(.trailing, child.style.padding.end.pointsValue ?? 0)
            .padding(.top, child.style.padding.top.pointsValue ?? 0)
            .padding(.bottom, child.style.padding.bottom.pointsValue ?? 0)
    }
    
    @State var calculatedChildSizes: [Int: CGSize] = [:]
    @State var node: Node
    
    func useProxy(offset: Int, _ proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            calculatedChildSizes[offset] = proxy.size
            self.node = Self.makeNode(
                style: style,
                calculatedChildSizes: calculatedChildSizes,
                children: children
            )
        }
        
        return Color.clear
    }
    
    var body: some View {
        let layout = node.computeLayout(thatFits: sizeThatFits)
        
        return ZStack {
            ForEach(Array(layout.children.enumerated()), id: \.offset) { offset, layout in
                FlexChild(
                    layout: layout
                ) {
                    Self.applyPadding(child: children[offset]).background(
                        GeometryReader { proxy in
                            useProxy(offset: offset, proxy)
                        }
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .frame(width: CGFloat(layout.width), height: CGFloat(layout.height))
    }
}

struct FlexChild<Content: View>: View {
    var layout: Layout
    var content: () -> Content
    
    var body: some View {
        ZStack {
            content()
        }
        .frame(width: CGFloat(layout.width), height: CGFloat(layout.height))
        .clipped()
        .position(x: CGFloat(layout.x + (layout.width / 2)), y: CGFloat(layout.y + (layout.height / 2)))
    }
}

struct ViewWithState: View {
    @State var increment = 0
    
    var body: some View {
        VStack {
            Text(String(increment))
            
            Color.cyan.frame(width: CGFloat(increment * 10))
            
            Button("A button", action: {
                increment = increment + 1
            }).fixedSize(horizontal: true, vertical: false)
        }.frame(maxWidth: .infinity)
    }
}

public struct FlexView: View {
    public init(
        style: Style,
        children: [(style: Style, view: AnyView)],
        maxSize: Size<Float?>? = nil
    ) {
        self.style = style
        self.children = children
        self._maxSize = State(initialValue: maxSize)
    }
    
    @State private var maxSize: Size<Float?>? = nil
    var style: Style
    var children: [(style: Style, view: AnyView)]
    
    private func useProxy(_ geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            if (geometry.size != maxSize?.cgSize) {
                maxSize = geometry.size.sizeOptional
            }
        }

        return Color.clear
    }
    
    public var body: some View {
        ZStack {
            Color.clear.background(
                GeometryReader { geometry in
                    useProxy(geometry)
                }
            )
            
            if let maxSize = maxSize {
                FlexContainer(
                    sizeThatFits: maxSize,
                    style: style,
                    children: children
                )
            }
        }
    }
}
