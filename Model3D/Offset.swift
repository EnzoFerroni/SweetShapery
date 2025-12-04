//
//  Offset.swift
//  Model3D
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI

// MARK: - Offset Demo

/*
 Demonstrates spatial offset capabilities in visionOS.
 Shows how to use z-axis offset for depth positioning and x/y offset for planar movement.
 Note: offset(z:) and offset(x:y:) are separate modifiers in visionOS.
*/
struct Offset: View {
    
    // MARK: - State Properties
    
    // Toggle to enable/disable offset animations
    @State var showOffset = false
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 24) {
            
            // Toggle button to enable/disable offset effects
            Toggle("Toggle Offset", isOn: $showOffset.animation())
                .toggleStyle(.button)
            
            HStack(spacing: 24) {
                
                // MARK: - Left Rectangle (Red)
                // Combines z-offset (depth) and positive x-offset (moves right)
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.red)
                    .offset(z: showOffset ? 12 : 0)
                    .offset(x: showOffset ? 48 : 0)
                
                // MARK: - Center Rectangle (Blue)
                // Only uses z-offset to move forward in 3D space
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.blue)
                    .offset(z: showOffset ? 24 : 0)
                
                // MARK: - Right Rectangle (Green)
                // Combines z-offset with negative x-offset (moves left)
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.green)
                    .offset(z: showOffset ? 36 : 0)
                    .offset(x: showOffset ? -48 : 0)
            }
            .padding(12)
        }
        .padding(12)
    }
}

#Preview {
    Offset()
}
