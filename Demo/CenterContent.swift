//
//  CenterContent.swift
//  Demo
//
//  Created by Sam Pettersson on 2022-08-23.
//

import FlexboxSwiftUI
import Foundation
import SwiftUI

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
        FlexStack {
            FlexItem(
                size: Size(width: .percent(100), height: .percent(100)),
                justifyContent: .center

            ) {
                FlexItem(
                    size: Size(width: .percent(20), height: .percent(100))

                ) {
                    TestColor(color: .red)
                }
            }
        }
        .frame(height: 100)
    }
}
