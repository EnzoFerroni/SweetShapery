//
//  CookieCutterModel.swift
//  CookieCutter
//
//  Created by Enzo Ferroni on 04/12/25.
//

import Foundation
import SwiftUI

/// Available cookie cutter shapes
enum CutterShape: String, CaseIterable, Identifiable {
    case circle = "Circle"
    case square = "Square"
    
    var id: String { rawValue }
    
    var systemIcon: String {
        switch self {
        case .circle: return "circle.fill"
        case .square: return "square.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .circle: return .blue
        case .square: return .green
        }
    }
}

/// Model representing a cookie cutter
struct CookieCutterItem: Identifiable {
    let id = UUID()
    var shape: CutterShape
    var scale: Float
    
    static let minScale: Float = 0.1
    static let maxScale: Float = 5.0
    static let defaultScale: Float = 1.0
    
    init(shape: CutterShape, scale: Float = CookieCutterItem.defaultScale) {
        self.shape = shape
        self.scale = scale
    }
}
