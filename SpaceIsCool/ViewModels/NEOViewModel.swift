//
//  NEOViewModel.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 21/07/2024.
//

import Foundation

protocol NEOViewModelable: ObservableObject {
    var viewState: NEOViewModel.ViewState { get }
    
    func getNEOs()
}

final class NEOViewModel: NEOViewModelable {
    private let nasaService: NASAServicable
    
    enum ViewState {
        case loading
        case completed(Neo)
        case failed(String)
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
    func getNEOs() {
        Task {
            do {
                let neo = try await nasaService.getNEO(startDate: Date(), endDate: nil)
                viewState = .completed(neo)
            } catch {
                viewState = .failed(error.localizedDescription)
            }
        }
    }
}
