//
//  Utils.swift
//  FlexboxSwiftUITests
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import SnapshotTesting
import SwiftUI
import ViewInspector
import XCTest

@testable import FlexboxSwiftUI

struct InspectionEnabledView<Content: View>: View, Inspectable {
    var view: Content
    internal let inspection = Inspection<Self>()

    var body: some View {
        view
            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

extension View {
    @ViewBuilder func frame(_ size: CGSize?) -> some View {
        if let size = size {
            self.frame(width: size.width, height: size.height, alignment: .topLeading)
        } else {
            self
        }
    }
}

var assertSize: CGSize {
    CGSize(width: 300, height: 300)
}

func assertFlex<Content: View>(
    _ root: FlexRoot<Content>,
    size: CGSize? = assertSize,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) -> [XCTestExpectation] {
    func runAssert<V: View>(_ view: V) -> XCTestExpectation {
        let vc = UIHostingController(rootView: root.frame(size))

        let exp = XCTestExpectation(description: "Wait for screen to render")

        let window: UIWindow

        if let size = size {
            window = UIWindow(frame: .init(origin: .zero, size: size))
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        window.layoutIfNeeded()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            assertSnapshot(
                matching: vc,
                as: .image,
                named: "flexNode",
                file: file,
                testName: testName,
                line: line
            )
            exp.fulfill()
        }
        
        return exp
    }
    
    return [runAssert(root)]
}
