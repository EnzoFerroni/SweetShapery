////
////  RotationControlView.swift
////  Sweet Shapery
////
////  Created by Enzo Ferroni on 08/12/25.
////
////  NOTE: This view is for SIMULATOR TESTING only.
////  Remove this file for production builds.
////
//
//import SwiftUI
//
///// Controls for rotating the 3D model during simulator testing.
//struct RotationControlView: View {
//    
//    /// Reference to the shared view model.
//    @Bindable var viewModel: ShapeViewModel
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            // Header
//            Text("Rotation (Test)")
//                .font(.headline)
//            
//            // X axis rotation
//            VStack(alignment: .leading, spacing: 4) {
//                Text("X: \(Int(viewModel.rotationX))°")
//                Slider(value: $viewModel.rotationX, in: -180...180)
//                    .tint(.red)
//            }
//            
//            // Y axis rotation
//            VStack(alignment: .leading, spacing: 4) {
//                Text("Y: \(Int(viewModel.rotationY))°")
//                Slider(value: $viewModel.rotationY, in: -180...180)
//                    .tint(.green)
//            }
//            
//            // Z axis rotation
//            VStack(alignment: .leading, spacing: 4) {
//                Text("Z: \(Int(viewModel.rotationZ))°")
//                Slider(value: $viewModel.rotationZ, in: -180...180)
//                    .tint(.blue)
//            }
//            
//            // Reset button
//            Button("Reset") {
//                viewModel.resetRotation()
//            }
//            .buttonStyle(.bordered)
//        }
//        .frame(width: 200)
//    }
//}

// MARK: - [REVIEW]
/// Explorar compile-time if (#if DEBUG) e/ou target membership.
