//
//  ContentView.swift
//  CookieCutter
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI
import RealityKit

/// Control Panel for selecting cookie cutter shapes and adjusting size
struct ControlPanelView: View {
    
    @Environment(CookieCutterViewModel.self) private var viewModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @State private var isImmersiveSpaceOpen = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Cookie Cutter")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Select a shape and adjust size/rotation")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            ShapeSelectorView(viewModel: viewModel)
            
            HStack(spacing: 16) {
                ScaleControlView(viewModel: viewModel)
                RotationControlView(viewModel: viewModel)
            }
            
            Button {
                Task {
                    if isImmersiveSpaceOpen {
                        await dismissImmersiveSpace()
                        isImmersiveSpaceOpen = false
                    } else {
                        let result = await openImmersiveSpace(id: "CutterSpace")
                        if case .opened = result {
                            isImmersiveSpaceOpen = true
                        }
                    }
                }
            } label: {
                Label(
                    isImmersiveSpaceOpen ? "Close 3D Cutter" : "Open 3D Cutter",
                    systemImage: isImmersiveSpaceOpen ? "xmark.circle" : "cube"
                )
            }
            .buttonStyle(.borderedProminent)
            .tint(isImmersiveSpaceOpen ? .red : .blue)
        }
        .padding(32)
    }
}

/// Immersive view for the cookie cutter shape with full gesture support
struct ImmersiveCutterView: View {
    
    @Bindable var viewModel: CookieCutterViewModel
    
    var body: some View {
        RealityView { content in
            let entity = createEntity(for: viewModel.selectedShape, scale: viewModel.currentScale)
            entity.name = "cookieCutter"
            entity.position = SIMD3<Float>(0, 1.2, -0.8)
            content.add(entity)
        } update: { content in
            guard let entity = content.entities.first(where: { $0.name == "cookieCutter" }) as? ModelEntity else {
                return
            }
            
            let mesh = createMesh(for: viewModel.selectedShape)
            let material = SimpleMaterial(
                color: UIColor(viewModel.selectedShape.color),
                roughness: 0.3,
                isMetallic: true
            )
            entity.model = ModelComponent(mesh: mesh, materials: [material])
            entity.collision = CollisionComponent(shapes: [ShapeResource.generateConvex(from: mesh)])
            
            // Apply scale
            let scale = viewModel.currentScale
            entity.scale = SIMD3<Float>(scale, scale, scale)
            
            // Apply rotation from ViewModel (Y-axis rotation)
            let radians = viewModel.rotationAngle * .pi / 180.0
            entity.orientation = simd_quatf(angle: radians, axis: SIMD3<Float>(0, 1, 0))
        }
        .gesture(dragGesture)
        .gesture(rotateGesture)
        .gesture(magnifyGesture)
    }
    
    // MARK: - Gestures
    
    private var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                guard let parent = value.entity.parent else { return }
                let newPosition = value.convert(value.location3D, from: .local, to: parent)
                value.entity.position = newPosition
            }
    }
    
    private var rotateGesture: some Gesture {
        RotateGesture3D()
            .targetedToAnyEntity()
            .onChanged { value in
                let rotation = value.rotation
                let flippedRotation = Rotation3D(
                    angle: rotation.angle,
                    axis: RotationAxis3D(x: -rotation.axis.x, y: rotation.axis.y, z: -rotation.axis.z)
                )
                value.entity.orientation = simd_quatf(flippedRotation)
            }
    }
    
    private var magnifyGesture: some Gesture {
        MagnifyGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                let magnification = Float(value.magnification)
                value.entity.scale = SIMD3<Float>(repeating: magnification)
            }
    }
    
    // MARK: - Entity Creation
    
    private func createEntity(for shape: CutterShape, scale: Float) -> ModelEntity {
        let mesh = createMesh(for: shape)
        let material = SimpleMaterial(
            color: UIColor(shape.color),
            roughness: 0.3,
            isMetallic: true
        )
        
        let entity = ModelEntity(mesh: mesh, materials: [material])
        entity.scale = SIMD3<Float>(scale, scale, scale)
        
        // Enable gestures
        entity.components.set(InputTargetComponent())
        entity.components.set(CollisionComponent(shapes: [ShapeResource.generateConvex(from: mesh)]))
        entity.components.set(HoverEffectComponent())
        
        return entity
    }
    
    private func createMesh(for shape: CutterShape) -> MeshResource {
        switch shape {
        case .circle:
            return MeshResource.generateCylinder(height: 0.03, radius: 0.06)
        case .square:
            return MeshResource.generateBox(size: 0.1)
        }
    }
}

// Keep ContentView as alias for compatibility
typealias ContentView = ControlPanelView

#Preview(windowStyle: .automatic) {
    ControlPanelView()
        .environment(CookieCutterViewModel())
}
