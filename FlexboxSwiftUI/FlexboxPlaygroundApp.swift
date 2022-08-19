//
//  FlexboxPlaygroundApp.swift
//  FlexboxPlayground
//
//  Created by Sam Pettersson on 2022-08-18.
//

import SwiftUI

@main
struct FlexboxPlaygroundApp: App {
    let loremIpsum = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum condimentum eu diam id facilisis. Integer tempus libero nec velit condimentum iaculis. Pellentesque aliquam quam suscipit urna tincidunt egestas. Fusce vitae justo eget est cursus fermentum eget ac turpis. Etiam ut est sed ante consequat aliquam. Etiam ac porta eros. Etiam placerat, mauris nec sagittis tempor, mi enim ornare dolor, in lobortis urna tortor id leo.

    Nunc ligula nisi, gravida ac aliquam quis, blandit at lacus. Nunc posuere, mauris eu viverra eleifend, neque eros pellentesque nibh, non imperdiet ante diam nec ante. Proin a lectus mollis, pellentesque nisl in, feugiat tortor. Nulla luctus facilisis ligula a venenatis. Nullam quis consectetur turpis. Phasellus id elementum nisi. Morbi quis purus porttitor, bibendum justo sit amet, cursus arcu. Nullam porttitor odio in quam suscipit, eget cursus magna egestas. Suspendisse sed sem eget nunc mattis maximus. Morbi interdum, purus id laoreet pharetra, enim lectus ornare lorem, id dignissim orci ipsum eget tellus.
    """

    var body: some Scene {
        WindowGroup {
            ScrollView {
                FlexView(node: Node(
                    size: Size(width: .auto, height: .auto),
                    children: [
                        Node(
                            size: Size(width: .fixed(10), height: .auto),
                            flexGrow: 1,
                            view: AnyView(Color.green)
                        ),
                        Node(size: Size(width: .fixed(10), height: .auto), flexGrow: 2, view: AnyView(Color.blue)),
                        Node(size: Size(width: .fixed(10), height: .auto), flexGrow: 1, view: AnyView(Color.red)),
                    ],
                    flexDirection: .row,
                    justifyContent: .flexStart,
                    alignItems: .flexStart
                ))
            }
        }
    }
}
