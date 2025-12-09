//
//  ContentView.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 04/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @Bindable var viewModel: ShapeViewModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @State private var immersiveSpaceIsShown = false
    
    var body: some View {
        HStack(spacing: 24) {
            VStack(spacing: 24) {
                ShapePreviewView(shape: viewModel.selectedShape)
                ControlsView(
                    viewModel: viewModel,
                    isImmersiveOpen: $immersiveSpaceIsShown,
                    openSpace: openSpace,
                    closeSpace: closeSpace
                )
            }
            
            RotationControlView(viewModel: viewModel)
        }
        .padding(24)
        .ornament(attachmentAnchor: .scene(.leading)) {
            ShapeSidebarView(viewModel: viewModel)
        }
    }
    
    private func openSpace() {
        Task {
            let result = await openImmersiveSpace(id: "ImmersiveShape")
            if case .opened = result {
                immersiveSpaceIsShown = true
            }
        }
    }
    
    private func closeSpace() {
        Task {
            await dismissImmersiveSpace()
            immersiveSpaceIsShown = false
        }
    }
}
