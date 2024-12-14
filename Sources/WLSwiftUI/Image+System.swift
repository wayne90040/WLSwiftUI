//
//  File.swift
//  
//
//  Created by user on 2024/12/14.
//

import SwiftUI

public protocol IconRepresentable {
    var iconName: String { get }
}

public extension Image {
    init(icon: IconRepresentable) {
        self.init(systemName: icon.iconName)
    }
}

//enum SystemIcon: String, IconRepresentable {
//    case location = "location"
//    case squareAndPencil = "square.and.pencil"
//    case xmark = "xmark"
//    case plus = "plus"
//    case camera = "camera"
//    case trash = "trash"
//    case checkmark = "checkmark"
//    case arrowBackward = "arrow.backward"
//    case chevronRight = "chevron.right"
//    case scope = "scope"
//    case mappinCircleFill = "mappin.circle.fill"
//    case circleGrid2x2 = "circle.grid.2x2"
//    case textQuote = "text.quote"
//    case circle = "circle"
//    case buttonProgrammable = "button.programmable"
//    case heart = "heart"
//    case checkmarkSquareFill = "checkmark.square.fill"
//    case square = "square"
//    
//    var iconName: String {
//        rawValue
//    }
//}
