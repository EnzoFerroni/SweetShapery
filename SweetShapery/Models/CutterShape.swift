//
//  CutterShape.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import Foundation

enum CutterShape: String, CaseIterable, Identifiable {
    case star
    case gingerbread
    case xmasTree
    case hexagon
    case pentagon
    case octagon
    
    var id: String { rawValue }
    
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
    
    var fileName: String {
        switch self {
        case .star: return "star"
        case .gingerbread: return "gingerbread"
        case .xmasTree: return "xmasTree"
        case .hexagon: return "hexagon"
        case .pentagon: return "pentagon"
        case .octagon: return "octagon"
        }
    }
}
