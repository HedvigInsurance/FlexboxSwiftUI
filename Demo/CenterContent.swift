//
//  CenterContent.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-23.
//

import Foundation
import FlexboxSwiftUI
import SwiftUI

struct TestColor: UIViewRepresentable {
    var color: Color
    
    func makeUIView(context: Context) -> UIView {
        UIView(frame: .zero)
    }
    
    func _overrideSizeThatFits(_ size: inout CoreGraphics.CGSize, in proposedSize: SwiftUI._ProposedSize, uiView: UIView) {
        size = CGSize(width: proposedSize.width, height: proposedSize.height)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        uiView.setContentHuggingPriority(.required, for: .horizontal)
        uiView.setContentHuggingPriority(.required, for: .vertical)
        
        uiView.backgroundColor = UIColor(color)
    }
}

struct CenterContent: View {
    var body: some View {
        RenderBothImplementations(node: Node(
            size: Size(width: .percent(100), height: .percent(100)),
            children: [
                Node(
                    size: Size(width: .percent(20), height: .percent(100)),
                    view: AnyView(TestColor(color: .red))
                )
            ],
            justifyContent: .center
        )).frame(height: 100)
        
        RenderBothImplementations(
            node: Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(
                        flexGrow: 1,
                        view: AnyView(
                            Button(
                                "Some button text",
                                action: {
                                    
                                }
                            )
                        )
                    ),
                    Node(
                        flexGrow: 1,
                        view: AnyView(
                            Button(
                                "Some other text",
                                action: {
                                    
                                }
                            )
                        )
                    ),
                ]
            )
        ).frame(height: 100)
    }
}
