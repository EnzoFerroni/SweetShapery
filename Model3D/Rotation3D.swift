//
//  Rotation3D.swift
//  Model3D
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI

// MARK: - 3D Rotation Demo

/*
 Demonstrates 3D rotation effects in visionOS.
 Shows how to rotate elements around the Y-axis to create
 a card fan or carousel-like layout with glass background effects.
*/
struct Rotation3D: View {
    
    // MARK: - State Properties
    
    @State private var isActive = false
    @State private var showWindow = true

    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 24) {
            
            // Button to toggle between flat and rotated layouts
            Button(action: handleButtonPress) {
                Image(systemName: isActive ? "square.stack.3d.down.right.fill" : "square.fill")
                Text("Toggle Layout")
            }

            HStack(spacing: 24) {
                
                // MARK: - Left Rectangle (Red)
                // Rotates 25° around Y-axis and moves left/forward
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.red)
                    .offset(x: isActive ? -60 : 0)
                    .offset(z: isActive ? 80 : 1)
                    .rotation3DEffect(
                        Angle(degrees: isActive ? 25 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )

                // MARK: - Center Rectangle (Blue)
                // Stays centered with subtle forward offset
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.blue)
                    .offset(z: isActive ? 40 : 1)

                // MARK: - Right Rectangle (Green)
                // Rotates -25° around Y-axis and moves right/forward
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.green)
                    .offset(x: isActive ? 60 : 0)
                    .offset(z: isActive ? 80 : 1)
                    .rotation3DEffect(
                        Angle(degrees: isActive ? -25 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
            }
            .padding(12)
        }
        .padding(12)
        // Glass effect that can be toggled on/off
        .glassBackgroundEffect(displayMode: showWindow ? .always : .never)
        .persistentSystemOverlays(showWindow ? .visible : .hidden)
    }

    // MARK: - Private Methods
    
    /// Handles the button press to toggle layout with coordinated animations
    /// Manages timing between window visibility and rotation animations
    private func handleButtonPress() {
        Task {
            if isActive {
                // If we are showing the rotated layout, animate it back to flat, then show the window
                withAnimation {
                    isActive.toggle()
                }
                try? await Task.sleep(nanoseconds: 500_000_000)
                    showWindow = true
            } else {
                // If we are showing the flat layout, hide the window then animate to the rotated layout
                    showWindow = false

                try? await Task.sleep(nanoseconds: 200_000_000)
                withAnimation {
                    isActive.toggle()
                }
            }
        }
    }
}

#Preview {
    Rotation3D()
}
