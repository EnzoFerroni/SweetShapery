//
//  iPhoneRealityView.swift
//  Model3D
//
//  Created by Enzo Ferroni on 02/12/25.
//

import SwiftUI
import RealityKit


struct iPhoneRealityView: View {
    
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        
        RealityView (make: { content, attachments in
            if let iPhone = try? await ModelEntity(named: "iPhone") {
                let firstiPhone = iPhone.clone(recursive: false)
                firstiPhone.position = [0.35, 0, 0]
                firstiPhone.generateCollisionShapes(recursive: false)
                firstiPhone.components.set(InputTargetComponent())
                
                content.add(firstiPhone)
                
            }
            if let attachment = attachments.entity(for: "ScaleInfo"){
                attachment.position = [0, -0.1, 0.15]
                content.add(attachment)
            }
        },update: { content, attachments in
            for entity in content.entities {
                entity.transform.scale = [Float(scale), Float(scale), Float(scale)]
            }
        },attachments: {
            Attachment(id: "ScaleInfo") {
                Text("Scale: \(scale)")
                    .padding()
                    .glassBackgroundEffect()
            }
        }).gesture(
            MagnifyGesture(minimumScaleDelta: 0)
                .onChanged { value in
                    scale = min(max(1, value.magnification), 1.5)
                }
                .targetedToAnyEntity()
        )
    }
    
}

#Preview (windowStyle: .volumetric){
    iPhoneRealityView()
}
