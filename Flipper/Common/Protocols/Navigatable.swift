//
//  Navigatable.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

/*
 convienence protocol used with AlertPresentable, and the Router functionality
 */

import Foundation

import UIKit

protocol Navigatable: class {
    var navigationController: UINavigationController? { get }
    
    func present(_ viewControllerToPresent: UIViewController,
                 animated flag: Bool,
                 completion: (() -> Void)?)
}
