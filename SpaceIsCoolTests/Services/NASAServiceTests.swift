//
//  NASAServiceTests.swift
//  SpaceIsCoolTests
//
//  Created by Dom Bryan on 21/07/2024.
//

import XCTest

@testable import SpaceIsCool

final class NASAServiceTests: XCTestCase {
    var apiClient: APIClientProtocol!
    var sut: NASAService!
    
    override func tearDown() {
        super.tearDown()
        apiClient = nil
        sut = nil
    }

    func test_getAPOD_returnsAPOD() async throws {
        // GIVEN
        let data = try JSONEncoder().encode(Apod.mock())
        apiClient = MockAPIClient(data: data)
        sut = .init(apiClient: apiClient)
        
        // WHEN
        do {
            let apod = try await sut.getAPOD()
            // THEN
            XCTAssertEqual(apod.copyright, "Dominic Bryan")
        } catch {
            XCTFail("Error thrown")
        }
    }
    
    func test_getAPOD_throwsDecodingError() async {
        // GIVEN
        apiClient = MockAPIClient(data: Data())
        sut = .init(apiClient: apiClient)
        
        // WHEN
        do {
            let apod = try await sut.getAPOD()
        } catch {
            // THEN
            XCTAssertNotNil(error)
        }
    }
    
    func test_getNEOs_returnsNEOs() async throws {
        // GIVEN
        let data = try JSONEncoder().encode(Neo.mock())
        apiClient = MockAPIClient(data: data)
        sut = .init(apiClient: apiClient)
        
        // WHEN
        do {
            let neo = try await sut.getNEO()
            // THEN
            XCTAssertEqual(neo.elementCount, 999)
        } catch {
            XCTFail("Error thrown")
        }
    }
    
    func test_getNEOs_throwsDecodingError() async {
        // GIVEN
        apiClient = MockAPIClient(data: Data())
        sut = .init(apiClient: apiClient)
        
        // WHEN
        do {
            let neo = try await sut.getNEO()
        } catch {
            // THEN
            XCTAssertNotNil(error)
        }
    }

}
