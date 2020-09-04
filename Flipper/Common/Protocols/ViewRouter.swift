//
//  ViewRouter.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

/*
 Generic Router protocol definition. Would be further implemented by other screens in the app
 */

import Foundation

protocol Router: class {
    var view: Navigatable? {get set}
}

extension Router {
    
    func attachView(view: Navigatable) {
        self.view = view
    }
}
