//
//  CutterShape.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import Foundation

/// Represents the available cookie cutter shapes in the app.
enum CutterShape: String, CaseIterable, Identifiable {
    case star
    case gingerbread
    case xmasTree
    case hexagon
    case pentagon
    case octagon
    
    /// Unique identifier for the shape.
    var id: String { rawValue }
    
    /// Display name shown in the UI.
    var displayName: String {
        switch self {
        case .star: return "Star"
        case .gingerbread: return "Gingerbread"
        case .xmasTree: return "Christmas Tree"
        case .hexagon: return "Hexagon"
        case .pentagon: return "Pentagon"
        case .octagon: return "Octagon"
        }
    }
    
    /// SF Symbol icon for the shape.
    var icon: String {
        switch self {
        case .star: return "star.fill"
        case .gingerbread: return "figure.stand"
        case .xmasTree: return "tree.fill"
        case .hexagon: return "hexagon.fill"
        case .pentagon: return "pentagon.fill"
        case .octagon: return "octagon.fill"
        }
    }
    
    /// 3D model file name in RealityKitContent bundle.
    var fileName: String {
        rawValue
    }
}
