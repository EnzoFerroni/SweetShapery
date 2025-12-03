//
//  Offset.swift
//  Model3D
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI


struct Offset: View {
    
    @State var showOffset = false
    
    var body: some View {
        VStack(spacing: 24) {
            
            Toggle("Toggle Offset", isOn: $showOffset.animation())
                .toggleStyle(.button)
            
            HStack(spacing: 24) {
                
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.red)
                // offset(z:) and offset(x:y:) are different modifiers!
                    .offset(z: showOffset ? 12 : 0)
                    .offset(x: showOffset ? 48 : 0)
                
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.blue)
                    .offset(z: showOffset ? 24 : 0)
                
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.green)
                    .offset(z: showOffset ? 36 : 0)
                    .offset(x: showOffset ? -48 : 0)
            }
            .padding(12)
        }
        .padding(12)
    }
}

#Preview {
    Offset()
}
