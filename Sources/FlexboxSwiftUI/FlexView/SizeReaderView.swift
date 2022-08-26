//
//  SizeReaderView.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-26.
//

import Foundation
import SwiftUI

struct SizeReaderView: UIViewRepresentable {
    @State var previousSize: CGSize? = nil
    @EnvironmentObject var store: HostingViewStore
    var onSize: (_ size: CGSize) -> Void
    
    func makeUIView(context: Context) -> UIView {
        UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func _overrideSizeThatFits(_ size: inout CoreGraphics.CGSize, in proposedSize: SwiftUI._ProposedSize, uiView: UIView) {
        size = store.layout?.frame.size ?? .zero
        
        let proposedSize = CGSize(width: proposedSize.width, height: proposedSize.height)
        onSize(proposedSize)
    }
}
