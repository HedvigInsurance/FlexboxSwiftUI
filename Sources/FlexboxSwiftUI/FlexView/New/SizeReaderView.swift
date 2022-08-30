//
//  SizeReaderView.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import SwiftUI

class ZeroSizeView: UIView {
    var transaction: Transaction? = nil
    var proposedSize: CGSize? = nil
    var onSize: (_ size: CGSize) -> Void = { _ in }
    
    override var intrinsicContentSize: CGSize {
        .zero
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let proposedSize = proposedSize {
            onSize(proposedSize)
        }
    }
}

struct SizeReaderView: UIViewRepresentable {
    @EnvironmentObject var coordinator: FlexCoordinator
    var onSize: (_ size: CGSize) -> Void
    
    func makeUIView(context: Context) -> ZeroSizeView {
        let view = ZeroSizeView()
        view.onSize = onSize
        return view
    }
    
    func updateUIView(_ uiView: ZeroSizeView, context: Context) {
        uiView.onSize = onSize
        uiView.transaction = context.transaction
    }
    
    func _overrideSizeThatFits(_ size: inout CoreGraphics.CGSize, in proposedSize: SwiftUI._ProposedSize, uiView: ZeroSizeView) {
        let proposedSize = CGSize(width: proposedSize.width, height: proposedSize.height)
        size = proposedSize
        uiView.proposedSize = proposedSize
    }
}
