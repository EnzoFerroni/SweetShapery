//
//  ShapeViewModel.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI

@MainActor
@Observable
class ShapeViewModel {
    
    var selectedShape: CutterShape = .star
    var scale: Float = 1.0
    var transparency: Float = 1.0
    var rotationX: Float = 0.0
    var rotationY: Float = 0.0
    var rotationZ: Float = 0.0
    
    var allShapes: [CutterShape] {
        CutterShape.allCases
    }
    
    func resetRotation() {
        rotationX = 0.0
        rotationY = 0.0
        rotationZ = 0.0
    }
}
