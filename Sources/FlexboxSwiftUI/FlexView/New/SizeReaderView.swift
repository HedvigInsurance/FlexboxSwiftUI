//
//  SizeReaderView.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import SwiftUI

struct SizeReaderView: UIViewRepresentable {
    @EnvironmentObject var coordinator: FlexCoordinator
    var onSize: (_ size: CGSize) -> Void
    
    func makeUIView(context: Context) -> UIView {
        UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func _overrideSizeThatFits(_ size: inout CoreGraphics.CGSize, in proposedSize: SwiftUI._ProposedSize, uiView: UIView) {
        guard proposedSize.height > 0 else {
            return
        }
        
        let proposedSize = CGSize(width: proposedSize.width, height: proposedSize.height)
        
        size = coordinator.layout?.frame.size ?? .zero
                
        if proposedSize != size {
            onSize(proposedSize)
        }
    }
}
