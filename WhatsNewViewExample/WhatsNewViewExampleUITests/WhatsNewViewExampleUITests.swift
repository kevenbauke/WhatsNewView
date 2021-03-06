//
//  WhatsNewViewExampleUITests.swift
//  WhatsNewViewExampleUITests
//
//  Created by Keven Bauke on 15.02.21.
//

import XCTest

class WhatsNewViewExampleUITests: XCTestCase {

	private let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

		setupSnapshot(app)
		app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCodeOnly() throws {
		app.scrollViews.otherElements.buttons["Configuration (Code only)"].tap()
		snapshot("Code Only")
		app.buttons["OK"].tap()

		app.scrollViews.otherElements.buttons["Arabic"].tap()
		snapshot("Arabic")
		app.buttons["بداية"].tap()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
