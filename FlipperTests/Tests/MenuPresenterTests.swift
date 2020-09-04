//
//  FlipperTests.swift
//  FlipperTests
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import XCTest
@testable import Flipper

class MenuPresenterTests: XCTestCase {
    
    // Okay to explicitly unwrap optionals here as it's in the tests
    
    var view: MockMenuView!
    var interactor: MockMenuInteractor!
    var router: MockMenuRouter!

    override func setUp() {
        let view = MockMenuView()
    }

    override func tearDown() {

    }

}
