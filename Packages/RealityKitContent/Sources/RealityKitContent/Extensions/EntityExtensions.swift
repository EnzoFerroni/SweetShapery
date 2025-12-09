/*
  EntityExtensions.swift
  RealityKitContent

  Extensions for Entity to support gesture components and scene-relative transforms.
*/

import Foundation
import RealityKit

public extension Entity {
    
    /// Gets or sets the gesture component on this entity.
    var gestureComponent: GestureComponent? {
        get { components[GestureComponent.self] }
        set { components[GestureComponent.self] = newValue }
    }
    
    /// Returns the position of the entity in scene/world coordinates.
    var scenePosition: SIMD3<Float> {
        get { position(relativeTo: nil) }
        set { setPosition(newValue, relativeTo: nil) }
    }
    
    /// Returns the orientation of the entity in scene/world coordinates.
    var sceneOrientation: simd_quatf {
        get { orientation(relativeTo: nil) }
        set { setOrientation(newValue, relativeTo: nil) }
    }
}
