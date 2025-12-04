//
//  ShapeSelectorView.swift
//  CookieCutter
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI

/// Component for selecting cookie cutter shapes
struct ShapeSelectorView: View {
    
    @Bindable var viewModel: CookieCutterViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Select Shape")
                .font(.headline)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 12) {
                ForEach(viewModel.availableShapes) { shape in
                    ShapeButton(
                        shape: shape,
                        isSelected: viewModel.selectedShape == shape
                    ) {
                        viewModel.selectShape(shape)
                    }
                }
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

/// Individual shape selection button
struct ShapeButton: View {
    
    let shape: CutterShape
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: shape.systemIcon)
                    .font(.title2)
                    .foregroundStyle(shape.color)
                
                Text(shape.rawValue)
                    .font(.caption2)
            }
            .frame(width: 60, height: 60)
            .background(isSelected ? shape.color.opacity(0.2) : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? shape.color : .clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ShapeSelectorView(viewModel: CookieCutterViewModel())
}
