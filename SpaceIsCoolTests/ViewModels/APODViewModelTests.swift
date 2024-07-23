//
//  APODViewModelTests.swift
//  SpaceIsCoolTests
//
//  Created by Dom Bryan on 22/07/2024.
//

import Combine
import XCTest

@testable import SpaceIsCool

final class APODViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var sut: APODViewModel!
    var nasaService: MockNASAService!

    override func setUp() {
        super.setUp()
        nasaService = .init()
        sut = .init(
            nasaService: nasaService
        )
    }
    
    override func tearDown() {
        super.tearDown()
        nasaService = nil
        sut = nil
    }

    func test_getAPOD_returnsAPODAndViewStateIsComplete() async {
        // GIVEN
        let expectation = XCTestExpectation(description: "ViewState is completed")
        
        // WHEN
        await sut.getAPOD()
        
        // THEN
        sut.$viewState.sink { state in
            switch state {
            case .completed(let apod):
                XCTAssertEqual(apod.copyright, "Dominic Bryan")
                expectation.fulfill()
            default: break
            }
        }
        .store(in: &cancellables)
    }

}
