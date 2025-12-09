//
//  SweetShaperyApp.swift
//  Sweet Shapery
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI

@main
struct SweetShaperyApp: App {

    @State private var viewModel = ShapeViewModel()
    @State private var immersionStyle: ImmersionStyle = .mixed

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
        .windowResizability(.contentSize)
        
        ImmersiveSpace(id: "ImmersiveShape") {
            ImmersiveView(viewModel: viewModel)
        }
        .immersionStyle(selection: $immersionStyle, in: .mixed)
    }
}
