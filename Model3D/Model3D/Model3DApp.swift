//
//  Model3DApp.swift
//  Model3D
//
//  Created by Enzo Ferroni on 01/12/25.
//

import SwiftUI

/// The main entry point for the 3D Model POC application.
///
/// This app demonstrates visionOS window management by creating two window groups:
/// - A main launch window with controls
/// - A secondary window for displaying and interacting with a 3D model
///
/// The implementation showcases:
/// - Multiple window management in visionOS
/// - Default window sizing for optimal 3D content display
/// - Separation of concerns between UI controls and 3D content
@main
struct Model3DApp: App {
    
    var body: some Scene {
        // Main launch window containing controls
        WindowGroup {
            ContentView()
        }
        
        // Secondary window for 3D model interaction
        // The defaultSize modifier sets initial dimensions optimized for 3D content
        // Users can resize the window, and the system restores the last size on relaunch
        WindowGroup(id: "iPhoneWindow") {
            iPhoneModel3DView()
        }
        .defaultSize(width: 500, height: 500)
    }
}
