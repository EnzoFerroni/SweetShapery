//
//  RotationControlView.swift
//  CookieCutter
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI

/// Component for controlling cookie cutter rotation
struct RotationControlView: View {
    
    @Bindable var viewModel: CookieCutterViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Rotation: \(viewModel.rotationDegrees)°")
                .font(.headline)
                .monospacedDigit()
            
            HStack(spacing: 16) {
                RotationButton(icon: "arrow.counterclockwise", label: "Left") {
                    viewModel.rotateLeft()
                }
                
                RotationButton(icon: "arrow.circlepath", label: "Reset") {
                    viewModel.resetRotation()
                }
                
                RotationButton(icon: "arrow.clockwise", label: "Right") {
                    viewModel.rotateRight()
                }
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

/// Reusable rotation control button
struct RotationButton: View {
    
    let icon: String
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.title2)
                Text(label)
                    .font(.caption2)
            }
        }
        .buttonStyle(.borderless)
    }
}

#Preview {
    RotationControlView(viewModel: CookieCutterViewModel())
}
