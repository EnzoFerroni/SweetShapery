//
//  CreateShapes.swift
//  Model3D
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI
import RealityKit

// MARK: - Create Shapes View

/// Demonstrates how to create and position primitive 3D shapes using RealityKit
/// This view showcases basic 3D modeling capabilities in visionOS including
/// creating geometric shapes, applying materials, and organizing entities in a hierarchy
struct CreateShapes: View {
    var body: some View {
        RealityView { content, attachments in

            // Create an empty entity to serve as a container for grouping shapes
            // This allows us to transform all shapes together as a single unit
            let group = Entity()
            content.add(group)
            
            // Position the group lower in the volume and scale it to 50%
            // This demonstrates parent-child transformation relationships
            group.position = [0, -0.25, 0]
            group.scale = [0.5, 0.5, 0.5]

            // MARK: - Create Individual Shapes
            
            // Red Sphere - positioned to the left
            let sphere = ModelEntity(
                mesh: .generateSphere(radius: 0.1),
                materials: [SimpleMaterial(color: .red, isMetallic: false)])
            sphere.setPosition([-0.5, 0, 0], relativeTo: group)
            group.addChild(sphere)

            // Green Box - positioned at center, slightly below
            let box = ModelEntity(
                mesh: .generateBox(size: 0.2),
                materials: [SimpleMaterial(color: .green, isMetallic: false)])
            box.setPosition([0, -0.1, 0], relativeTo: group)
            group.addChild(box)

            // Blue Cylinder - positioned to the right
            let cylinder = ModelEntity(
                mesh: .generateCylinder(height: 0.2, radius: 0.1),
                materials: [SimpleMaterial(color: .blue, isMetallic: false)])
            cylinder.setPosition([0.5, 0, 0], relativeTo: group)
            group.addChild(cylinder)

            // Blue Cone - positioned in the upper right area
            let cone = ModelEntity(
                mesh: .generateCone(height: 0.2, radius: 0.075),
                materials: [SimpleMaterial(color: .blue, isMetallic: false)])
            cone.setPosition([0.4, 0.5, 0], relativeTo: group)
            group.addChild(cone)

            // Green Plane - positioned in the upper left area
            let plane = ModelEntity(
                mesh: .generatePlane(width: 0.2, height: 0.2),
                materials: [SimpleMaterial(color: .green, isMetallic: false)])
            plane.setPosition([-0.4, 0.5, 0], relativeTo: group)
            group.addChild(plane)

        } update: { content, attachments in
            // Update closure - called when view state changes
        } attachments: {
            // Attachments closure - used to attach SwiftUI views to 3D entities
            Attachment(id: "AttachmentContent") {
                Text("")
            }
        }
    }
}

#Preview {
    CreateShapes()
}
