//
//  CenterContent.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-23.
//

import Foundation
import FlexboxSwiftUI
import SwiftUI

class ColorView: UIView {
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
}

struct TestColor: UIViewRepresentable {
    var color: Color
    
    func makeUIView(context: Context) -> some UIView {
        ColorView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        uiView.backgroundColor = UIColor(color)
    }
}

struct CenterContent: View {
    var body: some View {
        if #available(iOS 16, *) {
            FlexViewLayout(node: Node(
                size: Size(width: .percent(100), height: .percent(100)),
                children: [
                    Node(
                        size: Size(width: .percent(20), height: .percent(100)),
                        view: FlexChild(TestColor(color: .red))
                    )
                ],
                justifyContent: .center
            )).frame(height: 100)
        }
        
        FlexViewLegacy(node: Node(
            size: Size(width: .percent(100), height: .percent(100)),
            children: [
                Node(
                    size: Size(width: .percent(20), height: .percent(100)),
                    view: FlexChild(TestColor(color: .red))
                )
            ],
            justifyContent: .center
        )).frame(height: 100)
        
        if #available(iOS 16, *) {
            FlexViewLayout(
                node: Node(
                    size: Size(width: .percent(100), height: .percent(100)),
                    children: [
                        Node(
                            flexGrow: 1,
                            view: FlexChild(
                                Button(
                                    "Some button text",
                                    action: {
                                        
                                    }
                                )
                            )
                        ),
                        Node(
                            flexGrow: 1,
                            view: FlexChild(
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
        
        FlexViewLegacy(
            node: Node(
                    size: Size(width: .percent(100), height: .percent(100)),
                    children: [
                        Node(
                            flexGrow: 1,
                            view: FlexChild(
                                Button(
                                    "Some button text",
                                    action: {

                                    }
                                )
                            )
                        ),
                        Node(
                            flexGrow: 1,
                            view: FlexChild(
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
