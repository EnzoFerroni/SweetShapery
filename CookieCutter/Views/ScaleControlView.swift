//
//  ScaleControlView.swift
//  CookieCutter
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI

/// Component for controlling cookie cutter scale
struct ScaleControlView: View {
    
    @Bindable var viewModel: CookieCutterViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Scale: \(viewModel.scalePercentage)%")
                .font(.headline)
                .monospacedDigit()
            
            HStack(spacing: 16) {
                ScaleButton(icon: "minus.circle.fill", disabled: viewModel.currentScale <= viewModel.minScale) {
                    viewModel.decreaseScale()
                }
                
                ScaleButton(icon: "arrow.counterclockwise.circle.fill", disabled: false) {
                    viewModel.resetScale()
                }
                
                ScaleButton(icon: "plus.circle.fill", disabled: viewModel.currentScale >= viewModel.maxScale) {
                    viewModel.increaseScale()
                }
            }
            
            Slider(
                value: Binding(
                    get: { Double(viewModel.currentScale) },
                    set: { viewModel.setScale(Float($0)) }
                ),
                in: Double(viewModel.minScale)...Double(viewModel.maxScale),
                step: 0.1
            )
            .frame(width: 180)
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

/// Reusable scale control button
struct ScaleButton: View {
    
    let icon: String
    let disabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title2)
        }
        .buttonStyle(.borderless)
        .disabled(disabled)
    }
}

#Preview {
    ScaleControlView(viewModel: CookieCutterViewModel())
}
