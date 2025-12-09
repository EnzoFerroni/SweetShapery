//
//  ControlsView.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI

struct ControlsView: View {
    
    @Bindable var viewModel: ShapeViewModel
    @Binding var isImmersiveOpen: Bool
    var openSpace: () -> Void
    var closeSpace: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("3D View")
                Spacer()
                Toggle("", isOn: Binding(
                    get: { isImmersiveOpen },
                    set: { newValue in
                        if newValue {
                            openSpace()
                        }
                        else {
                            closeSpace()
                        }
                    }
                ))
                .labelsHidden()
                .tint(.green)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Transparency")
                Slider(value: Binding(
                    get: { Double(viewModel.transparency) },
                    set: { viewModel.transparency = Float($0) }
                ), in: 0.1...1.0)
                    .tint(.gray)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Size")
                Slider(value: Binding(
                    get: { Double(viewModel.scale) },
                    set: { viewModel.scale = Float($0) }
                ), in: 0.1...3.0)
                    .tint(.gray)
            }
        }
        .frame(width: 200)
    }
}
