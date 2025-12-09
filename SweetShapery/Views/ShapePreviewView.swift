//
//  ShapePreviewView.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI

/// Displays a preview of the selected shape with its icon and name.
struct ShapePreviewView: View {
    
    /// The shape to preview.
    let shape: CutterShape
    
    var body: some View {
        VStack(spacing: 8) {
            // Shape name
            Text(shape.displayName)
                .font(.headline)
                .foregroundStyle(.secondary)
            
            // Shape icon
            Image(systemName: shape.icon)
                .font(.system(size: 80))
                .foregroundStyle(.white)
                .frame(width: 160, height: 160)
                .background(.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 16))
        }
    }
}
