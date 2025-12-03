//
//  CreateShapes.swift
//  Model3D
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI
import RealityKit

struct CreateShapes: View {
    var body: some View {
        RealityView { content, attachments in

            // Create an empty entity we can use to group our shapes
            let group = Entity()
            content.add(group)
            // We can move this group down in the volume and scale it to 50%.
            group.position = [0, -0.25, 0]
            group.scale = [0.5, 0.5, 0.5]

            // Create shapes

            // ModelEntity is a convenient way to create an entity with a model, shapes, and material.
            let sphere = ModelEntity(
                mesh: .generateSphere(radius: 0.1),
                materials: [SimpleMaterial(color: .red, isMetallic: false)])
            // Set the position of the sphere relative to the group
            sphere.setPosition([-0.5, 0, 0], relativeTo: group)
            // Add the sphere as a child to the group
            group.addChild(sphere)

            let box = ModelEntity(
                mesh: .generateBox(size: 0.2),
                materials: [SimpleMaterial(color: .green, isMetallic: false)])
            box.setPosition([0, -0.1, 0], relativeTo: group)
            group.addChild(box)

            let cylinder = ModelEntity(
                mesh: .generateCylinder(height: 0.2, radius: 0.1),
                materials: [SimpleMaterial(color: .blue, isMetallic: false)])
            cylinder.setPosition([0.5, 0, 0], relativeTo: group)
            group.addChild(cylinder)

            let cone = ModelEntity(
                mesh: .generateCone(height: 0.2, radius: 0.075),
                materials: [SimpleMaterial(color: .blue, isMetallic: false)])
            cone.setPosition([0.4, 0.5, 0], relativeTo: group)
            group.addChild(cone)

            let plane = ModelEntity(
                mesh: .generatePlane(width: 0.2, height: 0.2),
                materials: [SimpleMaterial(color: .green, isMetallic: false)])
            plane.setPosition([-0.4, 0.5, 0], relativeTo: group)
            group.addChild(plane)

        } update: { content, attachments in
            // More on update later
        } attachments: {
            // More on attachments later
            Attachment(id: "AttachmentContent") {
                Text("")
            }
        }
    }
}

#Preview {
    CreateShapes()
}
