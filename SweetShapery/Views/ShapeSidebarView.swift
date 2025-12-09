//
//  ShapeSidebarView.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI

/// Sidebar with buttons to select different shapes.
struct ShapeSidebarView: View {
    
    /// Reference to the shared view model.
    @Bindable var viewModel: ShapeViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(viewModel.allShapes) { shape in
                // Shape selection button
                Button {
                    viewModel.selectedShape = shape
                }
                label: {
                    Image(systemName: shape.icon)
                        .font(.title2)
                        .foregroundStyle(viewModel.selectedShape == shape ? .accent : .white)
                        .frame(width: 44, height: 44)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(12)
        .glassBackgroundEffect()
    }
}
