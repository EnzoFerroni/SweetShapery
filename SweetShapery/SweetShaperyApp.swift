//
//  SweetShaperyApp.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI

/// Main entry point of the Sweet Shapery application.
@main
struct SweetShaperyApp: App {
    
    /// Shared view model for the entire app.
    @State private var viewModel = ShapeViewModel()
    
    /// Style for the immersive space (mixed reality).
    @State private var immersionStyle: ImmersionStyle = .mixed
    
    var body: some Scene {
        // Main window with controls
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
        .windowResizability(.contentSize)
        
        // Immersive 3D space for viewing shapes
        ImmersiveSpace(id: "ImmersiveShape") {
            ImmersiveView(viewModel: viewModel)
        }
        .immersionStyle(selection: $immersionStyle, in: .mixed)
    }
}
