//
//  ShapePreviewView.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI

struct ShapePreviewView: View {
    
    let shape: CutterShape
    
    var body: some View {
        VStack(spacing: 8) {
            Text(shape.displayName)
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Image(systemName: shape.icon)
                .font(.system(size: 80))
                .foregroundStyle(.white)
                .frame(width: 160, height: 160)
                .background(.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 16))
        }
    }
}
