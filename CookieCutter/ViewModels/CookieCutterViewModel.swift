//
//  CookieCutterViewModel.swift
//  CookieCutter
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI
import Observation

/// ViewModel for managing cookie cutter selection and scaling
@MainActor
@Observable
class CookieCutterViewModel {
    
    var selectedShape: CutterShape = .circle
    var currentScale: Float = CookieCutterItem.defaultScale
    
    // MARK: - Computed Properties
    
    var scalePercentage: Int {
        return Int(currentScale * 100)
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
    
    // MARK: - Public Methods
    
    func selectShape(_ shape: CutterShape) {
        selectedShape = shape
        resetScale()
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
}
