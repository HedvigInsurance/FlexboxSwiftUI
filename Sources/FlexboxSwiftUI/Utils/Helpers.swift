//
//  Helpers.swift
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-18.
//

import Foundation
import CoreGraphics

/// Workaround for `CGSize` equality when value is not a number.
internal func _isCGSizeEqual(_ l: CGSize, _ r: CGSize) -> Bool
{
    return _isCGFloatEqual(l.width, r.width) && _isCGFloatEqual(l.height, r.height)
}

/// Workaround for `CGFloat` equality when value is not a number.
internal func _isCGFloatEqual(_ l: CGFloat, _ r: CGFloat) -> Bool
{
    if l.isNaN && r.isNaN { return true }
    return l == r
}
