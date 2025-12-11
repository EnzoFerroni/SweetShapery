//
//  ContentView.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI

/// Main content view of the application.
/// Displays the shape preview, controls, and sidebar.
struct ContentView: View {
    
    /// Reference to the shared view model.
    @Bindable var viewModel: ShapeViewModel
    
    /// Environment action to open immersive space.
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    /// Environment action to close immersive space.
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    /// Tracks if the immersive space is currently shown.
    @State private var immersiveSpaceIsShown = false
    
    var body: some View {
        HStack(spacing: 24) {
            // Main controls section
            VStack(spacing: 24) {
                ShapePreviewView(shape: viewModel.selectedShape)
                ControlsView(
                    viewModel: viewModel,
                    isImmersiveOpen: $immersiveSpaceIsShown,
                    openSpace: openSpace,
                    closeSpace: closeSpace
                )
            }
            
            // Rotation controls (simulator testing only)
//            RotationControlView(viewModel: viewModel)
        }
        .padding(24)
        .ornament(attachmentAnchor: .scene(.leading)) {
            ShapeSidebarView(viewModel: viewModel)
        }
    }
    
    // MARK: - Immersive Space Methods
    
    /// Opens the immersive 3D space.
    private func openSpace() {
        Task {
            let result = await openImmersiveSpace(id: "ImmersiveShape")
            if case .opened = result {
                immersiveSpaceIsShown = true
            }
        }
    }
    
    /// Closes the immersive 3D space.
    private func closeSpace() {
        Task {
            await dismissImmersiveSpace()
            immersiveSpaceIsShown = false
        }
    }
}

// MARK: - [REVIEW]
/// Código bem organizado, apenas atenção a
/// métodos definidos diretamente dentro de views.
