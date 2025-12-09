/*
  RealityViewExtensions.swift
  RealityKitContent

  Extensions for RealityView to easily install gesture support.
*/

import Foundation
import RealityKit
import SwiftUI

// MARK: - RealityView Extensions

public extension RealityView {
    
    /// Apply this to a RealityView to enable gesture support via GestureComponent.
    func installGestures() -> some View {
        simultaneousGesture(dragGesture)
            .simultaneousGesture(magnifyGesture)
            .simultaneousGesture(rotateGesture)
    }
    
    /// Builds a drag gesture that targets any entity.
    var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .useGestureComponent()
    }
    
    /// Builds a magnify gesture that targets any entity.
    var magnifyGesture: some Gesture {
        MagnifyGesture()
            .targetedToAnyEntity()
            .useGestureComponent()
    }
    
    /// Builds a rotate gesture that targets any entity.
    var rotateGesture: some Gesture {
        RotateGesture3D()
            .targetedToAnyEntity()
            .useGestureComponent()
    }
}
