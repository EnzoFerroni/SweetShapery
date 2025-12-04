//
//  WindowTabViews.swift
//  Model3D
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI

// MARK: - Window Tab Views Demo

/*
 Demonstrates the use of TabView in visionOS.
 Shows how to create a tabbed interface with different shapes,
 each with its own tab icon and label for navigation.
*/
struct WindowTabViews: View {
    
    // MARK: - Body
    
    var body: some View {
        TabView {
            
            // MARK: - Circle Tab
            Circle()
                .fill(.red)
                .frame(width: 200, height: 200)
                .tabItem {
                    Image(systemName: "circle.fill")
                    Text("Circle")
                }

            // MARK: - Rectangle Tab
            Rectangle()
                .fill(.green)
                .frame(width: 300, height: 200)
                .tabItem {
                    Image(systemName: "rectangle.fill")
                    Text("Rectangle")
                }

            // MARK: - Capsule Tab
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
