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

struct LayoutRenderer: View {
    var layout: Layout
    var applyPosition: Bool
    
    var body: some View {
        ZStack {
            if let view = layout.view {
                view
            } else {
                ForEach(Array(layout.children.enumerated()), id: \.offset) { offset, childLayout in
                    LayoutRenderer(layout: childLayout, applyPosition: true)
                }
            }
        }
        .modifier(LayoutViewModifier(layout: layout, applyPosition: applyPosition))
    }
}


struct FlexView: View {
    var node: Node
    
    @State var maxSize: CGSize? = nil
    
    func readMaxSize(_ proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.maxSize = proxy.size
        }
        
        return Color.clear
    }
    
    var body: some View {
        let layout = node.layout(maxSize: maxSize)
        
        return ZStack {
            // Read max available intrinsic size
            Color.clear.background(GeometryReader(content: readMaxSize))
            
            if maxSize != nil {
                LayoutRenderer(layout: layout, applyPosition: false)
            }
        }
    }
}
