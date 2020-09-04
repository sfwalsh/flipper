//
//  PresenterRepresentable.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

/*
 A base Presenter protocol, ensuring consistency between different modules, and the inclusion of foundational presenter calls
 */

import Foundation

protocol PresenterRepresentable {
    func viewDidLoad()
    func viewWillAppear(animated: Bool)
    func viewDidAppear(animated: Bool)
    func viewWillDisappear(animated: Bool)
    func viewDidDisappear(animated: Bool)
}
