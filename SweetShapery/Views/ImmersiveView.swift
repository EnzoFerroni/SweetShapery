//
//  ImmersiveView.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

/// Immersive view that displays the 3D cookie cutter model.
/// Supports drag, rotate, and scale gestures.
struct ImmersiveView: View {
    
    /// Reference to the shared view model.
    var viewModel: ShapeViewModel
    
    /// The loaded 3D model entity.
    @State private var entity: Entity?
    
    /// Root entity that holds the model (used for positioning).
    @State private var rootEntity: Entity?
    
    /// Starting position for drag gesture.
    @State private var dragStartPosition: SIMD3<Float>? = nil
    
    /// Starting scale for magnify gesture.
    @State private var startScale: SIMD3<Float>? = nil
    
    /// Starting orientation for rotate gesture.
    @State private var startOrientation: simd_quatf? = nil
    
    var body: some View {
        RealityView { content in
            // Create root entity at a comfortable viewing position
            let root = Entity()
            root.position = SIMD3<Float>(0, 1.2, -0.8)
            content.add(root)
            rootEntity = root
            
            // Load the initial 3D model
            await loadModel(into: root)
        }
        .gesture(dragGesture)
        .simultaneousGesture(scaleAndRotateGesture)
        .onChange(of: viewModel.selectedShape) {
            Task { await reloadModel() }
        }
        .onChange(of: viewModel.scale) {
            entity?.scale = SIMD3<Float>(repeating: viewModel.scale)
        }
        .onChange(of: viewModel.transparency) {
            guard let entity else { return }
            applyMaterial(to: entity)
        }
        // Rotation observers (simulator testing only)
        .onChange(of: viewModel.rotationX) { updateRotation() }
        .onChange(of: viewModel.rotationY) { updateRotation() }
        .onChange(of: viewModel.rotationZ) { updateRotation() }
    }
    
    // MARK: - Gestures
    
    /// Drag gesture for moving the 3D model.
    private var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                guard let entity = self.entity else { return }
                
                if dragStartPosition == nil {
                    dragStartPosition = entity.position(relativeTo: nil)
                }
                
                guard let startPos = dragStartPosition else { return }
                
                let translation = value.convert(value.translation3D, from: .local, to: .scene)
                
                let newPosition = startPos + SIMD3<Float>(
                    Float(translation.x),
                    Float(translation.y),
                    Float(translation.z)
                )
                
