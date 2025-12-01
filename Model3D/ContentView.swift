//
//  ContentView.swift
//  Model3D
//
//  Created by Enzo Ferroni on 28/11/25.
//

import SwiftUI

/// The main launch view for the 3D Model POC application.
///
/// This view serves as the entry point for the application, providing controls
/// to open and close a separate window containing the interactive 3D model.
/// It demonstrates visionOS window management capabilities.
struct ContentView: View {
    
    // MARK: - Environment Properties
    
    /// Environment action to open windows in visionOS.
    /// Used to display the iPhoneWindow containing the 3D model.
    @Environment(\.openWindow) private var openWindow
    
    /// Environment action to dismiss windows in visionOS.
    /// Used to close the iPhoneWindow when no longer needed.
    @Environment(\.dismissWindow) private var dismissWindow
    
    // MARK: - State Properties
    
    /// Tracks whether the 3D model window is currently open.
    /// This state determines the button's label and action.
    @State private var isWindowOpen: Bool = false

    // MARK: - Body
    
    var body: some View {
        Text("Hello, World!")
        
        Button(isWindowOpen ? "Close iPhone Window" : "Open iPhone Window") {
            if isWindowOpen {
                dismissWindow(id: "iPhoneWindow")
                isWindowOpen = false
            }
            else {
                openWindow(id: "iPhoneWindow")
                isWindowOpen = true
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
