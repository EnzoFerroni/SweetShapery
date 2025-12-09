//
//  RotationControlView.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 08/12/25.
//

import SwiftUI

struct RotationControlView: View {
    
    @Bindable var viewModel: ShapeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Rotation (Test)")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("X: \(Int(viewModel.rotationX))°")
                Slider(value: Binding(
                    get: { Double(viewModel.rotationX) },
                    set: { viewModel.rotationX = Float($0) }
                ), in: -180...180)
                    .tint(.red)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Y: \(Int(viewModel.rotationY))°")
                Slider(value: Binding(
                    get: { Double(viewModel.rotationY) },
                    set: { viewModel.rotationY = Float($0) }
                ), in: -180...180)
                    .tint(.green)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Z: \(Int(viewModel.rotationZ))°")
                Slider(value: Binding(
                    get: { Double(viewModel.rotationZ) },
                    set: { viewModel.rotationZ = Float($0) }
                ), in: -180...180)
                    .tint(.blue)
            }
            
            Button("Reset") {
                viewModel.resetRotation()
            }
            .buttonStyle(.bordered)
        }
        .frame(width: 200)
    }
}
