//
//  NEOView.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 21/07/2024.
//

import SwiftUI

struct NEOView<ViewModel: NEOViewModelable>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                Text("Loading...")
            case .completed(let neo):
                VStack {
                    list(neo)
                }
            case .failed(let string):
                Text(string)
            }
        }
        .onFirstAppear {
            viewModel.getNEOs()
        }
    }
    
    @ViewBuilder
    private func list(_ neo: Neo) -> some View {
        NavigationView {
            List {
                ForEach(neo.nearEarthObjects.keys.sorted(), id: \.self) { section in
                    listSection(for: section, neo: neo)
                }
                .listStyle(.grouped)
            }
        }
    }
    
    @ViewBuilder
    private func listSection(for section: String, neo: Neo) -> some View {
        Section(section) {
            ForEach(neo.nearEarthObjects[section] ?? [], id: \.id) { item in
                NavigationLink {
                    NEODetailView(nearEarthObject: item)
                } label: {
                    HStack {
                        Text("Name: \(item.name)")
                        if item.isPotentiallyHazardousAsteroid {
                            Spacer()
                            Text("Hazardous")
                            Image(systemName: "hazardsign.fill")
                        }
                    }
                    .accessibilityHint("Select this Near Earth Object to get more details.")
                }
            }
        }
    }
}

#Preview {
    NEOView<NEOViewModel>(
        viewModel: .init(
            nasaService: MockNASAService()
        )
    )
}
