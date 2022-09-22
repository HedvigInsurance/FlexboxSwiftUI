import Foundation
import SwiftUI
import Placement

struct FlexLayout: PlacementLayout {
    var flexibleAxes: [Axis]
    var style: any FlexStyle
    
    public init(
        flexibleAxes: [Axis] = [],
        style: any FlexStyle
    ) {
        self.flexibleAxes = flexibleAxes
        self.style = style
    }
    
    public struct Cache {
        let rootNode = NodeImpl()
    }
    
    func updateNodes(_ cache: Cache, subviews: Subviews) {
        style.updateNodeImpl(cache.rootNode)
                
        cache.rootNode.children = subviews.map { subview in
            let node = NodeImpl()
            
            let style = subview[FlexStylePlacementLayoutValueKey.self]
            style.updateNodeImpl(node)
            
            node.measure = { suggestedSize, widthMode, heightMode in
                let constrainedWidth =
                widthMode == .undefined
                ? UIView.layoutFittingCompressedSize.width
                : suggestedSize.width
                let constrainedHeight =
                heightMode == .undefined
                ? UIView.layoutFittingCompressedSize.height
                : suggestedSize.height
                
                func sanitize(
                    constrainedSize: CGFloat,
                    measuredSize: CGFloat,
                    mode: YGMeasureMode
                ) -> CGFloat {
                    if mode == .exactly {
                        return constrainedSize
                    } else if mode == .atMost {
                        return min(constrainedSize, measuredSize)
                    } else {
                        return measuredSize
                    }
                }
                
                let sizeThatFits = subview.sizeThatFits(
                    PlacementProposedViewSize(CGSize(width: constrainedWidth, height: constrainedHeight))
                )
                                
                let result = CGSize(
                    width: sanitize(
                        constrainedSize: constrainedWidth,
                        measuredSize: sizeThatFits.width,
                        mode: widthMode
                    ),
                    height: sanitize(
                        constrainedSize: constrainedHeight,
                        measuredSize: sizeThatFits.height,
                        mode: heightMode
                    )
                )
                
                return result
            }
            
            return node
        }
    }
    
    public func updateCache(_ cache: inout Cache, subviews: Subviews) {
        updateNodes(cache, subviews: subviews)
    }
    
    public func makeCache(subviews: Subviews) -> Cache {
        let cache = Cache()
        
        updateNodes(cache, subviews: subviews)
        
        return cache
    }
    
    public func sizeThatFits(
        proposal: PlacementProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) -> CGSize {
        style.updateNodeImpl(cache.rootNode)
        
        cache.rootNode.children.forEach { node in
            node.isDirty = true
        }
                
        let flexibleProposal = PlacementProposedViewSize(
            width: flexibleAxes.contains(.horizontal) ? .nan : proposal.width,
            height: flexibleAxes.contains(.vertical) ? .nan : proposal.height
        )

        cache.rootNode.layout(
            withMaxSize: flexibleProposal.replacingUnspecifiedDimensions(by: .zero)
        )
        
        return cache.rootNode.frame.size
    }
    
    public func placeSubviews(
        in bounds: CGRect,
        proposal: PlacementProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) {
        style.updateNodeImpl(cache.rootNode)

        subviews.enumerated().forEach { offset, subview in
            let node = cache.rootNode.children[offset]
            
            let padding = node.padding
                        
            let point = CGPoint(
                x: bounds.origin.x + node.frame.origin.x + padding.left,
                y: bounds.origin.y + node.frame.origin.y + padding.top
            )
            
            let size = node.frame.size
            
            let sizeWithoutPadding = CGSize(
                width: size.width - padding.left - padding.right,
                height: size.height - padding.top - padding.bottom
            )
                                                                        
            subview.place(
                at: point,
                anchor: .topLeading,
                proposal: PlacementProposedViewSize(CGSize(
                    width: sizeWithoutPadding.width.isNaN ? 0 : sizeWithoutPadding.width,
                    height: sizeWithoutPadding.height.isNaN ? 0 : sizeWithoutPadding.height
                ))
            )
        }
    }
}
