//
//  ImmersiveView.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    
    var viewModel: ShapeViewModel
    @State private var entity: Entity?
    @State private var rootEntity: Entity?
    
    var body: some View {
        RealityView { content in
            let root = Entity()
            root.position = SIMD3<Float>(0, 1.2, -0.8)
            content.add(root)
            rootEntity = root
            
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
            if let entity {
                applyTransparency(to: entity)
            }
        }
        .onChange(of: viewModel.rotationX) { updateRotation() }
        .onChange(of: viewModel.rotationY) { updateRotation() }
        .onChange(of: viewModel.rotationZ) { updateRotation() }
    }
    
    // MARK: - Model Loading
    
    private func loadModel(into root: Entity) async {
        let modelName = viewModel.selectedShape.fileName
        
        guard let loadedEntity = try? await Entity(named: modelName, in: realityKitContentBundle) else {
            return
        }
        
        loadedEntity.components.set(InputTargetComponent())
        loadedEntity.components.set(HoverEffectComponent())
        loadedEntity.generateCollisionShapes(recursive: true)
        loadedEntity.scale = SIMD3<Float>(repeating: viewModel.scale)
        
        applyTransparency(to: loadedEntity)
        
        root.addChild(loadedEntity)
        entity = loadedEntity
    }
    
    private func reloadModel() async {
        guard let rootEntity else { return }
        
        entity?.removeFromParent()
        entity = nil
        
        await loadModel(into: rootEntity)
    }
    
    // MARK: - Rotation
    
    private func updateRotation() {
        guard let entity else { return }
        
        let rotX = simd_quatf(angle: viewModel.rotationX * .pi / 180, axis: [1, 0, 0])
        let rotY = simd_quatf(angle: viewModel.rotationY * .pi / 180, axis: [0, 1, 0])
        let rotZ = simd_quatf(angle: viewModel.rotationZ * .pi / 180, axis: [0, 0, 1])
        
        entity.orientation = rotX * rotY * rotZ
    }
    
    // MARK: - Transparency
    
    private func applyTransparency(to entity: Entity) {
        if var modelComponent = entity.components[ModelComponent.self] {
            var newMaterials: [RealityKit.Material] = []
            
            for material in modelComponent.materials {
                if var pbr = material as? PhysicallyBasedMaterial {
                    pbr.blending = .transparent(opacity: .init(floatLiteral: viewModel.transparency))
                    newMaterials.append(pbr)
                }
            }
            
            if !newMaterials.isEmpty {
                modelComponent.materials = newMaterials
                entity.components.set(modelComponent)
            }
        }
        
        for child in entity.children {
            applyTransparency(to: child)
        }
    }
    
    // MARK: - Gestures
    
    private var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                guard let rootEntity else { return }
                let translation = value.convert(value.translation3D, from: .local, to: .scene)
                rootEntity.position += SIMD3<Float>(
                    Float(translation.x) * 0.01,
                    Float(translation.y) * 0.01,
                    Float(translation.z) * 0.01
                )
            }
    }
}
