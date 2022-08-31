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
            SizeReaderView { size in
                if size != coordinator.maxSize {
                    withTransaction(coordinator.rootTransaction) {
                        coordinator.maxSize = size
                        coordinator.updateLayout()
                    }
                }
            }
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .flexRootTop)) {
                Color.clear.frame(
                    width: coordinator.layout?.frame.width ?? 0,
                    height: coordinator.layout?.frame.height ?? 0
                )
                
                content()
            }
            .environmentObject(coordinator)
            .onPreferenceChange(NodeImplPreferenceKey.self) { node in
                coordinator.rootNode = node
            }.position(
                x: (coordinator.layout?.frame.width ?? 0) / 2,
                y: (coordinator.layout?.frame.height ?? 0) / 2
            )
        }.transaction { transaction in
            coordinator.rootTransaction = transaction
        }
    }
}
