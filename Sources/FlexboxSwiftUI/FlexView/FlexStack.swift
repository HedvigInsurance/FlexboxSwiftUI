//
//  FlexRoot.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import SwiftUI

public struct FlexStack<Content: View>: View {
    @StateObject var coordinator = FlexCoordinator()
    var content: () -> Content
    var flexibleAxies: [Axis]
    
    public init(
        flexibleAxies: [Axis] = [],
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.flexibleAxies = flexibleAxies
        self.content = content
    }
    
    public var body: some View {
        coordinator.flexibleAxies = flexibleAxies
        
        return ZStack(alignment: .topLeading) {
            SizeReaderView()
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .flexRootTop)) {
                Color.clear.frame(
                    width: coordinator.layout?.frame.width ?? 0,
                    height: coordinator.layout?.frame.height ?? 0
                )
                
                content()
            }
            .onPreferenceChange(NodeImplPreferenceKey.self) { node in
                coordinator.rootNode = node
            }.position(
                x: (coordinator.layout?.frame.width ?? 0) / 2,
                y: (coordinator.layout?.frame.height ?? 0) / 2
            )
        }.transaction { transaction in
            coordinator.rootTransaction = transaction
        }.onReceive(coordinator.nodeObserver) { _ in
            withTransaction(coordinator.rootTransaction) {
                coordinator.updateLayout()
            }
        }
        .environmentObject(coordinator)
        .onAppear {
            withTransaction(coordinator.rootTransaction) {
                coordinator.updateLayout()
            }
        }
    }
}
