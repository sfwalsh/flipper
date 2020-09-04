//
//  MenuRouter.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

final class MenuRouter: Router {

    internal weak var view: Navigatable?
    
    /*
     In a real app, the routing logic could go here
     */
}

// MARK: AlertPresentable Implementation

extension MenuRouter: AlertPresentable { }
