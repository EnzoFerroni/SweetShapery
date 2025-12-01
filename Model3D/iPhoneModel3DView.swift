//
//  iPhoneModel3DView.swift
//  Model3D
//
//  Created by Enzo Ferroni on 01/12/25.
//

import SwiftUI
import RealityKit

/// A view that displays an interactive 3D model with rotation capabilities in visionOS.
///
/// This view demonstrates how to:
/// - Load and display a 3D USDZ model using Model3D
/// - Implement drag gestures for 3D object manipulation
/// - Use ornaments to display real-time information in spatial computing
/// - Apply 3D transformations to models in a visionOS window
struct iPhoneModel3DView: View {
    
    // MARK: - State Properties
    
    /// Tracks the current Y-axis rotation angle in degrees.
    /// This value updates as the user drags the model horizontally.
    @State private var rotationY: Double = 0.0
    
    // MARK: - Body
    
    var body: some View {
        Model3D(named: "iPhone") { model in
            model
                .rotation3DEffect(
                    .degrees(rotationY),
                    axis: (x: 0, y: 1, z: 0)
                )
        } placeholder: {
            ProgressView()
        }
        /*
         Scales down the 3D model to fit properly within the window.
         The default USDZ models are often too large for the viewport,
         so a scale factor of 0.1 ensures the entire model is visible.
         Adjust this value based on your specific model's size.
         */
        .scaleEffect(0.1)
        .gesture(
            /*
             DragGesture enables user interaction for rotating the 3D model.
             The minimumDistance of 0 ensures the gesture responds immediately.
             The division by 100 controls rotation sensitivity, preventing overly
             fast rotations that would make the interaction jarring.
             */
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    rotationY += Double(value.translation.width / 100)
                    rotationY = rotationY.truncatingRemainder(dividingBy: 360)
                }
        )
        .ornament(attachmentAnchor: .scene(.bottom)) {
            /*
             Ornaments in visionOS present controls and information related to
             a window without obscuring its contents. This ornament displays
             the current rotation angle with a glass background effect.
             */
            Text("Rotation: \(rotationY, specifier: "%.2f")º")
                .padding()
                .glassBackgroundEffect()
        }
    }
    
}

#Preview {
    iPhoneModel3DView()
}
