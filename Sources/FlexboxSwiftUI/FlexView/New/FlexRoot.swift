//
//  FlexRoot.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-28.
//

import Foundation
import SwiftUI

public struct FlexRoot<Content: View>: View {
    @StateObject var coordinator = FlexCoordinator()
    var content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: .init(horizontal: .leading, vertical: .flexRootTop)) {
            SizeReaderView { size in
                coordinator.maxSize = size
            }
            
            content()
        }
        .environmentObject(coordinator)
        .onPreferenceChange(NodeImplPreferenceKey.self) { node in
            coordinator.rootNode = node
        }
        .clipped()
    }
}
