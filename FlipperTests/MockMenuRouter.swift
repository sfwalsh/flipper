//
//  MockMenuRouter.swift
//  FlipperTests
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

@testable import Flipper

final class MockMenuRouter: MenuRouterRepresentable {
    
    var view: Navigatable?
    
    struct DidUpdate {
        var alertMessage: String? = nil
        
        func alertMessage(to value: String?) -> Bool {
            return alertMessage == value
        }
    }
    
    var didUpdate: DidUpdate = DidUpdate()
    
    func presentAlert(withTitle title: String,
                      message: String,
                      options: [(String, (() -> Void))]) {
        didUpdate.alertMessage = message
    }
    
}
