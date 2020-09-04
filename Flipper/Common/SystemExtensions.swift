//
//  SystemExtensions.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviewsForAutolayout(views: [UIView]) {
        views.forEach({ addSubviewForAutolayout(view: $0) })
    }
    
    func addSubviewForAutolayout(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
