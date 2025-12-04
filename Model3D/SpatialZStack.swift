//
//  SpatialZStack.swift
//  Model3D
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI

// MARK: - Spatial ZStack Demo

/*
 Demonstrates three different approaches to create depth in ZStack layouts:
 1. Using ZStack spacing to evenly distribute views in depth
 2. Using Spacers to push views to front/back of the depth range
 3. Using individual frame depth on each child view
*/
struct SpatialZStack: View {
    
    // MARK: - State Properties
    
    @State var spacing: CGFloat = 0.0
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 24) {
            
            // Slider to control depth spacing for all examples
            Slider(value: $spacing,
                   in: 0...100,
                   minimumValueLabel: Image(systemName: "square.fill"),
                   maximumValueLabel: Image(systemName: "square.stack.3d.down.forward.fill"),
                   label: {
                Text("Spacing")
            })
            .frame(width: 300)

            HStack {

                // MARK: - Approach 1: ZStack Spacing
                // Space views evenly in depth using parent ZStack spacing property
                ZStack(spacing: spacing / 3) {
                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundStyle(.red)
                        .frame(width: 200, height: 200)

                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundStyle(.green)
                        .frame(width: 150, height: 150)

                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundStyle(.blue)
                        .frame(width: 100, height: 100)
                }
                .frame(depth: spacing)

                // MARK: - Approach 2: Spacers
                // Use Spacers to fill available depth space in ZStack
                ZStack() {
                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundStyle(.red)
                        .frame(width: 200, height: 200)

                    // Pushes the first view to the back
                    Spacer()

                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundStyle(.green)
                        .frame(width: 150, height: 150)

                    // Pushes the last view to the front
                    Spacer()

                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundStyle(.blue)
                        .frame(width: 100, height: 100)
                }
                .frame(depth: spacing)

                // MARK: - Approach 3: Individual Depth
                // Each child view defines its own depth allocation
                ZStack() {
                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundStyle(.red)
                        .frame(width: 200, height: 200)
                        .frame(depth: spacing / 3)

                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundStyle(.green)
                        .frame(width: 150, height: 150)
                        .frame(depth: spacing / 3)

                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundStyle(.blue)
                        .frame(width: 100, height: 100)
                        .frame(depth: spacing / 3)
                }
                .frame(depth: spacing)

            }

            .padding()
        }
    }
}

#Preview {
    SpatialZStack()
}
