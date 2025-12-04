//
//  CookieCutterApp.swift
//  CookieCutter
//
//  Created by Enzo Ferroni on 03/12/25.
//

import SwiftUI

@main
struct CookieCutterApp: App {

    @State private var viewModel = CookieCutterViewModel()
    @State private var immersionStyle: ImmersionStyle = .mixed

    var body: some Scene {
        // Control Panel Window
        WindowGroup {
            ControlPanelView()
                .environment(viewModel)
        }
        .windowResizability(.contentSize)
        
        // Immersive Space for 3D Cookie Cutter
        ImmersiveSpace(id: "CutterSpace") {
            ImmersiveCutterView(viewModel: viewModel)
        }
        .immersionStyle(selection: $immersionStyle, in: .mixed)
    }
}
