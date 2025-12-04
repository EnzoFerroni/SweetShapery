//
//  WindowToolbars.swift
//  Model3D
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI

// MARK: - Window Toolbars Demo

/*
 Demonstrates the use of toolbars in visionOS windows.
 Shows how to add a bottom ornament toolbar with toggle controls
 for offset, rotation, and glass background effects.
*/
struct WindowToolbars: View {
    
    // MARK: - State Properties
    
    @State private var showOffset = false
    @State private var showRotation = false
    @State private var showGlass = true
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 24) {
                
                // MARK: - Left Rectangle (Red)
                // Responds to offset and rotation toggles
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.red)
                    .offset(x: showOffset ? -20 : 0)
                    .offset(z: showOffset ? 40 : 1)
                    .rotation3DEffect(
                        Angle(degrees: showRotation ? 25 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
                
                // MARK: - Center Rectangle (Blue)
                // Stays static as reference point
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.blue)
                
                // MARK: - Right Rectangle (Green)
                // Responds to offset and rotation toggles (mirrored)
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.green)
                    .offset(x: showOffset ? 20 : 0)
                    .offset(z: showOffset ? 40 : 1)
                    .rotation3DEffect(
                        Angle(degrees: showRotation ? -25 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
            }
            .frame(height: 260)
        }
        .frame(height: 400)
        .padding(12)
        // Glass background effect that can be toggled
        .glassBackgroundEffect(displayMode: showGlass ? .always : .never)
        .persistentSystemOverlays(showGlass ? .visible : .hidden)

        // MARK: - Bottom Ornament Toolbar
        // Toolbar attached to bottom of window with control toggles
        .toolbar {
            ToolbarItemGroup(placement: .bottomOrnament) {
                
                // Toggle for offset effect
                Toggle("Offset", isOn: $showOffset.animation())
                    .toggleStyle(.button)

                // Toggle for rotation effect
                Toggle("Rotation", isOn: $showRotation.animation())
                    .toggleStyle(.button)

                Spacer()
                Divider()
                Spacer()

                // Toggle for glass background
                Toggle("Glass", isOn: $showGlass.animation())
                    .toggleStyle(.button)
            }
        }
    }
}

#Preview {
    WindowToolbars()
}
