//
//  Hover.swift
//  Model3D
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI

// MARK: - Hover Effects Demo

/*
 Demonstrates various hover effects available in visionOS.
 Includes system-provided effects (automatic, highlight, lift)
 and custom effects (fade, scale, tilt, mashup).
 All effects can be toggled on/off with a single button.
*/
struct Hover: View {

    // MARK: - State Properties
    
    // Toggle to enable/disable all hover effects globally
    @State var enableHoverEffect: Bool = false

    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 12) {
            
            // Toggle button to enable or disable all hover effects
            Toggle("Hover Effect", isOn: $enableHoverEffect)
                .toggleStyle(.button)
            
            // Grid layout to organize hover effect demonstrations
            Grid(alignment: .center, horizontalSpacing: 24, verticalSpacing: 12) {
                
                // MARK: - System Hover Effects Section
                GridRow {
                    Text("System Hover Effects")
                        .font(.headline)
                        .gridCellColumns(3)
                }
                
                GridRow {
                    // Automatic effect - defaults to highlight behavior
                    Capsule()
                        .foregroundStyle(.regularMaterial)
                        .overlay(Text("automatic"))
                        .hoverEffect(.automatic, isEnabled: enableHoverEffect)

                    // Highlight effect - emphasizes the element on hover
                    Capsule()
                        .foregroundStyle(.regularMaterial)
                        .overlay(Text("highlight"))
                        .hoverEffect(.highlight, isEnabled: enableHoverEffect)
                    
                    // Lift effect - creates elevation appearance on hover
                    Capsule()
                        .foregroundStyle(.regularMaterial)
                        .overlay(Text("lift"))
                        .hoverEffect(.lift, isEnabled: enableHoverEffect)
                }

                // MARK: - Custom Hover Effects Section
                GridRow {
                    Text("Custom Hover Effects")
                        .font(.headline)
                        .gridCellColumns(3)
                }
                
                GridRow {
                    // Custom fade effect - reduces opacity on hover
                    Capsule()
                        .foregroundStyle(.regularMaterial)
                        .overlay(Text("Custom: fade"))
                        .hoverEffect(FadeHoverEffect(), isEnabled: enableHoverEffect)
                    
                    // Custom scale effect - enlarges element on hover
                    Capsule()
                        .foregroundStyle(.regularMaterial)
                        .overlay(Text("Custom: scale"))
                        .hoverEffect(ScaleHoverEffect(), isEnabled: enableHoverEffect)
                    
                    // Custom tilt effect - rotates element on hover
                    Capsule()
                        .foregroundStyle(.regularMaterial)
                        .overlay(Text("Custom: tilt"))
                        .hoverEffect(TiltHoverEffect(), isEnabled: enableHoverEffect)
                }
                
                // MARK: - Default Hover Effect Section
                GridRow {
                    Text("Default set on parent using defaultHoverEffect()")
                        .font(.headline)
                        .gridCellColumns(3)
                }
                
                // These elements inherit the mashup effect from their parent row
                GridRow {
                    Capsule()
                        .foregroundStyle(.regularMaterial)
                        .overlay(Text("Custom: mashup"))
                        .hoverEffect(isEnabled: enableHoverEffect)
                    
                    Capsule()
                        .foregroundStyle(.regularMaterial)
                        .overlay(Text("Custom: mashup"))
                        .hoverEffect(isEnabled: enableHoverEffect)
                    
                    Capsule()
                        .foregroundStyle(.regularMaterial)
                        .overlay(Text("Custom: mashup"))
                        .hoverEffect(isEnabled: enableHoverEffect)
                }
                // Sets default custom hover effect for all children in this row
                .defaultHoverEffect(CustomMashupHoverEffect())
            }
            .frame(maxHeight: 300)
        }
        .padding()
    }
}

// MARK: - Custom Hover Effect Implementations

/// Custom hover effect that fades the element's opacity to 50%
struct FadeHoverEffect: CustomHoverEffect {
    func body(content: Content) -> some CustomHoverEffect {
        content.hoverEffect { effect, isActive, proxy in
            effect.animation(.easeOut) {
                $0.opacity(isActive ? 0.5 : 1)
            }
        }
    }
}

/// Custom hover effect that scales the element to 120%
struct ScaleHoverEffect: CustomHoverEffect {
    func body(content: Content) -> some CustomHoverEffect {
        content.hoverEffect { effect, isActive, proxy in
            effect.animation(.easeOut) {
                $0.scaleEffect(
                    isActive ? CGSize(width: 1.2, height: 1.2) : CGSize(width: 1, height: 1),
                    anchor: .center
                )
            }
        }
    }
}

/// Custom hover effect that tilts the element 15 degrees
struct TiltHoverEffect: CustomHoverEffect {
    func body(content: Content) -> some CustomHoverEffect {
        content.hoverEffect { effect, isActive, proxy in
            effect.animation(.easeOut) {
                $0.rotationEffect(.degrees(isActive ? 15 : 0), anchor: .bottomTrailing)
            }
        }
    }
}

/// Custom hover effect combining opacity, rotation, and scale
struct CustomMashupHoverEffect: CustomHoverEffect {
    func body(content: Content) -> some CustomHoverEffect {
        content.hoverEffect { effect, isActive, proxy in
            effect.animation(.easeOut) {
                $0.opacity(isActive ? 1 : 0.5)
                    .rotationEffect(.degrees(isActive ? 10 : 0), anchor: .center)
                    .scaleEffect(
                        isActive ? CGSize(width: 1.1, height: 1.1) : CGSize(width: 1, height: 1),
                        anchor: .center
                    )
            }
        }
    }
}

#Preview{
    Hover()
}
