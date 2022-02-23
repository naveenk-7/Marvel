//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Naveen Kumar on 22/02/22.
//

import XCTest

class MarvelUITests: XCTestCase {
    
    let app = XCUIApplication()
    let marvel = "Marvel"
    let man = "3-D Man"
    let bombHas = "A-Bomb (HAS)"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMarvel() {
        XCTAssertTrue(app.navigationBars[marvel].waitForExistence(timeout: 10))
        XCTAssertTrue(app.staticTexts[man].waitForExistence(timeout: 10))
        app.swipeUp()
        app.swipeUp()
        app.swipeDown()
        app.swipeDown()
        XCTAssertTrue(app.staticTexts[bombHas].waitForExistence(timeout: 3))
        app.staticTexts[bombHas].tap()
        XCTAssertTrue(app.navigationBars[bombHas].waitForExistence(timeout: 2))
        XCTAssertTrue(app.navigationBars.buttons[marvel].exists)
        app.navigationBars.buttons[marvel].tap()
    }

}
