//
//  CenterContent.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-23.
//

import FlexboxSwiftUI
import Foundation
import SwiftUI

extension SwiftUI._ProposedSize {
    public var height: CGFloat? {
        Mirror(reflecting: self).children.compactMap { label, value in
            label == "height" ? value as? CGFloat : nil
        }.first
    }
    
    public var width: CGFloat? {
        Mirror(reflecting: self).children.compactMap { label, value in
            label == "width" ? value as? CGFloat : nil
        }.first
    }
}

struct TestColor: UIViewRepresentable {
    var color: Color

    func makeUIView(context: Context) -> UIView {
        UIView(frame: .zero)
    }

    func _overrideSizeThatFits(
        _ size: inout CoreGraphics.CGSize,
        in proposedSize: SwiftUI._ProposedSize,
        uiView: UIView
    ) {
        size = CGSize(width: proposedSize.width ?? 0, height: proposedSize.height ?? 0)
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
        FlexStack(
            size: Size(width: .percent(100), height: .percent(100)),
            justifyContent: .center
        ) {
            TestColor(color: .red).flexStyle(
                size: Size(width: .percent(20), height: .percent(100))
            )
        }
        .frame(height: 100)
    }
}
