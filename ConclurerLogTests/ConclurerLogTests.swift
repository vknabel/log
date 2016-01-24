//
//  ConclurerLogTests.swift
//  ConclurerLogTests
//
//  Created by Valentin Knabel on 24.01.16.
//  Copyright © 2016 Conclurer GmbH. All rights reserved.
//

import XCTest
@testable import ConclurerLog

class ConclurerLogTests: XCTestCase {

    var xcodeColorsEnabled: Bool!
    var defaultHeaderStyle: TextStyle!
    var defaultBodyStyle: TextStyle!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        defaultHeaderStyle = Log.defaultHeaderStyle
        defaultBodyStyle = Log.defaultBodyStyle
        xcodeColorsEnabled = Log.xcodeColorsEnabled
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        Log.defaultHeaderStyle = defaultHeaderStyle
        Log.defaultBodyStyle = defaultBodyStyle
        Log.xcodeColorsEnabled = xcodeColorsEnabled

        super.tearDown()
    }

    func testToggleXcodeColorsEnabled() {
        let initial = Log.xcodeColorsEnabled
        Log.xcodeColorsEnabled = !initial
        XCTAssertNotEqual(Log.xcodeColorsEnabled, initial)
        Log.xcodeColorsEnabled = initial
        XCTAssertEqual(Log.xcodeColorsEnabled, initial)
    }

    func testExample() {
        Log.xcodeColorsEnabled = true
        Log.defaultHeaderStyle = TextStyle.Colored((255, 0, 0), .Foreground)
        Log.defaultBodyStyle = TextStyle.ColoredTwice((255, 255, 255), (255, 0, 0))
        Log.print("sdfsgd")
        assert(true)
    }
    
}
