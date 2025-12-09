//
//  ShapeSidebarView.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI

struct ShapeSidebarView: View {
    
    @Bindable var viewModel: ShapeViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(viewModel.allShapes) { shape in
                Button {
                    viewModel.selectedShape = shape
                }
                label: {
                    Image(systemName: shape.icon)
                        .font(.title2)
                        .foregroundStyle(viewModel.selectedShape == shape ? .green : .white)
                        .frame(width: 44, height: 44)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(12)
        .glassBackgroundEffect()
    }
}
