//
//  APODViewModel.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 21/07/2024.
//

import Foundation

protocol APODViewModelable: ObservableObject {
    var viewState: APODViewModel.ViewState { get }
    
    func getAPOD()
}

final class APODViewModel: APODViewModelable {
    private let nasaService: NASAServicable
    
    enum ViewState {
        case loading
        case completed(ViewData)
        case failed(String)
    }
    
    struct ViewData {
        let title: String
        let copyright: String
        let date: String
        let explanation: String
        let url: String
    }
    
    @Published private(set) var viewState: ViewState
    
    init(
        nasaService: NASAServicable = NASAService(),
        viewState: ViewState = .loading
    ) {
        self.nasaService = nasaService
        self.viewState = viewState
    }
    
    @MainActor
    func getAPOD() {
        Task {
            do {
                let apod = try await nasaService.getAPOD(date: nil)
                viewState = .completed(viewData(apod: apod))
            } catch {
                viewState = .failed(error.localizedDescription)
            }
        }
    }
    
    private func viewData(apod: Apod) -> ViewData {
        .init(
            title: apod.title,
            copyright: apod.copyright ?? "Copyright",
            date: apod.date ?? "Unknown",
            explanation: apod.explanation ?? "No information found.",
            url: apod.url
        )
    }
}
