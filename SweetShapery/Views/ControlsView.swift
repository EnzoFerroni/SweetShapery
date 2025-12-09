//
//  ControlsView.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI

/// Controls panel for adjusting the 3D model properties.
struct ControlsView: View {
    
    /// Reference to the shared view model.
    @Bindable var viewModel: ShapeViewModel
    
    /// Whether the immersive space is currently open.
    @Binding var isImmersiveOpen: Bool
    
    /// Callback to open the immersive space.
    var openSpace: () -> Void
    
    /// Callback to close the immersive space.
    var closeSpace: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Toggle for 3D view
            HStack {
                Text("3D View")
                Spacer()
                Toggle("", isOn: $isImmersiveOpen)
                    .labelsHidden()
                    .tint(.accent)
                    .onChange(of: isImmersiveOpen) { _, newValue in
                        if newValue {
                            openSpace()
                        }
                        else {
                            closeSpace()
                        }
                    }
            }
            
            // Transparency slider
            VStack(alignment: .leading, spacing: 4) {
                Text("Transparency")
                Slider(value: $viewModel.transparency, in: 0.1...1.0)
                    .tint(.gray)
            }
            
            // Size slider
            VStack(alignment: .leading, spacing: 4) {
                Text("Size")
                Slider(value: $viewModel.scale, in: 0.1...3.0)
                    .tint(.gray)
            }
        }
        .frame(width: 200)
    }
}
