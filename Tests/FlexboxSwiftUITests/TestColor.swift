//
//  TestColor.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-23.
//

import Foundation
import SwiftUI

class ColorView: UIView {
    override var intrinsicContentSize: CGSize {
        CGSize(width: 100000, height: 100000)
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
