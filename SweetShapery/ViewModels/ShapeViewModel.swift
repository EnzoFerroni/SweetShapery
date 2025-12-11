//
//  ShapeViewModel.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI

/// ViewModel that manages the state of the 3D shape viewer.
/// Uses @Observable for automatic SwiftUI updates.
@MainActor
@Observable
class ShapeViewModel {
    
    // MARK: - Shape Properties
    
    /// Currently selected shape to display.
    var selectedShape: CutterShape = .circle
    
    /// Scale of the 3D model (0.1 to 3.0).
    var scale: Float = 1.0
    
    /// Transparency of the 3D model (0.1 to 1.0).
    var transparency: Float = 1.0
    
    // MARK: - Rotation Properties (Simulator Testing Only)
    
    /// Rotation around X axis in degrees.
    var rotationX: Float = 0.0
    
    /// Rotation around Y axis in degrees.
    var rotationY: Float = 0.0
    
    /// Rotation around Z axis in degrees.
    var rotationZ: Float = 0.0
    
    // MARK: - Computed Properties
    
    /// All available shapes for selection.
    var allShapes: [CutterShape] {
        CutterShape.allCases
    }
    
    // MARK: - Methods
    
    /// Resets all rotation values to zero.
    func resetRotation() {
        rotationX = 0.0
        rotationY = 0.0
        rotationZ = 0.0
    }
}

// MARK: - [REVIEW]
/// Cuidado com níveis de acesso implícitos (`var` vs. `private var`).
