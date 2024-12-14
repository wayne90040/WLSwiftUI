//
//  View+Linear.swift
//  iOSCouple
//
//  Created by user on 2024/12/12.
//

import SwiftUI

public extension View {
    
    func linearBackground(_ colors: Color..., start: UnitPoint, end: UnitPoint) -> some View {
        self
            .background(
                LinearGradient(colors: colors, startPoint: start, endPoint: end)
            )
    }
    
    func linearBorder(_ colors: Color..., start: UnitPoint = .leading, end: UnitPoint = .trailing, radius: CGFloat, lineWidth: CGFloat = 2) -> some View {
        self
            .overlay(
                RoundedRectangle(cornerRadius: (radius))
                    .stroke(LinearGradient(colors: colors, startPoint: start, endPoint: end), lineWidth: lineWidth)
            )
    }
}
