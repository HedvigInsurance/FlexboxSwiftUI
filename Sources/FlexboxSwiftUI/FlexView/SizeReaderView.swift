//
//  SizeReaderView.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import SwiftUI

class ZeroSizeView: UIView {
    var updateTime: Date? = nil
    var coordinator: FlexCoordinator?
    var proposedSize: CGSize? = nil {
        didSet {
            coordinator?.rootNode?.isDirty = true
        }
    }
    
    override var intrinsicContentSize: CGSize {
        .zero
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

struct SizeReaderView: UIViewRepresentable {
    @EnvironmentObject var coordinator: FlexCoordinator
    var updateTime = Date()
    
    func makeUIView(context: Context) -> ZeroSizeView {
        let view = ZeroSizeView()
        coordinator.readMaxSize = {
            view.proposedSize ?? .zero
        }
        return view
    }
    
    func updateUIView(_ uiView: ZeroSizeView, context: Context) {
        coordinator.readMaxSize = {
            return uiView.proposedSize ?? .zero
        }
        uiView.coordinator = coordinator
    }
    
    func _overrideSizeThatFits(_ size: inout CoreGraphics.CGSize, in proposedSize: SwiftUI._ProposedSize, uiView: ZeroSizeView) {
        let proposedSize = CGSize(width: proposedSize.width, height: proposedSize.height)
        size = proposedSize
        uiView.updateTime = updateTime
        uiView.proposedSize = proposedSize
    }
}
