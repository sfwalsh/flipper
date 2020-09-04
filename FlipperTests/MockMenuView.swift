//
//  MockMenuView.swift
//  FlipperTests
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

@testable import Flipper

final class MockMenuView: MenuViewRepresentable, Navigatable {
    
    struct DidCall {
        var setupSubviews: Bool = false
        var reload: Bool = false
        var showActivityIndicator: Bool = false
        var hideActivityIndicator: Bool = false
    }
    
    struct DidUpdate {
        var title: String? = nil
        
        func title(toValue value: String) -> Bool {
            return title == value
        }
    }
    
    var didCall = DidCall()
    var didUpdate = DidUpdate()
    
    func applyTitle(title: String) {
        didUpdate.title = title
    }
    
    func setupSubviews() {
        didCall.setupSubviews = true
    }
    
    func reload() {
        didCall.reload = true
    }
    
    func showActivityIndicator() {
        didCall.showActivityIndicator = true
    }
    
    func hideActivityIndicator() {
        didCall.hideActivityIndicator = true
    }
    
    // MARK: Navigatable Conformance
    
    var navigationController: UINavigationController?
    
    func present(_ viewControllerToPresent: UIViewController,
                 animated flag: Bool, completion: (() -> Void)?) { }
}
