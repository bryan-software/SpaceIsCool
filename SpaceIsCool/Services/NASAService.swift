//
//  NASAService.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 21/07/2024.
//

import Foundation

protocol NASAServicable {
    func getAPOD(
        date: Date?
    ) async throws -> Apod
    
    func getNEO(
        startDate: Date?,
        endDate: Date?
    ) async throws -> Neo
}

struct NASAService: NASAServicable {
    private let apiClient: APIClientProtocol
    
    init(
        apiClient: APIClientProtocol = APIClient()
    ) {
        self.apiClient = apiClient
    }
    
    func getAPOD(
        date: Date? = nil
    ) async throws -> Apod {
        do {
            let apod: Apod = try await apiClient.perform(
                APODRequest.getAPOD(date: date?.inYYYYMMDD())
            )
            return apod
        } catch {
            throw error
        }
    }
    
    func getNEO(
        startDate: Date? = nil,
        endDate: Date? = nil
    ) async throws -> Neo {
        do {
            let neo: Neo = try await apiClient.perform(
                NEORequest.getNEO(
                    startDate: startDate?.inYYYYMMDD(),
                    endDate: endDate?.inYYYYMMDD()
                )
            )
            return neo
        } catch {
            throw error
        }
    }
}

#if DEBUG
final class MockNASAService: NASAServicable {
    func getAPOD(date: Date?) async throws -> Apod {
        .mock()
    }
    
    func getNEO(startDate: Date?, endDate: Date?) async throws -> Neo {
        .mock()
    }
}
#endif
