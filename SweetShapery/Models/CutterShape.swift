//
//  CutterShape.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import Foundation

/// Represents the available cookie cutter shapes in the app.
enum CutterShape: String, CaseIterable, Identifiable {
    case circle
    case square
    case pentagon
    case hexagon
    case octagon
    case star
    case gingerbread
    case xmasTree
    
    /// Unique identifier for the shape.
    var id: String { rawValue }
    
    /// Display name shown in the UI.
    var displayName: String {
        switch self {
        case .circle: return "Circle"
        case .square: return "Square"
        case .pentagon: return "Pentagon"
        case .hexagon: return "Hexagon"
        case .octagon: return "Octagon"
        case .star: return "Star"
        case .gingerbread: return "Gingerbread"
        case .xmasTree: return "Christmas Tree"
        }
    }
    
    /// SF Symbol icon for the shape.
    var icon: String {
        switch self {
        case .circle: return "circle.fill"
        case .square: return "square.fill"
        case .pentagon: return "pentagon.fill"
        case .hexagon: return "hexagon.fill"
        case .octagon: return "octagon.fill"
        case .star: return "star.fill"
        case .gingerbread: return "figure.stand"
        case .xmasTree: return "tree.fill"
        }
    }
    
    /// 3D model file name in RealityKitContent bundle.
    var fileName: String {
        rawValue
    }
}
