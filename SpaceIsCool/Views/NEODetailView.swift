//
//  NEODetailView.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 23/07/2024.
//

import SwiftUI

struct NEODetailView: View {
    let nearEarthObject: NearEarthObject
    
    var body: some View {
        VStack {
            Text("Absolute Magnitude: \(nearEarthObject.absoluteMagnitudeH)")
        }
        .navigationTitle(nearEarthObject.name)
    }
}

#Preview {
    NEODetailView(nearEarthObject: .mock())
}
