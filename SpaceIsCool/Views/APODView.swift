//
//  APODView.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 21/07/2024.
//

import SwiftUI

struct APODView<ViewModel: APODViewModelable>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                    .controlSize(.large)
                case .completed(let viewData):
                    content(viewData: viewData)
                case .failed(let string):
                    Text(string)
                }
            }
            .padding()
            .onFirstAppear {
                viewModel.getAPOD()
            }
        }
    }
    
    @ViewBuilder
    private func content(viewData: APODViewModel.ViewData) -> some View {
        VStack(spacing: 8.0) {
            Text(viewData.title)
                .font(.title)
            
            AsyncImage(url: URL(string: viewData.url)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
                    .controlSize(.large)
            }
            
            Text("\(viewData.copyright) - \(viewData.date)")
                .font(.caption)
            
            Text(viewData.explanation)
                .font(.body)
        }
    }
}

#Preview {
    APODView<APODViewModel>(
        viewModel: .init(
            nasaService: MockNASAService()
        )
    )
}
