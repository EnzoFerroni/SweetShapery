//
//  WindowTabViews.swift
//  Model3D
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI

struct WindowTabViews: View {
    var body: some View {
        TabView {
            Circle()
                .fill(.red)
                .frame(width: 200, height: 200)
                .tabItem {
                    Image(systemName: "circle.fill")
                    Text("Circle")
                }

            Rectangle()
                .fill(.green)
                .frame(width: 300, height: 200)
                .tabItem {
                    Image(systemName: "rectangle.fill")
                    Text("Rectangle")
                }

            Capsule()
                .fill(.blue)
                .frame(width: 300, height: 200)
                .tabItem {
                    Image(systemName: "capsule.fill")
                    Text("Capsule")
                }
        }
    }
}

#Preview {
    WindowTabViews()
}
