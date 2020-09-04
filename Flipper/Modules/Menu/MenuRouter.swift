//
//  MenuRouter.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

/*
 A stub class where routing logic would go to other screens, also manages presentation of modals and alerts.
 */

final class MenuRouter: MenuRouterRepresentable {

    internal weak var view: Navigatable?
    
    /*
     In a real app, the routing logic to other views could go here
     */
}

// MARK: AlertPresentable Implementation

extension MenuRouter: AlertPresentable { }
