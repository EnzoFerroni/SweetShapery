//
//  CookieCutterViewModel.swift
//  CookieCutter
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI
import Observation

/// ViewModel for managing cookie cutter selection, scaling and rotation
@MainActor
@Observable
class CookieCutterViewModel {
    
    var selectedShape: CutterShape = .circle
    var currentScale: Float = CookieCutterItem.defaultScale
    var rotationAngle: Float = 0.0
    
    // MARK: - Computed Properties
    
    var scalePercentage: Int {
        return Int(currentScale * 100)
    }
    
    var rotationDegrees: Int {
        return Int(rotationAngle)
    }
    
    var minScale: Float {
        return CookieCutterItem.minScale
    }
    
    var maxScale: Float {
        return CookieCutterItem.maxScale
    }
    
    var availableShapes: [CutterShape] {
        return CutterShape.allCases
    }
    
    // MARK: - Scale Methods
    
    func selectShape(_ shape: CutterShape) {
        selectedShape = shape
        resetScale()
        resetRotation()
    }
    
    func setScale(_ value: Float) {
        currentScale = max(minScale, min(maxScale, value))
    }
    
    func increaseScale() {
        setScale(currentScale + 0.1)
    }
    
    func decreaseScale() {
        setScale(currentScale - 0.1)
    }
    
    func resetScale() {
        currentScale = CookieCutterItem.defaultScale
    }
    
    // MARK: - Rotation Methods
    
    func rotateLeft() {
        rotationAngle -= 15.0
        if rotationAngle < 0 {
            rotationAngle += 360.0
        }
    }
    
    func rotateRight() {
        rotationAngle += 15.0
        if rotationAngle >= 360 {
            rotationAngle -= 360.0
        }
    }
    
    func resetRotation() {
        rotationAngle = 0.0
    }
}
