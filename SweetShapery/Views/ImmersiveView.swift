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
/// Supports drag gestures, transparency, scale, and rotation.
struct ImmersiveView: View {
    
    /// Reference to the shared view model.
    var viewModel: ShapeViewModel
    
    /// The loaded 3D model entity.
    @State private var entity: Entity?
    
    /// Root entity that holds the model (used for positioning).
    @State private var rootEntity: Entity?
    
    /// Starting position for drag gesture calculations.
    @State private var dragStartPosition: SIMD3<Float> = .zero
    
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
    
    // MARK: - Model Loading
    
    /// Loads a 3D model from RealityKitContent bundle.
    private func loadModel(into root: Entity) async {
        let modelName = viewModel.selectedShape.fileName
        
        // Try to load the model
        guard let loadedEntity = try? await Entity(named: modelName, in: realityKitContentBundle) else {
            return
        }
        
        // Setup for gestures (order matters!)
        loadedEntity.generateCollisionShapes(recursive: true)
        loadedEntity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
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
    
    // MARK: - Gestures
    
    /// Drag gesture for moving the 3D model.
    private var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                guard let rootEntity else { return }
                
                // Save start position on first drag event
                if dragStartPosition == .zero {
                    dragStartPosition = rootEntity.position
                }
                
                // Convert gesture translation to scene coordinates
                let translation = value.convert(value.translation3D, from: .local, to: .scene)
                
                // Move from start position
                rootEntity.position = dragStartPosition + SIMD3<Float>(
                    Float(translation.x),
                    Float(translation.y),
                    Float(translation.z)
                )
            }
            .onEnded { _ in
                // Reset for next gesture
                dragStartPosition = .zero
            }
    }
}
