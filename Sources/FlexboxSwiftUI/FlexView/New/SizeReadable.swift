//
//  SizeReadable.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import SwiftUI
import UIKit

class SizeReadableHostingController<Content: View>: UIHostingController<TransferEnvironmentView<Content>> {
    override init(rootView: TransferEnvironmentView<Content>) {
        super.init(rootView: rootView)
        self._disableSafeArea = true
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

struct SizeReadable<Content: View>: UIViewRepresentable {
    internal init(
        content: Content,
        reader: @escaping (@escaping (CGSize) -> CGSize) -> Void) {
        self.content = content
        self.reader = reader
    }
    
    var content: Content
    var reader: (@escaping (_ targetSize: CGSize) -> CGSize) -> Void
    
    class Coordinator {
        var hostingController: SizeReadableHostingController<Content>
        
        init(hostingController: SizeReadableHostingController<Content>) {
            self.hostingController = hostingController
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(
            hostingController: SizeReadableHostingController(
                rootView: TransferEnvironmentView(content: content, environment: .init())
            )
        )
    }
    
    func updateReader(context: Context) {
        reader { targetSize in
            let size = context.coordinator.hostingController.sizeThatFits(in: targetSize)
            return size
        }
    }

    func makeUIView(context: Context) -> UIView {
        updateReader(context: context)
        context.coordinator.hostingController.rootView = TransferEnvironmentView(
            content: content,
            environment: context.environment
        )
        return context.coordinator.hostingController.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        updateReader(context: context)
        context.coordinator.hostingController.rootView = TransferEnvironmentView(
            content: content,
            environment: context.environment
        )
    }
}
