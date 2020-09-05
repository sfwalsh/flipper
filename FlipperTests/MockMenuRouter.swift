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
    
    struct DidCall {
        var attachView: Bool = false
        var routeToDetail: Bool = false
    }
    
    struct DidUpdate {
        var alertMessage: String? = nil
        
        func alertMessage(to value: String?) -> Bool {
            return alertMessage == value
        }
    }
    
    var didCall: DidCall = DidCall()
    var didUpdate: DidUpdate = DidUpdate()
    
    func presentAlert(withTitle title: String,
                      message: String,
                      options: [(String, (() -> Void))]) {
        didUpdate.alertMessage = message
    }
    
    func attachView(view: Navigatable) {
        self.didCall.attachView = true
     }
    
    func routeToDetail(withViewModel viewModel: MenuItemViewModel) {
        self.didCall.routeToDetail = true
    }
}
