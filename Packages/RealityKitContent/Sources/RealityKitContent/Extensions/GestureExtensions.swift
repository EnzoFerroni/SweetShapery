/*
  GestureExtensions.swift
  RealityKitContent

  Extensions for Gesture types to support the GestureComponent.
*/

import Foundation
import RealityKit
import SwiftUI

// MARK: - Rotate Gesture

/// Gesture extension to support rotation gestures.
public extension Gesture where Value == EntityTargetValue<RotateGesture3D.Value> {
    
    /// Connects the gesture input to the GestureComponent code.
    func useGestureComponent() -> some Gesture {
        onChanged { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            
            gestureComponent.onChanged(value: value)
            value.entity.components.set(gestureComponent)
        }
        .onEnded { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            
            gestureComponent.onEnded(value: value)
            value.entity.components.set(gestureComponent)
        }
    }
}

// MARK: - Drag Gesture

/// Gesture extension to support drag gestures.
public extension Gesture where Value == EntityTargetValue<DragGesture.Value> {
    
    /// Connects the gesture input to the GestureComponent code.
    func useGestureComponent() -> some Gesture {
        onChanged { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            
            gestureComponent.onChanged(value: value)
            value.entity.components.set(gestureComponent)
        }
        .onEnded { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            
            gestureComponent.onEnded(value: value)
            value.entity.components.set(gestureComponent)
        }
    }
}

// MARK: - Magnify (Scale) Gesture

/// Gesture extension to support scale gestures.
public extension Gesture where Value == EntityTargetValue<MagnifyGesture.Value> {
    
    /// Connects the gesture input to the GestureComponent code.
    func useGestureComponent() -> some Gesture {
        onChanged { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            
            gestureComponent.onChanged(value: value)
            value.entity.components.set(gestureComponent)
        }
        .onEnded { value in
            guard var gestureComponent = value.entity.gestureComponent else { return }
            
            gestureComponent.onEnded(value: value)
            value.entity.components.set(gestureComponent)
        }
    }
}
