//
//  SpaceIsCoolApp.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 19/07/2024.
//

import SwiftUI

@main
struct SpaceIsCoolApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                APODView<APODViewModel>(viewModel: APODViewModel())
                    .tabItem {
                        Label("APOD", systemImage: "camera.fill")
                    }
                    .accessibilityLabel("Astronomy Picture of the Day")
                
                NEOView<NEOViewModel>(viewModel: NEOViewModel())
                    .tabItem {
                        Label("NEO", systemImage: "asterisk.circle.fill")
                    }
                    .accessibilityLabel("Near Earth Objects")
            }
        }
    }
}
