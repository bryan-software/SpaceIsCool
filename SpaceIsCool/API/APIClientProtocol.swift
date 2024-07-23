//
//  APIClientProtocol.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 19/07/2024.
//

import Foundation

protocol APIClientProtocol {
    func perform<T: Codable>(_ request: RequestProtocol) async throws -> T
}