                entity.setPosition(newPosition, relativeTo: nil)
            }
            .onEnded { _ in
                dragStartPosition = nil
            }
    }
    
    /// Magnify gesture for scaling the 3D model.
    private var magnifyGesture: some Gesture {
        MagnifyGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                guard let entity = self.entity else { return }
                
                if startScale == nil {
                    startScale = entity.scale
                }
                
                guard let scale = startScale else { return }
                
                let magnification = Float(value.magnification)
                entity.scale = scale * magnification
            }
            .onEnded { _ in
                startScale = nil
            }
    }
    
    /// Rotate gesture for rotating the 3D model.
    private var rotateGesture: some Gesture {
        RotateGesture3D()
            .targetedToAnyEntity()
            .onChanged { value in
                guard let entity = self.entity else { return }
                
                if startOrientation == nil {
                    startOrientation = entity.orientation(relativeTo: nil)
                }
                
                guard let orientation = startOrientation else { return }
                
                let rotation = value.rotation
                let flippedRotation = Rotation3D(
                    angle: rotation.angle,
                    axis: RotationAxis3D(
                        x: -rotation.axis.x,
                        y: rotation.axis.y,
                        z: -rotation.axis.z
                    )
                )
                
                let startRot = Rotation3D(orientation)
                let newOrientation = startRot.rotated(by: flippedRotation)
                entity.setOrientation(simd_quatf(newOrientation), relativeTo: nil)
            }
            .onEnded { _ in
                startOrientation = nil
            }
    }
    
    /// Combined scale and rotate gesture for two-hand manipulation.
    private var scaleAndRotateGesture: some Gesture {
        MagnifyGesture()
            .simultaneously(with: RotateGesture3D())
            .targetedToAnyEntity()
            .onChanged { value in
                guard let entity = self.entity else { return }
                
                // Handle magnify (scale)
                if let magnifyValue = value.first {
                    if startScale == nil {
                        startScale = entity.scale
                    }
                    
                    if let scale = startScale {
                        let magnification = Float(magnifyValue.magnification)
                        entity.scale = scale * magnification
                    }
                }
                
                // Handle rotation
                if let rotateValue = value.second {
                    if startOrientation == nil {
                        startOrientation = entity.orientation(relativeTo: nil)
                    }
                    
                    if let orientation = startOrientation {
                        let rotation = rotateValue.rotation
                        let flippedRotation = Rotation3D(
                            angle: rotation.angle,
                            axis: RotationAxis3D(
                                x: -rotation.axis.x,
                                y: rotation.axis.y,
                                z: -rotation.axis.z
                            )
                        )
                        
                        let startRot = Rotation3D(orientation)
                        let newOrientation = startRot.rotated(by: flippedRotation)
                        entity.setOrientation(simd_quatf(newOrientation), relativeTo: nil)
                    }
                }
            }
            .onEnded { _ in
                startScale = nil
                startOrientation = nil
            }
    }
    
    // MARK: - Model Loading
    
    /// Loads a 3D model from RealityKitContent bundle.
    private func loadModel(into root: Entity) async {
        let modelName = viewModel.selectedShape.fileName
        
        // Try to load the model
        guard let loadedEntity = try? await Entity(
            named: modelName,
            in: realityKitContentBundle
        ) else {
            return
        }
        
        // Setup for gestures - allow all input types for full gesture support
        loadedEntity.generateCollisionShapes(recursive: true)
        loadedEntity.components.set(InputTargetComponent(allowedInputTypes: .all))
        loadedEntity.components.set(HoverEffectComponent())
        
        // Apply initial scale and material
        loadedEntity.scale = SIMD3<Float>(repeating: viewModel.scale)
        applyMaterial(to: loadedEntity)
        
        // Add to scene
        root.addChild(loadedEntity)
        entity = loadedEntity
    }
    
    /// Removes current model and loads a new one.
    /// Maintains the current position and rotation.
    private func reloadModel() async {
        guard let rootEntity else { return }
        
        entity?.removeFromParent()
        entity = nil
        
        await loadModel(into: rootEntity)
        
        // Reapply rotation to the new model
        updateRotation()
    }
    
    // MARK: - Material
    
    /// Creates a metallic silver material with current transparency.
    private func createMaterial() -> PhysicallyBasedMaterial {
        var material = PhysicallyBasedMaterial()
        material.baseColor = .init(tint: .init(red: 0.85, green: 0.85, blue: 0.88, alpha: 1.0))
        material.metallic = .init(floatLiteral: 1.0)
        material.roughness = .init(floatLiteral: 0.15)
        material.blending = .transparent(opacity: .init(floatLiteral: viewModel.transparency))
        return material
    }
    
    /// Applies metallic material to entity and all children.
    private func applyMaterial(to entity: Entity) {
        // Apply to this entity if it has a model
        if var modelComponent = entity.components[ModelComponent.self] {
            let material = createMaterial()
            modelComponent.materials = modelComponent.materials.map { _ in material }
            entity.components.set(modelComponent)
        }
        
        // Apply to all children
        entity.children.forEach { applyMaterial(to: $0) }
    }
    
    // MARK: - Rotation (Simulator Testing Only)
    
    /// Updates model rotation based on view model values.
    private func updateRotation() {
        guard let entity else { return }
        
        let rotX = simd_quatf(angle: viewModel.rotationX * .pi / 180, axis: [1, 0, 0])
        let rotY = simd_quatf(angle: viewModel.rotationY * .pi / 180, axis: [0, 1, 0])
        let rotZ = simd_quatf(angle: viewModel.rotationZ * .pi / 180, axis: [0, 0, 1])
        
        entity.orientation = rotX * rotY * rotZ
    }
}
