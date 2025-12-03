//
//  ImmersiveView.swift
//  shapesTutorial
//
//  Created by Carolina Sun on 02/12/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    
    init() {
        ToyComponent.registerComponent() //call this once to register the component
    }
    
    var body: some View {
        
        RealityView { content in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)
                
                // position where the 3d shape will appear depending on the persons position
                immersiveContentEntity.position = [0, 1.0, -1.0]
                
            }
        }
        // drag the 3d objects
        .gesture(
            DragGesture()
                .targetedToEntity(where: .has(ToyComponent.self)) // only the objects with the ToyComponent
                .onChanged({ value in
                    value.entity.position = value.convert(value.location3D, from: .local, to: value.entity.parent!)
                    //value.entity.components[PhysicsBodyComponent.self] = .none
                })
        )
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
