//
//  WindowToolbars.swift
//  Model3D
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI

struct WindowToolbars: View {
    @State private var showOffset = false
    @State private var showRotation = false
    @State private var showGlass = true
    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 24) {
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.red)
                    .offset(x: showOffset ? -20 : 0)
                    .offset(z: showOffset ? 40 : 1)
                    .rotation3DEffect(
                        Angle(degrees: showRotation ? 25 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.blue)
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
        .glassBackgroundEffect(displayMode: showGlass ? .always : .never)
        .persistentSystemOverlays(showGlass ? .visible : .hidden)

        // 1. Add a toolbar
        .toolbar {
            // 2. Create an item group with bottomOrnament placement
            ToolbarItemGroup(placement: .bottomOrnament) {
                Toggle("Offset", isOn: $showOffset.animation())
                    .toggleStyle(.button)

                Toggle("Rotation", isOn: $showRotation.animation())
                    .toggleStyle(.button)

                // Optional: use spaces and dividers to lay out your controls
                Spacer()
                Divider()
                Spacer()

                Toggle("Glass", isOn: $showGlass.animation())
                    .toggleStyle(.button)
            }
        }
    }
}
#Preview {
    WindowToolbars()
}
