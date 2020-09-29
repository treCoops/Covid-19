//
//  Covid_19UITests.swift
//  Covid-19UITests
//
//  Created by treCoops on 9/14/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import XCTest

class Covid_19UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testSurvey() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Update"].tap()
        app.buttons["next"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element(boundBy: 0)/*@START_MENU_TOKEN@*/.buttons["Medium"]/*[[".segmentedControls.buttons[\"Medium\"]",".buttons[\"Medium\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let element2 = element.children(matching: .other).element(boundBy: 1)
        element2/*@START_MENU_TOKEN@*/.buttons["Medium"]/*[[".segmentedControls.buttons[\"Medium\"]",".buttons[\"Medium\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let element3 = element.children(matching: .other).element(boundBy: 2)
        element3/*@START_MENU_TOKEN@*/.buttons["High"]/*[[".segmentedControls.buttons[\"High\"]",".buttons[\"High\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element3/*@START_MENU_TOKEN@*/.buttons["Medium"]/*[[".segmentedControls.buttons[\"Medium\"]",".buttons[\"Medium\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element2/*@START_MENU_TOKEN@*/.buttons["High"]/*[[".segmentedControls.buttons[\"High\"]",".buttons[\"High\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["UPDATE"]/*[[".buttons[\"UPDATE\"].staticTexts[\"UPDATE\"]",".staticTexts[\"UPDATE\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Success"].scrollViews.otherElements.buttons["OK"].tap()
        
    }
    
    
    func testViewsSurveyResults() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Settings"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["View Survey Result"]/*[[".buttons[\"View Survey Result\"].staticTexts[\"View Survey Result\"]",".staticTexts[\"View Survey Result\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["By Date"]/*[[".segmentedControls.buttons[\"By Date\"]",".buttons[\"By Date\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["By Score"]/*[[".segmentedControls.buttons[\"By Score\"]",".buttons[\"By Score\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testTempUpdate() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Update"].tap()
        app.sliders["33%"].swipeRight()
        app.buttons["UPDATE"].tap()
        app.alerts["Success"].scrollViews.otherElements.buttons["OK"].tap()
        
        
    }
    
    func testNewsPush() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Update"].tap()
        app.buttons["add"].tap()
        
        let elementsQuery = app.alerts["Push News"].scrollViews.otherElements
        elementsQuery.collectionViews/*@START_MENU_TOKEN@*/.textFields["Enter your news!"]/*[[".cells.textFields[\"Enter your news!\"]",".textFields[\"Enter your news!\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.buttons["Push"].tap()
        
    }
}
