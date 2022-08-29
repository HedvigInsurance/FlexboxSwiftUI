//
//  JustifyContent.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-22.
//

import Foundation
import SwiftUI
import FlexboxSwiftUI

struct ViewDebugData {
    let data: [_ViewDebug.Property: Any]
    let childData: [ViewDebugData]
}

struct SizeReadable<Content: View>: UIViewRepresentable {
    var content: Content
    
    class Coordinator {
        var hostingController: UIHostingController<Content>
        
        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(hostingController: UIHostingController(rootView: content))
    }

    func makeUIView(context: Context) -> UIView {
        return context.coordinator.hostingController.view
    }


    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
struct SizeThatFitsCalculatorLayout: _VariadicView_UnaryViewRoot {
    @ViewBuilder
    func body(children: _VariadicView.Children) -> some View {
        
        ForEach(children) { child in
            child
            SizeReadable(content: child).position()
        }
    }
}

struct SizeThatFitsCalculator<Content: View>: View {
    var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        _VariadicView.Tree(SizeThatFitsCalculatorLayout()) {
            content
        }
    }
}

struct JustifyContent: View {
    @State var modifySize = false
    
    var body: some View {
        Button("Modify container size") {
            withAnimation(.spring()) {
                modifySize.toggle()
            }
        }
        
        SizeThatFitsCalculator {
            ViewThatChangesHeight()
        }
                
        //HostingViewRepresentble()
        
       
        
        if #available(iOS 16, *) {
            FlexViewLayout(node: Node(
                size: Size(width: .percent(50), height: .fixed(modifySize ? 300 : 100)),
                children: [
                    Node(
                        size: Size(width: .auto, height: .auto),
                        flexGrow: 1,
                        view: AnyView(ViewThatChangesHeight())
                    ),
                    Node(
                        size: Size(width: .auto, height: .auto),
                        flexGrow: 1,
                        view: AnyView(ViewThatChangesHeight())
                    )
                ],
                flexDirection: .column
            )).background(Color.yellow)
        }
    }
}
