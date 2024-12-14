//
//  CGFloat+Extensions.swift.swift
//  iOSCouple
//
//  Created by HSUWEILUN on 2024/12/1.
//

import SwiftUI

public protocol WLPaddingViewPoint: BinaryFloatingPoint {
    static var viewH: Self { get }
    static var viewTop: Self { get }
}

public extension WLPaddingViewPoint {
    static var viewH: Self {
        20
    }
    
    static var viewTop: Self {
        16
    }
}

extension CGFloat: WLPaddingViewPoint { }
