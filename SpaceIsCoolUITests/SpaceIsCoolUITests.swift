//
//  SpaceIsCoolUITests.swift
//  SpaceIsCoolUITests
//
//  Created by Dom Bryan on 19/07/2024.
//

import XCTest

final class SpaceIsCoolUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        continueAfterFailure = false
    }

    override func tearDown() {
        super.tearDown()
        app = nil
    }

    func test_neoTab_canSeeNEOs() throws {
        app.launch()

        app.tabBars.buttons["NEO"].tap()
    }
}
